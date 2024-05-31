################################################################################
#Bioengineering.DIP.Spring2024.BY: Dr.Saleh Hussein.
#Author: Taha Mahmoud.210100552.
#Email: dr.taha.libya@gmail.com.
#Date: 31.05.2024
# code written in GNU Octave version 9.0.1 with package image ( for DIP).
################################################################################
#Homework 1, Problem 1
# creating an image out of 2 halfs of other image
# swaping the halfs
# saving output and display
################################################################################

clc, clear all, close all
pkg load image % to load DIP package of GNU Octave

# a) reading & displaying images

% reading the images
lena = imread('lena.tif');
cameraman = imread('cameraman.tif');



% Read the images
lena = imread('lena.tif');
cameraman = imread('cameraman.tif');

# b) create blank img J and filling the columns 1:128 with the corresponding columns of lena.tif,
#    and columns 129:256 with corresponding columns from cameraman.tif.

% Initialize the new image J
J = zeros(256, 256, 'uint8');

% Fill the left half of J with the left half of Lena
J(:, 1:128) = lena(:, 1:128);

% Fill the right half of J with the right half of Cameraman
J(:, 129:256) = cameraman(:, 129:256);

# c) create blank img K and fill it with swabed halfs from J

% Initialize the new image K
K = zeros(256, 256, 'uint8');

% Swap the left and right halves of J
K(:, 1:128) = J(:, 129:256);
K(:, 129:256) = J(:, 1:128);

# d) display & save output

% Save images to output folder
imwrite(lena,'./output/lena.jpg');
imwrite(cameraman,'./output/cameraman.jpg');
imwrite(J,'./output/J.jpg');
imwrite(K,'./output/K.jpg');


% Display the images
figure;
subplot(2,2,1);
imshow(lena);
title('Lena Image');

subplot(2,2,2);
imshow(cameraman);
title('Cameraman Image');

subplot(2,2,3);
imshow(J);
title('Image J (Left half Lena, Right half Cameraman)');

subplot(2,2,4);
imshow(K);
title('Image K (Swapped halves of Image J)');

