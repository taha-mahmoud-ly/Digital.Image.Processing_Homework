
clc
clear all
close all

pkg load image;

% Original 2x2 image
A = [255, 10;
     30, 244];

imshow(A);
imwrite(A,'A.jpg');

% Resizing the image to 6x6
scale = [6, 6];

% Nearest neighbor interpolation
nearest_img = imresize(A, scale, 'nearest');
imwrite(nearest_img,'nearest.jpg');
% Bilinear interpolation
bilinear_img = imresize(A, scale, 'bilinear');

% Bicubic interpolation
bicubic_img = imresize(A, scale, 'bicubic');
imwrite(bicubic_img,'bicubic.jpg');

% Display the results
figure;
subplot(2,2,1), imshow(A, 'InitialMagnification', 'fit'), title('Original 2x2');
subplot(2,2,2), imshow(nearest_img, 'InitialMagnification', 'fit'), title('Nearest Neighbor');
subplot(2,2,3), imshow(bilinear_img, 'InitialMagnification', 'fit'), title('Bilinear');
subplot(2,2,4), imshow(bicubic_img, 'InitialMagnification', 'fit'), title('Bicubic');

