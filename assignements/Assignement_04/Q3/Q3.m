% Load the image
I = imread('question_3.tif');

% Compute the 2D Discrete Fourier Transform (DFT) of the image
[M, N] = size(I);
F = fft2(I);

% Define the ideal low-pass filter in the frequency domain
u_center = floor(M/2) + 1;
v_center = floor(N/2) + 1;
filter_radius = 30;
H = zeros(M, N);
for u = 1:M
    for v = 1:N
        if sqrt((u - u_center)^2 + (v - v_center)^2) <= filter_radius
            H(u, v) = 1;
        else
            H(u, v) = 0;
        end
    end
end

% Apply the filter in the frequency domain
F_filtered = F .* H;

% Compute the filtered image in the spatial domain
I_filtered = real(ifft2(F_filtered));

% Display the original and filtered images
figure;
subplot(1, 2, 1);
imshow(I, []);
title('Original Image');
subplot(1, 2, 2);
imshow(I_filtered, []);
title('Ideal Low-Pass Filtered Image');
