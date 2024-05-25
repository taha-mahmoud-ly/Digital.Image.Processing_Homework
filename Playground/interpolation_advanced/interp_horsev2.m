################################################################################
#Bioengineering.DIP.Spring2024.BY: Dr.Saleh Hussein.
#Author: Taha Mahmoud.210100552.
#Email: dr.taha.libya@gmail.com.
#Date: 25.05.2024
# code written in GNU Octave version 7.3.0 with package image ( for DIP).
################################################################################
#Assignment 1, Problem 1
# functions [ imread, imshow, imwrite] included in the code.
# image is upscaled by 4X,with different interpolation methods:
# [nearest_neighbor, bilinear, bicubic, spline ]
################################################################################

clc, clear all, close all

% Load a black and white (grayscale) image
img = imread('horse.jpg');


% Convert image to grayscale

img = rgb2gray(img);

% Get the size of the image
[rows, cols] = size(img);

% Define the scale factor for resizing
scaleFactor = 2;

% Define the new grid for interpolation
[x, y] = meshgrid(1:scaleFactor:cols, 1:scaleFactor:rows);
new_x = linspace(1, cols, scaleFactor * cols);
new_y = linspace(1, rows, scaleFactor * rows)';

% Initialize matrices to hold the interpolated images
nearest_img = zeros(scaleFactor * rows, scaleFactor * cols);
bilinear_img = zeros(scaleFactor * rows, scaleFactor * cols);
bicubic_img = zeros(scaleFactor * rows, scaleFactor * cols);
spline_img = zeros(scaleFactor * rows, scaleFactor * cols);

% Convert the image to double
img_double = double(img);

% Perform nearest-neighbor interpolation
nearest_img = interp2(img_double, new_x, new_y, 'nearest');

% Perform bilinear interpolation
bilinear_img = interp2(img_double, new_x, new_y, 'linear');

% Perform bicubic interpolation
bicubic_img = interp2(img_double, new_x, new_y, 'cubic');

% Perform spline interpolation
spline_img = interp2(img_double, new_x, new_y, 'spline');

% Convert interpolated images back to uint8
nearest_img = uint8(nearest_img);
bilinear_img = uint8(bilinear_img);
bicubic_img = uint8(bicubic_img);
spline_img = uint8(spline_img);

% Save the images to disk
imwrite(nearest_img, 'nearest_neighbor.png');
imwrite(bilinear_img, 'bilinear.png');
imwrite(bicubic_img, 'bicubic.png');
imwrite(spline_img, 'spline.png');

% Display the original and interpolated images
figure;

subplot(2, 3, 1);
imshow(img);
title('Original Image');

subplot(2, 3, 2);
imshow(nearest_img);
title('Nearest Neighbor');

subplot(2, 3, 3);
imshow(bilinear_img);
title('Bilinear');

subplot(2, 3, 4);
imshow(bicubic_img);
title('Bicubic');

subplot(2, 3, 5);
imshow(spline_img);
title('Spline');
