%###############################################################################
%#Bioengineering.DIP.Spring2024.BY: Dr.Saleh Hussein.
%#Author: Taha Mahmoud.210100552. email: dr.taha.libya@gmail.com.
%#Date: 06.06.2024
%################################################################################
%#Assignment
%# Power-law transformation s = cr^(gamma)
%################################################################################

clc;
clear;
close all;

% c =1 , omitted from the code

% gamma values, 
gamma1 = 0.4;  
gamma2 = 3.0;
gamma3 = 4.0;
gamma4 = 5.0;

% Read the original image
originalImage = imread("washed_out_aerial.tif");

% Normalize image to the range [0, 1] for gamma correction
% Convert image to double precision and scale to [0, 1]
normalizedImage = double(originalImage) / 255;

% Apply gamma correction

transformedImage1 = normalizedImage .^ gamma1;
transformedImage2 = normalizedImage .^ gamma2;
transformedImage3 = normalizedImage .^ gamma3;
transformedImage4 = normalizedImage .^ gamma4;

% Scale back to the range [0, 255] and convert to uint8
% Multiply by 255 and convert to uint8 to prepare for display
transformedImage1 = uint8(transformedImage1 * 255);
transformedImage2 = uint8(transformedImage2 * 255);
transformedImage3 = uint8(transformedImage3 * 255);
transformedImage4 = uint8(transformedImage4 * 255);

% Display the transformed image
figure;
subplot(2,2,1)
imshow(transformedImage1);
title(['Gamma = ', num2str(gamma1)]);

subplot(2,2,2)
imshow(transformedImage2);
title(['Gamma = ', num2str(gamma2)]);

subplot(2,2,3)
imshow(transformedImage3);
title(['Gamma = ', num2str(gamma3)]);

subplot(2,2,4)
imshow(transformedImage4);
title(['Gamma = ', num2str(gamma4)]);


