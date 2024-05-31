################################################################################
#Bioengineering.DIP.Spring2024.BY: Dr.Saleh Hussein.
#Author: Taha Mahmoud.210100552. email: dr.taha.libya@gmail.com.
#Date: 31.05.2024
################################################################################
#Assignment 01, Problem 03
#swabing color channels
# save to output folder
################################################################################
clc , clear all , close all

% Step (b): Read the color image and display it
J1 = imread('lena512color.jpg');

% Display the original color image
figure;
imshow(J1);
title('Original Color Image (J1)');

% Step (c): Initialize the new image J2 and swap the color bands
J2 = J1;

% Swap the color bands
J2(:,:,1) = J1(:,:,3); % Red band of J2 = Blue band of J1
J2(:,:,2) = J1(:,:,1); % Green band of J2 = Red band of J1
J2(:,:,3) = J1(:,:,2); % Blue band of J2 = Green band of J1

% Display the new image with swapped color bands
figure;
subplot(1,2,1);
imshow(J1);
title('Original Image (J1) ');
subplot(1,2,2);
imshow(J2);
title('Color Image with Swapped colors (J2)');

% Step (d): Save images to output
imwrite(J1, './output/lena_original.jpeg');
imwrite(J2, './output/lena_swapped_colors.jpeg');

