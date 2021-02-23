%% Q3.1
fprintf('Question 3.1 starting...\n');

image = imread('ryerson.jpg');

figure;
imshow(MySeamCarving(image,640,480),[]);
title('Ryerson image resized to 640x480 through seam carving');

figure;
imshow(MySeamCarving(image,720,320),[]);
title('Ryerson image resized to 720x320 through seam carving');

