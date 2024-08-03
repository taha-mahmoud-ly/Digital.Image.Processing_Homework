% sobel3.m
clc;
clear;

% Main script
% Load the input image
image = imread('question_3.tif');

% Convert to grayscale if necessary
if size(image, 3) == 3
    image = rgb2gray(image);
end

% Define the Sobel kernels
Gx = [-1 -2 -1;
       0  0  0;
       1  2  1];
Gy = [-1  0  1;
      -2  0  2;
      -1  0  1];

% Apply the custom convolution function
Gx_custom = custom_conv2(image, Gx);
Gy_custom = custom_conv2(image, Gy);

% Calculate the gradient magnitude for the custom convolution
G_custom = sqrt(Gx_custom.^2 + Gy_custom.^2);

% Normalize the gradient magnitude to the range [0, 255]
G_custom = uint8(255 * mat2gray(G_custom));

% Apply the built-in imfilter function
Gx_builtin = imfilter(double(image), Gx, 'conv', 'same', 'replicate');
Gy_builtin = imfilter(double(image), Gy, 'conv', 'same', 'replicate');

% Calculate the gradient magnitude for the built-in convolution
G_builtin = sqrt(Gx_builtin.^2 + Gy_builtin.^2);

% Normalize the gradient magnitude to the range [0, 255]
G_builtin = uint8(255 * mat2gray(G_builtin));

% Display the original image, custom convolution result, and built-in convolution result
figure;

subplot(1, 3, 1);
imshow(image);
title('Original Image');

subplot(1, 3, 2);
imshow(G_custom);
title('Custom Convolution Sobel');

subplot(1, 3, 3);
imshow(G_builtin);
title('Built-in imfilter Sobel');

% Nested custom convolution function
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

