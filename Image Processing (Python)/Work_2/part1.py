import cv2
import numpy as np
import matplotlib.pyplot as plt

# Παρουσίαση 2D διαγράμματος 
def plotHist(anImage,labels,title):
    channels = cv2.split(anImage)

    hists = []
    for channel in channels:
        imgNormHist = cv2.calcHist([channel], [0], None, [256], [0, 256])
        imgNormHist = imgNormHist / sum(imgNormHist)
        hists.append(imgNormHist)

    plt.figure()
    i = 0
    for hist in hists:
        plt.plot(hist, label=labels[i])
        i+=1

    plt.title(title)
    plt.legend()
    plt.savefig(title+'.jpg')

# Kmeans αλγόριθμος κατάτμησης εικόνας
def seg_kmeans(pixels, Κ):
    pixel_values = pixels.reshape(-1,3)
    pixel_values = np.float32(pixel_values)

    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)
    ret,label,center=cv2.kmeans(pixel_values,Κ,None,criteria,10,cv2.KMEANS_RANDOM_CENTERS)

    center = np.uint8(center)
    res = center[label.flatten()]
    return res.reshape(pixels.shape)

# MeanShift αλγόριθμος κατάτμησης εικόνας
def seg_meanShift(pixels):
    term_crit = ( cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 1 )
    mask = cv2.inRange(pixels, np.array((0., 60.,32.)), np.array((180.,255.,255.)))
    hist = cv2.calcHist([pixels],[0],mask,[256],[0,256])
    dst = cv2.calcBackProject([pixels],[0],hist,[0,256],1)
    _, track_window = cv2.meanShift(dst, (0, 0, 350, 350), term_crit)
    x,y,w,h = track_window
    return cv2.rectangle(pixels, (x,y), (x+w,y+h), 255,2)

# Υποερώτημα 1
# Φόρτωση εικόνας
img = cv2.imread('img1.jpg')
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
pixel_colors = img.reshape(-1,3)/255.

r,g,b = cv2.split(img)

# 3D διάγραμμα RGB χώρου χρώματος
plt.figure()
ax1 = plt.axes(projection='3d')
ax1.scatter(r, g, b, c=pixel_colors)
ax1.set_xlabel('Red')
ax1.set_ylabel('Green')
ax1.set_zlabel('Blue')
ax1.set_title('RGB_Image_scatter_plot')
plt.savefig('RGB_Image_scatter_plot.jpg')

# Υποερώτημα 2
# Μετατροπή εικόνας απο RGB σε HSV
img_hsv = cv2.cvtColor(img, cv2.COLOR_RGB2HSV)
h,s,v = cv2.split(img_hsv)

# 3D διάγραμμα HSV χώρου χρώματος
plt.figure()
ax2 = plt.axes(projection='3d')
ax2.scatter(h, s, v, c=pixel_colors)
ax2.set_xlabel('Hue')
ax2.set_ylabel('Saturation')
ax2.set_zlabel('Value')
ax2.set_title('HSV_Image_scatter_plot')
plt.savefig('HSV_Image_scatter_plot.jpg')

# Υποερώτημα 3
# 2D διαγράμματα επιμέρους καναλιών χρωμάτων RGB και HSV
plotHist(img,['Red', 'Green', 'Blue'], 'RGB_image_plot')
plotHist(img_hsv,['Hue', 'Saturation', 'Value'], 'HSV_image_plot')

# Υποερώτημα 4
# RGB kmeans κατάτμηση
rgb_kmeans = seg_kmeans(img, 3)
cv2.imshow('rgb_kmeans',rgb_kmeans)
cv2.imwrite('img1_rgb_kmeans.jpg',rgb_kmeans)

# RGB meanShift κατάτμηση
rgb_meanShift = seg_meanShift(img)
cv2.imshow('rgb_meanShift',rgb_meanShift)
cv2.imwrite('img1_rgb_meanShift.jpg',rgb_meanShift)

# HSV kmeans κατάτμηση
hsv_kmeans = seg_kmeans(img_hsv, 3)
cv2.imshow('hsv_kmeans',hsv_kmeans)
cv2.imwrite('img1_hsv_kmeans.jpg',hsv_kmeans)

# HSV meanShift κατάτμηση
hsv_meanShift = seg_meanShift(img_hsv)
cv2.imshow('hsv_meanShift',hsv_meanShift)
cv2.imwrite('img1_hsv_meanShift.jpg',hsv_meanShift)

# RGB+HSV kmeans κατάτμηση
merged_rgb_hsv = cv2.merge([img, img_hsv])
rgb_hsv_kmeans = seg_kmeans(merged_rgb_hsv, 3)

# Υποερώτημα 5
# 2D διαγράματα αποτελεσμάτων υποερωτήματος 4
plotHist(rgb_kmeans,['Red','Green','Blue'],'RGB_segmentation_kmeans')
plotHist(rgb_meanShift,['Red','Green','Blue'],'RGB_segmentation_meanShift')
plotHist(hsv_kmeans,['Hue','Saturation','Value'],'HSV_segmentation_kmeans')
plotHist(hsv_meanShift,['Hue','Saturation','Value'],'HSV_segmentation_meanShift')
plotHist(rgb_hsv_kmeans,['Red','Green','Blue','Hue','Saturation','Value'],'RGB_HSV_segmentation_kmeans')

plt.show()
cv2.waitKey()
cv2.destroyAllWindows()