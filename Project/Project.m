clc;
close all;
clear all;

% Read and preprocess the image
original_image = imread('projectImage.tif');
if size(original_image, 3) == 3
    original_image = rgb2gray(original_image);  % Convert to grayscale if it's a color image
end

% Convert the image to double for precision
original_image = double(original_image);

% Create output directory if it doesn't exist
output_folder = 'output';
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

% Custom convolution function
function output = custom_conv2(image, kernel)
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Sobel Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the Sobel kernels
Gx = [-1 -2 -1; 0 0 0; 1 2 1];
Gy = [-1 0 1; -2 0 2; -1 0 1];

% Apply the custom convolution function
Gx_custom = custom_conv2(original_image, Gx);
Gy_custom = custom_conv2(original_image, Gy);

% Calculate the gradient magnitude for the custom convolution
G_custom = sqrt(Gx_custom.^2 + Gy_custom.^2);

% Keep the Sobel filtered image as double
sobel_filtered = G_custom;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% 5x5 Averaging Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the kernel
kernel = ones(5,5) / 25;

% Apply the filter
averaged_image = custom_conv2(sobel_filtered, kernel);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% 8-directional Positive Laplacian
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the Laplacian kernel
laplacian_kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];

% Apply the Laplacian filter using the custom convolution function
laplacian_filtered_image = custom_conv2(original_image, laplacian_kernel);

% Add the filtered image to the original image
laplacian_sharpened_image = imadd(original_image, laplacian_filtered_image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Masked Image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Normalize sobel_filtered and laplacian_sharpened_image
sobel_filtered_norm = mat2gray(sobel_filtered);
laplacian_sharpened_image_norm = mat2gray(laplacian_sharpened_image);

% Multiply the normalized images
masked_image = immultiply(sobel_filtered_norm, laplacian_sharpened_image_norm);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Final Sharpened Image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Normalize original image and masked image to [0, 1] range
original_image_norm = mat2gray(original_image);
masked_image_norm = mat2gray(masked_image);

% Add the normalized images
final_sharpened_image_norm = imadd(original_image_norm, masked_image_norm);

% Scale back to [0, 255]
final_sharpened_image = final_sharpened_image_norm * 255;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Gamma Correction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Gamma Correction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Experiment with different gamma values
gamma_values = [0.3, 0.35, 0.4, 0.45, 0.5, 0.55];
gamma_corrected_images = cell(1, numel(gamma_values));

for i = 1:numel(gamma_values)
    gamma = gamma_values(i);
    % Apply gamma correction
    gamma_corrected_image = final_sharpened_image .^ gamma;

    % Scale the gamma-corrected image to [0, 255]
    gamma_corrected_image = 255 * (gamma_corrected_image / max(gamma_corrected_image(:)));

    % Store the gamma corrected image
    gamma_corrected_images{i} = gamma_corrected_image;

    % Convert to uint8 and save the gamma corrected image
    imwrite(uint8(gamma_corrected_image), fullfile(output_folder, ['gamma_corrected_', num2str(gamma), '.tif']));
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Display and Save Results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Display the images
figure;
subplot(2, 3, 1);
imshow(uint8(original_image), []);
title('Original Image');
imwrite(uint8(original_image), fullfile(output_folder, 'original_image.tif'));

subplot(2, 3, 2);
imshow(sobel_filtered, []);
title('Sobel Filtered Image');
imwrite(uint8(sobel_filtered), fullfile(output_folder, 'sobel_filtered.tif'));

subplot(2, 3, 3);
imshow(averaged_image, []);
title('Averaged Sobel Filtered Image');
imwrite(uint8(averaged_image), fullfile(output_folder, 'averaged_image.tif'));

subplot(2, 3, 4);
imshow(laplacian_filtered_image, []); % Using [] to scale intensity values for display
title('Laplacian Filtered Image');
imwrite(uint8(laplacian_filtered_image), fullfile(output_folder, 'laplacian_filtered_image.tif'));

subplot(2, 3, 5);
imshow(masked_image, []); % Using [] to scale intensity values for display
title('Masked Image');
imwrite(uint8(masked_image), fullfile(output_folder, 'masked_image.tif'));

subplot(2, 3, 6);
imshow(final_sharpened_image, []);
title('Final Sharpened Image');
imwrite(uint8(final_sharpened_image), fullfile(output_folder, 'final_sharpened_image.tif'));

% Display gamma corrected images
figure;
for i = 1:numel(gamma_values)
    gamma = gamma_values(i);
    gamma_corrected_image = gamma_corrected_images{i};

    subplot(2, 3, i);
    imshow(uint8(gamma_corrected_image), []);
    title(['Gamma = ', num2str(gamma)]);
end

