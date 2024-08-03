% Load the image
I = imread('question_2.tif');

% Compute the 2D Discrete Fourier Transform (DFT) of the image
[M, N] = size(I);
F = fft2(I);

% Define the Sobel mask in the frequency domain
Sobel_mask = [-1 0 1; -2 0 2; -1 0 1];
F_Sobel = zeros(M, N, 'double');
for u = 1:M
    for v = 1:N
        F_Sobel(u, v) = sum(sum(Sobel_mask .* exp(-1i * 2 * pi * ((u-1)*(0:2)/M + (v-1)*(0:2)/N))));
    end
end

% Compute the filtered image in the spatial domain
I_Sobel = real(ifft2(F_Sobel));

% Display the original and filtered images
figure;
subplot(1, 2, 1);
imshow(I, []);
title('Original Image');
subplot(1, 2, 2);
imshow(I_Sobel, []);
title('Sobel Filtered Image');
