% Load the image
I = imread('question_2.tif');
I = double(I);  % Convert to double for FFT operations
[M, N] = size(I);

% Define the Sobel filter
Sobel_mask = [-1 0 1; -2 0 2; -1 0 1];

% Pad the filter to the same size as the image
Sobel_padded = zeros(M, N);
Sobel_padded(1:3, 1:3) = Sobel_mask;

% Shift the filter for correct frequency representation
Sobel_padded = circshift(Sobel_padded, -floor(size(Sobel_mask)/2));

% Compute the 2D Fourier Transform of the image and the filter
F_I = fft2(I);
F_Sobel = fft2(Sobel_padded);

% Multiply the Fourier Transforms
F_filtered = F_I .* F_Sobel;

% Compute the inverse 2D Fourier Transform of the result
I_filtered = real(ifft2(F_filtered));

% Display the original and filtered images
figure;
subplot(1, 2, 1);
imshow(I, []);
title('Original Image');
subplot(1, 2, 2);
imshow(I_filtered, []);
title('Filtered Image (Frequency Domain)');

