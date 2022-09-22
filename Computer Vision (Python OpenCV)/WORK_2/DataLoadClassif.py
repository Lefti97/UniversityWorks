import cv2
import os
import numpy as np
import keras


# Set some parameters
IMG_WIDTH = 128
IMG_HEIGHT = 128
IMG_CHANNELS = 3
INPUT_PATH = '.\\dataset\\'

#define the format types you shall have
imgFormatType2WorkWithInput = ('PNG', 'png', 'jpeg', 'jpg')

#initialize the variables
X_train = []
ImageNamesListTrain = []
Y_train = []

X_val = []
ImageNamesListval = []
Y_val = []

X_test = []
ImageNamesListTest = []
Y_test = []

_, subCategoryDirectoriesInputSet, _ = next(os.walk(INPUT_PATH))
#_, subCategoryDirectoriesOutputSet, _ = next(os.walk(OUTPUT_PATH))

for TrainValidationOrTestIdx in range(0, subCategoryDirectoriesInputSet.__len__()):
    tmpTrainValOrTestPath = INPUT_PATH + subCategoryDirectoriesInputSet[TrainValidationOrTestIdx]
    _, SubcategorySet, _ = next(os.walk(tmpTrainValOrTestPath))
    for tmpCategoryIdx in range(0, SubcategorySet.__len__()):
        _, _, SubcategoryFiles = next(os.walk(tmpTrainValOrTestPath+'/'+ SubcategorySet[tmpCategoryIdx]))
        #print(' . we are in directory:', subCategoryDirectoriesInputSet[TrainValidationOrTestIdx], '/', SubcategorySet[tmpCategoryIdx] )
        #print(' .. there are', str(len(SubcategoryFiles)), 'available images')
        for ImageIdx in range(0, len(SubcategoryFiles)):
            # first check if we have the requested image format type
            if SubcategoryFiles[ImageIdx].endswith(imgFormatType2WorkWithInput):
                #print(' . Working on input image', SubcategoryFiles[ImageIdx], '(',
                #      str(ImageIdx + 1), '/', str(len(SubcategoryFiles)), ')')
                tmpFullImgName = INPUT_PATH + subCategoryDirectoriesInputSet[TrainValidationOrTestIdx] +\
                                 '/' + SubcategorySet[tmpCategoryIdx] +\
                                 '/' + SubcategoryFiles[ImageIdx]
                TmpImg = cv2.imread(tmpFullImgName)  # remember its height, width, chanels cv2.imread returns

                #just check that image is red correctly
                if TmpImg is not None:
                    #kill all small images
                    if (TmpImg.shape[0] < 50) | (TmpImg.shape[0] < 50):
                        #print(' . Warning: too small image size for image:', SubcategoryFiles[ImageIdx], 'Ignoring it!')
                        pass
                    else:
                        # check the image size and type remember it's according to CV2 format
                        WidthSizeCheck = TmpImg.shape[1] - IMG_WIDTH
                        HeightSizeCheck = TmpImg.shape[0] - IMG_HEIGHT
                        NumOfChannelsCheck = TmpImg.shape[2] - IMG_CHANNELS
                        if (WidthSizeCheck == 0) & (HeightSizeCheck == 0) & (NumOfChannelsCheck == 0):
                            #print(' ... image was in correct shape')
                            pass
                        else:
                            #print(' ... reshaping image')
                            TmpImg = cv2.resize(TmpImg, (IMG_WIDTH, IMG_HEIGHT), interpolation=cv2.INTER_NEAREST) #remember it's CV2 here

                        #special check that resize has not coused any unwanted problem
                        if subCategoryDirectoriesInputSet[TrainValidationOrTestIdx] == 'train':
                            X_train.append(TmpImg)
                            Y_train.append(tmpCategoryIdx)
                            ImageNamesListTrain.append(SubcategoryFiles[ImageIdx])
                        elif subCategoryDirectoriesInputSet[TrainValidationOrTestIdx] == 'test':
                            X_test.append(TmpImg)
                            Y_test.append(tmpCategoryIdx)
                            ImageNamesListTest.append(SubcategoryFiles[ImageIdx])
                        else:
                            X_val.append(TmpImg)
                            Y_val.append(tmpCategoryIdx)
                            ImageNamesListval.append(SubcategoryFiles[ImageIdx])
                else:
                    #print(' .. CV Warning: could not read image:', tmpFullImgName)
                    pass

#For CNN, your input must be a 4-D tensor [batch_size, dimension(e.g. width), dimension (e.g. height), channels]
X_train = np.array(X_train)
Y_train = np.array(Y_train)
#Y_train = np.expand_dims(Y_train, axis=3)

X_test = np.array(X_test)
Y_test = np.array(Y_test)
#   Y_test = np.expand_dims(Y_test, axis=3)

X_val = np.array(X_val)
Y_val = np.array(Y_val)
#Y_val = np.expand_dims(Y_val, axis=3)

# print(' Running the data augmentation process for the train data set')
# #here we run the data augmentation process
# data_gen_args = dict(featurewise_center=False,
#                      featurewise_std_normalization=False,
#                      rotation_range=90.,
#                      width_shift_range=0,
#                      height_shift_range=0,
#                      zoom_range=0.2)
#
# image_datagen = keras.preprocessing.image.ImageDataGenerator(**data_gen_args)
# mask_datagen = keras.preprocessing.image.ImageDataGenerator(**data_gen_args)
#
# # Provide the same seed and keyword arguments to the fit and flow methods seed = 1
# seed = 1
# image_datagen.fit(X_train, augment=True, seed=seed)
# mask_datagen.fit(Y_train, augment=True, seed=seed)
#
# # X_train_gen = image_datagen.apply_transform(X_train, data_gen_args)
# # Y_train_gen = mask_datagen.apply_transform(Y_train, data_gen_args)
#
# X_train_gen = image_datagen.flow_from_directory(INPUT_PATH, classes=['train'], class_mode=None, shuffle=False, seed=seed)
# Y_train_gen = mask_datagen.flow_from_directory(INPUT_PATH, classes=['train'], class_mode=None, shuffle=False, seed=seed)
#
# tmpImage2show = X_train_gen[0][1, :, :, :]
#
# cv2.imshow("An image", tmpImage2show.astype(np.uint8))
# cv2.imshow("Original image", X_train[1, :, :, :])
# cv2.waitKey(13000)
# cv2.destroyAllWindows()

#print('Done!')