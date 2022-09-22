import os
import numpy as np
import cv2
from sklearn.cluster import MiniBatchKMeans #KMeans
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
from sklearn import preprocessing
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC

#-----------------------------------------------------------------------------------------
#---------------- SUPPORTING FUNCTIONS GO HERE -------------------------------------------
#-----------------------------------------------------------------------------------------

# return a dictionary that holds all images category by category.
def load_images_from_folder(folder, inputImageSize, readsNum=999999999):
    reads = 0
    images = {}
    for filename in os.listdir(folder):
        category = []
        path = folder + "/" + filename
        for cat in os.listdir(path):
            if reads >= readsNum:
                break
            img = cv2.imread(path + "/" + cat)
            if img is not None:
                # grayscale it
                img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
                #resize it, if necessary
                img = cv2.resize(img, (inputImageSize[0], inputImageSize[1]))

                category.append(img)
                reads += 1
        images[filename] = category
        reads = 0
    return images


# Creates descriptors using an approach of your choise. e.g. ORB, SIFT, SURF, FREAK, MOPS, etc
# Takes one parameter that is images dictionary
# Return an array whose first index holds the decriptor_list without an order
# And the second index holds the sift_vectors dictionary which holds the descriptors but this is seperated class by class
def detector_features(images, type):
    #print(' . start detecting points and calculating features for a given image set')
    detector_vectors = {}
    descriptor_list = []
    if type == 0:
        detectorToUse = cv2.SIFT_create()
    elif type == 1:
        detectorToUse = cv2.ORB_create()
    elif type == 2:
        detectorToUse = cv2.BRISK_create()

    for nameOfCategory, availableImages in images.items():
        features = []
        tmpImgCounter = 1
        for img in availableImages: # reminder: val
            kp, des = detectorToUse.detectAndCompute(img, None)
            tmpImgCounter += 1
            if des is None:
                pass
            else:
                descriptor_list.extend(des)
                features.append(des)
        detector_vectors[nameOfCategory] = features
    return [descriptor_list, detector_vectors] # be aware of the []! this is ONE output as a list


# A k-means clustering algorithm who takes 2 parameter which is number
# of cluster(k) and the other is descriptors list(unordered 1d array)
# Returns an array that holds central points.
def kmeansVisualWordsCreation(k, descriptor_list):
    #kmeansModel = KMeans(n_clusters = k, n_init=10)
    batchSize = np.ceil(descriptor_list.__len__()/50).astype('int')
    kmeansModel = MiniBatchKMeans(n_clusters=k, batch_size=batchSize, verbose=0)
    kmeansModel.fit(descriptor_list)
    visualWords = kmeansModel.cluster_centers_ # a.k.a. centers of reference
    return visualWords, kmeansModel

#Creation of the histograms. To create our each image by a histogram. We will create a vector of k values for each
# image. For each keypoints in an image, we will find the nearest center, defined using training set
# and increase by one its value
def mapFeatureValsToHistogram (DataFeaturesByClass, visualWords, TrainedKmeansModel):
    #depenting on the approach you may not need to use all inputs
    histogramsList = []
    targetClassList = []
    numberOfBinsPerHistogram = visualWords.shape[0]

    for categoryIdx, featureValues in DataFeaturesByClass.items():
        for tmpImageFeatures in featureValues: #yes, we check one by one the values in each image for all images
            tmpImageHistogram = np.zeros(numberOfBinsPerHistogram)
            tmpIdx = list(TrainedKmeansModel.predict(tmpImageFeatures.astype('float')))
            clustervalue, visualWordMatchCounts = np.unique(tmpIdx, return_counts=True)
            tmpImageHistogram[clustervalue] = visualWordMatchCounts
            # do not forget to normalize the histogram values
            numberOfDetectedPointsInThisImage = tmpIdx.__len__()
            tmpImageHistogram = tmpImageHistogram/numberOfDetectedPointsInThisImage

            #now update the input and output coresponding lists
            histogramsList.append(tmpImageHistogram)
            targetClassList.append(categoryIdx)

    return histogramsList, targetClassList

def run_train_test(trainReads, testReads, detectorType):

    feature_extraction = ""
    if detectorType == 0:
        feature_extraction = "SIFT"
    elif detectorType == 1:
        feature_extraction = "ORB"
    elif detectorType == 2:
        feature_extraction = "BRISK"

    trainRatio = trainReads / (trainReads + testReads)
    testRatio  = testReads / (trainReads + testReads)

    #define a fixed image size to work with
    inputImageSize = [200, 200, 3] #define the FIXED size that CNN will have as input

#    TrainImagesFilePath =''
#    TestImagesFilePath = ''

    #load the train images
    trainImages = load_images_from_folder(TrainImagesFilePath, inputImageSize, trainReads)  # take all images category by category for train set

    #calculate points and descriptor values per image
    trainDataFeatures = detector_features(trainImages, detectorType)
    # Takes the descriptor list which is unordered one
    TrainDescriptorList = trainDataFeatures[0]

    #create the central points for the histograms using k means.
    #here we use a rule of the thumb to create the expected number of cluster centers
    numberOfClasses = trainImages.__len__() #retrieve num of classes from dictionary
    possibleNumOfCentersToUse = 10 * numberOfClasses
    visualWords, TrainedKmeansModel = kmeansVisualWordsCreation(possibleNumOfCentersToUse, TrainDescriptorList)

    # Takes the sift feature values that is seperated class by class for train data, we need this to calculate the histograms
    trainBoVWFeatureVals = trainDataFeatures[1]

    #create the train input train output format
    trainHistogramsList, trainTargetsList = mapFeatureValsToHistogram(trainBoVWFeatureVals, visualWords, TrainedKmeansModel)
    #X_train = np.asarray(trainHistogramsList)
    #X_train = np.concatenate(trainHistogramsList, axis=0)
    X_train = np.stack(trainHistogramsList, axis= 0)


    # Create a label (category) encoder object
    labelEncoder = preprocessing.LabelEncoder()
    labelEncoder.fit(trainTargetsList)
    #convert the categories from strings to names
    y_train = labelEncoder.transform(trainTargetsList)

    # train and evaluate the classifiers
    knn = KNeighborsClassifier()
    knn.fit(X_train, y_train)

    clf = DecisionTreeClassifier().fit(X_train, y_train)

    gnb = GaussianNB()
    gnb.fit(X_train, y_train)

    svm = SVC()
    svm.fit(X_train, y_train)

    # ----------------------------------------------------------------------------------------
    #now run the same things on the test data.
    # DO NOT FORGET: you use the same visual words, created using training set.

    #clear some space
    del trainImages, trainBoVWFeatureVals, trainDataFeatures, TrainDescriptorList

    #load the train images
    testImages = load_images_from_folder(TestImagesFilePath, inputImageSize, testReads)  # take all images category by category for train set

    #calculate points and descriptor values per image
    testDataFeatures = detector_features(testImages, detectorType)

    # Takes the sift feature values that is seperated class by class for train data, we need this to calculate the histograms
    testBoVWFeatureVals = testDataFeatures[1]

    #create the test input / test output format
    testHistogramsList, testTargetsList = mapFeatureValsToHistogram(testBoVWFeatureVals, visualWords, TrainedKmeansModel)
    X_test = np.array(testHistogramsList)
    y_test = labelEncoder.transform(testTargetsList)


    #classification tree
    # predict outcomes for test data and calculate the test scores
    y_pred_train = clf.predict(X_train)
    y_pred_test = clf.predict(X_test)
    #calculate the scores
    acc_train = accuracy_score(y_train, y_pred_train)
    acc_test = accuracy_score(y_test, y_pred_test)
    pre_train = precision_score(y_train, y_pred_train, average='macro')
    pre_test = precision_score(y_test, y_pred_test, average='macro')
    rec_train = recall_score(y_train, y_pred_train, average='macro')
    rec_test = recall_score(y_test, y_pred_test, average='macro')
    f1_train = f1_score(y_train, y_pred_train, average='macro')
    f1_test = f1_score(y_test, y_pred_test, average='macro')

    print(f'{feature_extraction},kmeans,{trainRatio}/{testRatio},Decision Tree,{acc_train:.2f},{pre_train:.2f},{rec_train:.2f},{f1_train:.2f},{acc_test:.2f},{pre_test:.2f},{rec_test:.2f},{f1_test:.2f}')

    # knn predictions
    #now check for both train and test data, how well the model learned the patterns
    y_pred_train = knn.predict(X_train)
    y_pred_test = knn.predict(X_test)
    #calculate the scores
    acc_train = accuracy_score(y_train, y_pred_train)
    acc_test = accuracy_score(y_test, y_pred_test)
    pre_train = precision_score(y_train, y_pred_train, average='macro')
    pre_test = precision_score(y_test, y_pred_test, average='macro')
    rec_train = recall_score(y_train, y_pred_train, average='macro')
    rec_test = recall_score(y_test, y_pred_test, average='macro')
    f1_train = f1_score(y_train, y_pred_train, average='macro')
    f1_test = f1_score(y_test, y_pred_test, average='macro')

    print(f'{feature_extraction},kmeans,{trainRatio}/{testRatio},K-NN,{acc_train:.2f},{pre_train:.2f},{rec_train:.2f},{f1_train:.2f},{acc_test:.2f},{pre_test:.2f},{rec_test:.2f},{f1_test:.2f}')


    #naive Bayes
    # now check for both train and test data, how well the model learned the patterns
    y_pred_train = gnb.predict(X_train)
    y_pred_test = gnb.predict(X_test)
    # calculate the scores
    acc_train = accuracy_score(y_train, y_pred_train)
    acc_test = accuracy_score(y_test, y_pred_test)
    pre_train = precision_score(y_train, y_pred_train, average='macro')
    pre_test = precision_score(y_test, y_pred_test, average='macro')
    rec_train = recall_score(y_train, y_pred_train, average='macro')
    rec_test = recall_score(y_test, y_pred_test, average='macro')
    f1_train = f1_score(y_train, y_pred_train, average='macro')
    f1_test = f1_score(y_test, y_pred_test, average='macro')

    print(f'{feature_extraction},kmeans,{trainRatio}/{testRatio},GNB,{acc_train:.2f},{pre_train:.2f},{rec_train:.2f},{f1_train:.2f},{acc_test:.2f},{pre_test:.2f},{rec_test:.2f},{f1_test:.2f}')

    #support vector machines
    # now check for both train and test data, how well the model learned the patterns
    y_pred_train = svm.predict(X_train)
    y_pred_test = svm.predict(X_test)
    # calculate the scores
    acc_train = accuracy_score(y_train, y_pred_train)
    acc_test = accuracy_score(y_test, y_pred_test)
    pre_train = precision_score(y_train, y_pred_train, average='macro')
    pre_test = precision_score(y_test, y_pred_test, average='macro')
    rec_train = recall_score(y_train, y_pred_train, average='macro')
    rec_test = recall_score(y_test, y_pred_test, average='macro')
    f1_train = f1_score(y_train, y_pred_train, average='macro')
    f1_test = f1_score(y_test, y_pred_test, average='macro')

    print(f'{feature_extraction},kmeans,{trainRatio}/{testRatio},SVM,{acc_train:.2f},{pre_train:.2f},{rec_train:.2f},{f1_train:.2f},{acc_test:.2f},{pre_test:.2f},{rec_test:.2f},{f1_test:.2f}')

print('FeatureExtraction,Clustering Detection,Train/Test Data ratio,Classifier Used,Accuracy(tr),Precision(tr),Recall(tr),F1 score(tr),Accuracy(te),Precision(te),Recal(te),F1 score(te)')

run_train_test(80, 20, 0)
run_train_test(60, 40, 0)

run_train_test(80, 20, 1)
run_train_test(60, 40, 1)

run_train_test(80, 20, 2)
run_train_test(60, 40, 2)

