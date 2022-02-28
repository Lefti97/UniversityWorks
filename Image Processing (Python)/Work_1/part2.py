import cv2
import numpy as np
from skimage.metrics import structural_similarity as ssim
from skimage.metrics import mean_squared_error as mse
import random

# Salt & Pepper απο Lab1Codes.py
def saltAndPepper(anImage, prob):
    noisy_image = np.zeros(anImage.shape, np.uint8)
    for rowIdx in range(anImage.shape[0]):
        for colIdx in range(anImage.shape[1]):
            rand = random.random()
            if rand < prob:
                noisy_image[rowIdx][colIdx] = 0
            elif rand > (1 - prob):
                noisy_image[rowIdx][colIdx] = 255
            else:
                noisy_image[rowIdx][colIdx] = anImage[rowIdx][colIdx]

    return noisy_image

# Παρομοιο με το saltAndPepper αλλά βάζει το χρώμα γκρι
def grayNoise(anImage, prob):
    noisy_image = np.zeros(anImage.shape, np.uint8)
    for rowIdx in range(anImage.shape[0]):
        for colIdx in range(anImage.shape[1]):
            rand = random.random()
            if rand < prob: 
                noisy_image[rowIdx][colIdx] = 128
            else:
                noisy_image[rowIdx][colIdx] = anImage[rowIdx][colIdx]

    return noisy_image

# Υποερώτημα 1
# Φορτώνει την εικόνα σε grayscale(flag=0)
img = cv2.imread('img2.jpg', 0)

# Υποερώτημα 2
# Εισάγει θόρυβο Salt & pepper 10%
img_saltpepper = saltAndPepper(img, 0.1)
# Εισάγει θόρυβο grayNoise
img_grayNoise = grayNoise(img, 0.2)

# Υποερώτημα 3
# Εμφάνιση εικόνας (αρχική και με θόρυβο)
cv2.namedWindow('img', cv2.WINDOW_NORMAL)
cv2.imshow('img', img)
cv2.namedWindow('img_saltpepper', cv2.WINDOW_NORMAL)
cv2.imshow('img_saltpepper', img_saltpepper)
cv2.namedWindow('img_grayNoise', cv2.WINDOW_NORMAL)
cv2.imshow('img_grayNoise', img_grayNoise)

# Υποερώτημα 4
# Αφαιρεί τον θόρυβο με τρία διαφορετικά φίλτρα
# blur, GaussianBlur, medianBlur
img_saltpepper_blur = cv2.blur(img_saltpepper,(5,5))
img_saltpepper_GaussianBlur = cv2.GaussianBlur(img_saltpepper,(5,5),0)
img_saltpepper_medianBlur = cv2.medianBlur(img_saltpepper, 5)

img_grayNoise_blur = cv2.blur(img_grayNoise,(5,5))
img_grayNoise_GaussianBlur = cv2.GaussianBlur(img_grayNoise,(5,5),0)
img_grayNoise_medianBlur = cv2.medianBlur(img_grayNoise, 5)

# Υποερώτημα 5
# Εμφάνιση εικόνας με θόρυβο
cv2.namedWindow('img_saltpepper_blur', cv2.WINDOW_NORMAL)
cv2.imshow('img_saltpepper_blur', img_saltpepper_blur)
cv2.namedWindow('img_saltpepper_GaussianBlur', cv2.WINDOW_NORMAL)
cv2.imshow('img_saltpepper_GaussianBlur', img_saltpepper_GaussianBlur)
cv2.namedWindow('img_saltpepper_medianBlur', cv2.WINDOW_NORMAL)
cv2.imshow('img_saltpepper_medianBlur', img_saltpepper_medianBlur)

cv2.namedWindow('img_grayNoise_blur', cv2.WINDOW_NORMAL)
cv2.imshow('img_grayNoise_blur', img_grayNoise_blur)
cv2.namedWindow('img_grayNoise_GaussianBlur', cv2.WINDOW_NORMAL)
cv2.imshow('img_grayNoise_GaussianBlur', img_grayNoise_GaussianBlur)
cv2.namedWindow('img_grayNoise_medianBlur', cv2.WINDOW_NORMAL)
cv2.imshow('img_grayNoise_medianBlur', img_grayNoise_medianBlur)

# Υποερώτημα 6
# Σύγκριση εικόνων με θόρυβο με την αρχική

# a) Μετρική Structural Similarity Index (SSIM)
ssim_saltpepper_blur , _ = ssim(img, img_saltpepper_blur, full=True)
ssim_saltpepper_GaussianBlur , _ = ssim(img, img_saltpepper_GaussianBlur, full=True)
ssim_saltpepper_medianBlur , _  = ssim(img, img_saltpepper_medianBlur, full=True)
ssim_grayNoise_blur , _ = ssim(img, img_grayNoise_blur, full=True)
ssim_grayNoise_GaussianBlur , _ = ssim(img, img_grayNoise_GaussianBlur, full=True)
ssim_grayNoise_medianBlur , _ = ssim(img, img_grayNoise_medianBlur, full=True)

print('SSIM saltpepper_blur\t{:.3f}'.format(ssim_saltpepper_blur))
print('SSIM saltpepper_GaussianBlur\t{:.3f}'.format(ssim_saltpepper_GaussianBlur))
print('SSIM saltpepper_medianBlur\t{:.3f}'.format(ssim_saltpepper_medianBlur))

print('SSIM grayNoise_blur\t{:.3f}'.format(ssim_grayNoise_blur))
print('SSIM grayNoise_GaussianBlur\t{:.3f}'.format(ssim_grayNoise_GaussianBlur))
print('SSIM grayNoise_medianBlur\t{:.3f}'.format(ssim_grayNoise_medianBlur))
print()

# b) Μετρική Mean Square Error (MSE)
mse_saltpepper_blur = mse(img, img_saltpepper_blur)
mse_saltpepper_GaussianBlur = mse(img, img_saltpepper_GaussianBlur)
mse_saltpepper_medianBlur = mse(img, img_saltpepper_medianBlur)
mse_grayNoise_blur = mse(img, img_grayNoise_blur)
mse_grayNoise_GaussianBlur = mse(img, img_grayNoise_GaussianBlur)
mse_grayNoise_medianBlur = mse(img, img_grayNoise_medianBlur)

print('MSE saltpepper_blur\t{:.3f}'.format(mse_saltpepper_blur))
print('MSE saltpepper_GaussianBlur\t{:.3f}'.format(mse_saltpepper_GaussianBlur))
print('MSE saltpepper_medianBlur\t{:.3f}'.format(mse_saltpepper_medianBlur))

print('MSE grayNoise_blur\t{:.3f}'.format(mse_grayNoise_blur))
print('MSE grayNoise_GaussianBlur\t{:.3f}'.format(mse_grayNoise_GaussianBlur))
print('MSE grayNoise_medianBlur\t{:.3f}'.format(mse_grayNoise_medianBlur))

# Αποθήκευση αποτελεσμάτων
cv2.imwrite('img2_grayscale.jpg', img)
cv2.imwrite('img2_saltpepper.jpg', img_saltpepper)
cv2.imwrite('img2_saltpepper_blur.jpg', img_saltpepper_blur)
cv2.imwrite('img2_saltpepper_GaussianBlur.jpg', img_saltpepper_GaussianBlur)
cv2.imwrite('img2_saltpepper_medianBlur.jpg', img_saltpepper_medianBlur)
cv2.imwrite('img2_grayNoise.jpg', img_grayNoise)
cv2.imwrite('img2_grayNoise_blur.jpg', img_grayNoise_blur)
cv2.imwrite('img2_grayNoise_GaussianBlur.jpg', img_grayNoise_GaussianBlur)
cv2.imwrite('img2_grayNoise_medianBlur.jpg', img_grayNoise_medianBlur)

# Αναμονή πλήκτρου και κλείσιμο
cv2.waitKey()
cv2.destroyAllWindows()