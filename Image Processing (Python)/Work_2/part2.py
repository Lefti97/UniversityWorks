import cv2
import numpy as np
import matplotlib.pyplot as plt
from skimage.metrics import structural_similarity as ssim

# Πρόσθεση Γκαουσιανού θορύβου
def gauss_noise(image):
    image = np.array(image/255, dtype=float)
    noise = np.random.normal(0, 0.005 ** 0.5, image.shape)
    out = image + noise
    if out.min() < 0:
        low_clip = -1.
    else:
        low_clip = 0.
    out = np.clip(out, low_clip, 1.0)
    out = np.uint8(out*255)
    return out

# Υποερώτημα 1
# Φόρτωση εικόνας σε grayscale
img = cv2.imread('img2.jpg', 0)
cv2.imshow("Original greycale image", img)
cv2.imwrite("img2_grayscale.jpg",img)

# Υποερώτημα 2
# Ανίχνευση ακμών με τεχνική Canny
img_canny = cv2.Canny(img, 100, 200)
cv2.imshow("Canny Image", img_canny)
cv2.imwrite("img2_canny.jpg",img_canny)

# Υποερώτημα 3
# Πρόσθεση Γκαουσιανο θόρυβο στην αρχική εικόνα
img_gaussBlur = gauss_noise(img)
cv2.imshow("Gaussian Noise Image", img_gaussBlur)
cv2.imwrite("img2_gaussBlur.jpg",img_gaussBlur)

# Υποερώτημα 4
# Αφαίρεση θορύβου με φίλτρο median
img_smoothed = cv2.medianBlur(img_gaussBlur,5)
cv2.imshow("Median Smoothed Image", img_smoothed)
cv2.imwrite("img2_smoothed.jpg",img_smoothed)

# Υποερώτημα 5
# Ανίχνευση ακμών στην διορθωμένη εικόνα
img_smoothed_canny = cv2.Canny(img_smoothed, 100, 200)
cv2.imshow("Canny Image Median Smoothed", img_smoothed_canny)
cv2.imwrite("img2_smoothed_canny.jpg",img_smoothed_canny)

# Υποερώτημα 6
# Σύγκριση ακμών διορθωμένης εικόνας και αρχικής (με μετρική SSIM)
ssim_canny_smoothed , _ = ssim(img_canny, img_smoothed_canny, full=True)
print('SSIM Original Canny - Smoothed Canny\t{:.3f}'.format(ssim_canny_smoothed))

# Υποερώτημα 7
# Εφαρμογή μορφολογίας Dilation και Erosion στην εικόνα με Γκαουσιανό θόρυβο
kernel = np.ones((3,3), np.uint8)
img_gaussBlur_dilation = cv2.dilate(img_gaussBlur,kernel=kernel,iterations=1)
img_gaussBlur_erosion = cv2.erode(img_gaussBlur,kernel=kernel,iterations=1)

# Ανίχνευση ακμών με τεχνική Canny στις δύο προηγούμενες εικόνες
img_gaussBlur_dilation_canny = cv2.Canny(img_gaussBlur_dilation, 100, 200)
img_gaussBlur_erosion_canny = cv2.Canny(img_gaussBlur_erosion, 100, 200)

# Εκτύπωση αποτελεσμάτων
cv2.imshow("Gaussian Noise Dilated image", img_gaussBlur_dilation)
cv2.imwrite("img2_gaussBlur_dilation.jpg",img_gaussBlur_dilation)
cv2.imshow("Gaussian Noise Eroded image", img_gaussBlur_erosion)
cv2.imwrite("img2_gaussBlur_erosion.jpg",img_gaussBlur_erosion)
cv2.imshow("Gaussian Noise Dilated Canny Image", img_gaussBlur_dilation_canny)
cv2.imwrite("img2_gaussBlur_dilation_canny.jpg",img_gaussBlur_dilation_canny)
cv2.imshow("Gaussian Noise Eroded Canny Image", img_gaussBlur_erosion_canny)
cv2.imwrite("img2_gaussBlur_erosion_canny.jpg",img_gaussBlur_erosion_canny)

# Σύγκριση(με μετρική SSIM) ακμών εικόνας με Dilation και Erosion με της 
# ακμές της αρχικής 
ssim_canny_eroded , _ = ssim(img_canny, img_gaussBlur_erosion_canny, full=True)
print('SSIM Original Canny - Eroded Canny\t{:.3f}'.format(ssim_canny_eroded))
ssim_canny_dilated , _ = ssim(img_canny, img_gaussBlur_dilation_canny, full=True)
print('SSIM Original Canny - Dilated Canny\t{:.3f}'.format(ssim_canny_dilated))

plt.show()
cv2.waitKey()
cv2.destroyAllWindows()