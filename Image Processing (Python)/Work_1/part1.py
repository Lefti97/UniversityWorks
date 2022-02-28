import cv2
import numpy as np

# Υποερώτημα 1
# Η συνάρτηση επιστρέφει την εικόνα (η οποία είναι σε grayscale μορφή)
# με τα pixels τα οποία έχουν τιμή γκρί μικρότερη απο το thresValue
# να έχουν αντικατασταθεί από την αρνητική τιμή τους.
def solarize(originalImage, thresValue):
    return np.where((originalImage < thresValue), originalImage, -originalImage)

# Υποερώτημα 2
# Φορτώνουμε την εικόνα σε grayscale(flag=0)
img_gray = cv2.imread('img1.jpg', 0)
# Εφαρμόζουμε την συνάρτηση solarize με thresValue 64, 128 και 192
img_sol64 = solarize(img_gray, 64)
img_sol128 = solarize(img_gray, 128)
img_sol192 = solarize(img_gray, 192)

# Υποερώτημα 3
# Εκτύπωση αποτελεσμάτων
cv2.namedWindow('Gray', cv2.WINDOW_NORMAL)
cv2.imshow('Gray', img_gray)
cv2.namedWindow('GraySolarized64', cv2.WINDOW_NORMAL)
cv2.imshow('GraySolarized64', img_sol64)
cv2.namedWindow('GraySolarized128', cv2.WINDOW_NORMAL)
cv2.imshow('GraySolarized128', img_sol128)
cv2.namedWindow('GraySolarized192', cv2.WINDOW_NORMAL)
cv2.imshow('GraySolarized192', img_sol192)

# Αποθήκευση αποτελεσμάτων
cv2.imwrite('img1_gray.jpg', img_gray)
cv2.imwrite('img1_gray_solarized64.jpg', img_sol64)
cv2.imwrite('img1_gray_solarized128.jpg', img_sol128)
cv2.imwrite('img1_gray_solarized192.jpg', img_sol192)

# Αναμονή πλήκτρου και κλείσιμο
cv2.waitKey()
cv2.destroyAllWindows()