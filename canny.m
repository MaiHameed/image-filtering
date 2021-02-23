%% Q2.1
% See MyCanny.m
fprintf('Question 2.1 starting...\n');

image = rgb2gray(imread('bowl-of-fruit.jpg'));
image2 = rgb2gray(imread('puppy.jpg'));

figure;
imshow(MyCanny(image,5,20),[]);
title('Custom Canny Implementation on Image 1');

figure;
imshow(MyCanny(image2,5,20),[]);
title('Custom Canny Implementation on Image 2');

fprintf('Question 2.1 done! Press enter to continue...\n\n');
pause;

%% Q2.2
fprintf('Question 2.2 starting...\n');

sigma = 5;

% The instructions never specified that we needed to change our MyCanny to
% implement the gaussian smoothing as a separable filter, so I'm plucking
% it and just displaying the separable filter below.

filterSize = 6*sigma+1;
gausRows = fspecial('gaussian',[filterSize,1],sigma); 
gausColumns = fspecial('gaussian',[1,filterSize],sigma); 

smoothedImage = imfilter(image, gausRows, 'conv');
smoothedImage = imfilter(smoothedImage, gausColumns, 'conv');

% To implement this in the MyCanny function, simply overwrite the code in
% step 1 with the above process

fprintf('Question 2.2 done!\n');