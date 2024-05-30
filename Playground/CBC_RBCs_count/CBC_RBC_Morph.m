% Load the image package
pkg load image
clc , close all , clear all
% Read the blood smear image
img = imread('smear2.jpg');

% Convert the image to grayscale
gray_img = rgb2gray(img);

% Apply a median filter to reduce noise
filtered_img = medfilt2(gray_img);

% Use edge detection (Canny) to find edges in the image
edges = edge(filtered_img, 'canny');

% Create a disk-shaped structuring element
function se = disk(radius)
    [X, Y] = meshgrid(-radius:radius, -radius:radius);
    se = (X.^2 + Y.^2) <= radius^2;
end

% Perform a morphological closing operation to close small gaps in the edges
se_close = disk(0.6);
closed_edges = imclose(edges, se_close);

% Fill the holes in the detected edges
filled_img = imfill(closed_edges, 'holes');

% Perform morphological opening to remove small objects
se_open = disk(1);
opened_img = imopen(filled_img, se_open);

% Label connected components in the image
[labeled_img, num_objects] = bwlabel(opened_img);

% Print the count of RBCs
disp(['Number of detected objects: ', num2str(num_objects)]);

% Measure properties of image regions (objects)
props = regionprops(labeled_img, 'Area', 'Perimeter', 'Centroid');

% Initialize counter for RBCs
rbc_count = 0;

% Display the original image
imshow(img);
hold on;

% Loop through each detected object to determine if it's an RBC
for i = 1:num_objects
    % Calculate the circularity of each object
    circularity = (4 * pi * props(i).Area) / (props(i).Perimeter ^ 2);

    % Check if the object is roughly circular and within size range for RBCs
    if circularity > 0.01 %&& props(i).Area > 100 && props(i).Area < 8000
        rbc_count = rbc_count + 1;

        % Draw a circle around the detected RBC
        radius = sqrt(props(i).Area / pi);
        viscircles(props(i).Centroid, radius, 'EdgeColor', 'g', 'LineWidth', 2);
    end
end

% Display the count of RBCs
title(['Detected RBCs: ', num2str(rbc_count)]);
hold off;

% Print the count of RBCs
disp(['Number of detected RBCs: ', num2str(rbc_count)]);

