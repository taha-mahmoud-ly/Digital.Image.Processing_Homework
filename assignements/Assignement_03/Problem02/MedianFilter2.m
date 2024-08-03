clc;
close all;
clear all;
image = imread('question_2.tif');

% Custom median filter
function output = custom_median(image)
    % Get the size of the image
    [image_rows, image_cols] = size(image);

    % Calculate the amount of padding needed
    pad_size_row = 1;
    pad_size_col = 1;

    % Pad the image with zeros
    padded_image = padarray(image, [pad_size_row, pad_size_col], 0, 'both');

    % Initialize the output image
    output = zeros(image_rows, image_cols);

    % Perform the median filtering
    for i = 1:image_rows
        for j = 1:image_cols
            % Extract the region of interest from the padded image
            region = padded_image(i:i+2, j:j+2);
            % Replace the pixel with the median value of the region
            output(i, j) = median(region(:));
        end
    end
end

if size(image, 3) == 3
    image = rgb2gray(image);  % Convert to grayscale if it's a color image
end

% Apply the custom median filter
filtered_image = custom_median(image);

% Apply the built-in median filter
filtered_image2 = medfilt2(image, [3 3]);

% Display the original and filtered images
figure;
subplot(1, 3, 1);
imshow(image);
title('Original Image');

subplot(1, 3, 2);
imshow(uint8(filtered_image));
title('Custom Filtered Image');

subplot(1, 3, 3);
imshow(uint8(filtered_image2));
title('Built-in Filtered Image');
