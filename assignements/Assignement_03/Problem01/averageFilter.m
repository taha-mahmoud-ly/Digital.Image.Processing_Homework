clc;
close all;
image = imread('question_1.tif');

% custome convolution

function output = custom_conv2(image, kernel)
    % Convert image to double for precision
    image = double(image);

    % Get the size of the image and the kernel
    [image_rows, image_cols] = size(image);
    [kernel_rows, kernel_cols] = size(kernel);

    % Calculate the amount of padding needed
    pad_size_row = floor(kernel_rows / 2);
    pad_size_col = floor(kernel_cols / 2);

    % Pad the image with zeros
    padded_image = padarray(image, [pad_size_row, pad_size_col], 0, 'both');

    % Initialize the output image
    output = zeros(image_rows, image_cols);

    % Perform the convolution
    for i = 1:image_rows
        for j = 1:image_cols
            % Extract the region of interest from the padded image
            region = padded_image(i:i+kernel_rows-1, j:j+kernel_cols-1);
            % Perform element-wise multiplication and sum the result
            output(i, j) = sum(sum(region .* kernel));
        end
    end
end



if size(image, 3) == 3
    image = rgb2gray(image);  % Convert to grayscale if it's a color image
end

% Step 2: Define the kernel
kernel = ones(15,15)/225;
% Step 3: Apply the filter
filtered_image = custom_conv2(image, kernel);

% Step 4: Display the original and filtered images
subplot(1, 2, 1);
imshow(image);
title('Original Image');

subplot(1, 2, 2);
imshow(uint8(filtered_image));
title('Filtered Image');





