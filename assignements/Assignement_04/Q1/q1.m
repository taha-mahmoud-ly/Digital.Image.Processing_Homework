pkg load image

% Read the image
img = imread('question_1.tif');

% Convert to grayscale if necessary
if size(img, 3) > 1
    img = rgb2gray(img);
end

% Compute the Fourier transform
F = fft2(double(img));

% Shift the zero-frequency component to the center of the spectrum
F_shifted = fftshift(F);

% Compute the magnitude spectrum
mag_spectrum = abs(F_shifted);

% Apply log scaling to the magnitude spectrum
log_spectrum = log(1 + mag_spectrum);

% Display the centered and log-scaled spectrum
figure;
imagesc(log_spectrum);
colormap(gray);
title('Centered and Log-Scaled Spectrum');
xlabel('Frequency (u)');
ylabel('Frequency (v)');
