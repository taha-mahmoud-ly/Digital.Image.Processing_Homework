%###############################################################################
%#Bioengineering.DIP.Spring2024.BY: Dr.Saleh Hussein.
%#Author: Taha Mahmoud.210100552. email: dr.taha.libya@gmail.com.
%#Date: 05.06.2024
%################################################################################
%#  Assignment02: Problem 1.1
%#      custome histogram and histogram equalization
%################################################################################
clc
clear all
close all


img = imread("einstein.tif");
%imshow(j);


%##########################################################################
%    histogram of original image
%##########################################################################

garyLevels = 256;
numberOfPixels = size(img,1)*size(img,2);

holderArray = zeros([1,garyLevels]); % initialize empty 1D array

[row,col] = size(img);

%iteration
for i = 1:row %loop over rows
    for j = 1:col %loop over col
        idx = img(i,j);
        %display(i) ; 
        holderArray(idx) = holderArray(idx)+1;  
    end
end


%##########################################################################
% histogram equalization
%##########################################################################

% holderArray = n_k
% gray level 0:255
% numberOfPixels definde above = n
% PDF = n_k/n

PDF = holderArray/numberOfPixels;
%check
PDF_sum = sum(PDF);
disp(['PDF sum = ' num2str(PDF_sum), '.']); % must be 1

%CDF cumulative sum PDF 
CDF = cumsum(PDF);
%check
disp(['CDF = ' num2str(CDF(256)), '.']); % must be 1


% maximum gray level = 255
% raw equlaized level = CDF* max gary level 
eqGL = CDF.*255;
% rounding equalized level
equalizedHistogramValues = round(eqGL);


%##########################################################################
% equalized image
%##########################################################################

% Create a mapping function (lookup table) using the equalized histogram

mapping_function = uint8(eqGL);

% Apply the mapping function to the original image
equalized_image = mapping_function(img );

%##########################################################################
% histogram of equalized image
%##########################################################################


[row2,col2] = size(equalized_image);
eqHolderArray = zeros([1,garyLevels]);

%iteration  through equalized image

for x = 1:row2 %loop over rows
    for y = 1:col2 %loop over cols
        eq_idx = equalized_image(x,y)+1;
        %display(ii) ; 
        eqHolderArray(eq_idx) = eqHolderArray(eq_idx)+1;

   
    end
end

%##########################################################################
% Display 
%##########################################################################

figure;
subplot(2, 2, 1);
imshow(img);
title('Original Image');

subplot(2, 2, 2);
imshow(equalized_image);
title('Equalized Image');

subplot(2, 2, 3);
bar(0:255,holderArray);
title('Original Image Histogram');

subplot(2, 2, 4);
bar(0:255,eqHolderArray);
title('Equalized Image Histogram');

