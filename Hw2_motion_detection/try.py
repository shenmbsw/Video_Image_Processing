# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import cv2 as cv


cap = cv.VideoCapture('test.mp4')
print('a')
i = 0
while(cap.isOpened()):
    print('a')
    ret, frame = cap.read()
    gray = cv.cvtColor(frame, cv.COLOR_BGR2GRAY)
    cv.imwrite('a'+str(i)+'.jpg',gray)
    i = i+1
