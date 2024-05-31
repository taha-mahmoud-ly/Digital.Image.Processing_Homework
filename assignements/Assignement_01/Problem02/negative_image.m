################################################################################
#Bioengineering.DIP.Spring2024.BY: Dr.Saleh Hussein.
#Author: Taha Mahmoud.210100552. email: dr.taha.libya@gmail.com.
#Date: 31.05.2024
################################################################################
#Assignment 01, Problem 02
#negative image
################################################################################
clc , clear all , close all

J1 = imread('barbara.jpg');
J2 = 255 - J1;

% Save images
imwrite(J1,'./output/J1.jpeg');
imwrite(J2,'./output/J2.jpeg');



%Display
figure;
subplot(1,2,1); imshow(J1); title('Original Image');
subplot(1,2,2); imshow(J2); title('Negative Image');


