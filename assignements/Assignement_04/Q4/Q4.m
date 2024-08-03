% Load the image
I = imread('question_4.tif');

% Compute the 2D Discrete Fourier Transform (DFT) of the image
[M, N] = size(I);
F = fft2(I);

% Define the Butterworth low-pass filter in the frequency domain
u_center = floor(M/2) + 1;
v_center = floor(N/2) + 1;
D0 = 60;
order = 2;
H = zeros(M, N);
for u = 1:M
    for v = 1:N
        D = sqrt((u - u_center)^2 + (v - v_center)^2);
        H(u, v) = 1 / (1 + (D/D0)^(2*order));
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
title('Butterworth Low-Pass Filtered Image');
imwrite(I_filtered,'output.jpg');
