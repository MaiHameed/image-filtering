%% Q1.1 Hand calculation
% Hand calculated result
fprintf('Question 1.1 starting...\n');

handcalc_result = [0 5 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0;
    0 -7 2 8 -1 2 -1 -3 0 0;
    0 0 1 1 0 0 -1 -1 0 0;
    0 0 3 1 -2 4 -1 -5 0 0;
    0 0 -1 -1 0 0 1 1 0 0;
    0 0 1 2 2 2 -3 -4 0 0;
    0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0];

fprintf('To convolve, the kernel was flipped and ');
fprintf('the result was correlated.\n');
fprintf('The result of the convolution is:\n');
format = [repmat('%3d ', 1, size(handcalc_result,2)-1), '%3d\n'];
fprintf(format, handcalc_result');

fprintf('Question 1.1 done! Press enter to continue...\n\n');
pause;

%% Verified with Matlab
% The following shows my verification process using built-in MATLAB
% functions. For reference only - don't mark this section

original = [-5 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0;
    0 0 -7 2 1 1 3 0 0 0;
    0 0 0 1 1 1 1 0 0 0;
    0 0 0 3 1 1 5 0 0 0;
    0 0 0 -1 -1 -1 -1 0 0 0;
    0 0 0 1 2 3 4 0 0 0;
    0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0];

hx = [1 0 -1];
verified_result = imfilter(double(original), hx, 'conv');

%% Q1.2 Gradient Magnitude
% The question never specified hand calculating, so I assumed the use of
% imfilter to do the convolution. I split the original image into small 
% clusters with the specified target pixel in the center for easier
% reference
fprintf('Question 1.2 starting...\n');

% Original Image
original = [-5 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0;
    0 0 -7 2 1 1 3 0 0 0;
    0 0 0 1 1 1 1 0 0 0;
    0 0 0 3 1 1 5 0 0 0;
    0 0 0 -1 -1 -1 -1 0 0 0;
    0 0 0 1 2 3 4 0 0 0;
    0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0];

% Target pixel location clusters
p23 = [0 0 0;
    -7 2 1;
    0 1 1];

p43 = [0 1 1;
    0 3 1;
    0 -1 -1];

p46 = [1 1 0;
    1 5 0;
    -1 -1 0];

% Horizontal and Vertical Filters
hx = [1 0 -1];
hy = hx';

% Gradient Magnitude calculations
fprintf('The gradient magnitude for the pixels are as follows\n');

dx = imfilter(double(p23), hx, 'conv');
dy = imfilter(double(p23), hy, 'conv');
mag = sqrt(dx(2,2).^2+dy(2,2).^2);
fprintf('[2,3]: %.3f\n',mag);

dx = imfilter(double(p43), hx, 'conv');
dy = imfilter(double(p43), hy, 'conv');
mag = sqrt(dx(2,2).^2+dy(2,2).^2);
fprintf('[4,3]: %.3f\n',mag);

dx = imfilter(double(p46), hx, 'conv');
dy = imfilter(double(p46), hy, 'conv');
mag = sqrt(dx(2,2).^2+dy(2,2).^2);
fprintf('[4,6]: %.3f\n',mag);

fprintf('Question 1.2 done! Press enter to continue...\n\n');
pause;

%% Q1.3 MyConv() Function Creation
% See MyConv.m;

%% Q1.4 MyConv() vs imfilter()
fprintf('Question 1.4 starting...\n');

image = rgb2gray(imread('bowl-of-fruit.jpg'));  % Import image as greyscale
kernel = fspecial('gaussian',13,2);             % A 13x13 2D gaussian with
                                                % standard deviation of 2

myConvImage = MyConv(image,kernel);
convImage = imfilter(image, kernel, 'conv');
diffImage = myConvImage - convImage;

figure;
imshow(myConvImage,[]);
title('Result of MyConv()');

figure;
imshow(convImage,[]);
title('Result of imfilter()');

figure;
imshow(diffImage,[]);
title('Difference of images');

maxVal = max(max(diffImage));
% I used disp() instead of fprintf as disp() is easier to use and is
% functionally the same
disp('The difference between the two convolution methods is largely 0, with');
disp('the maximum difference value of 1 due to rounding errors as the kernel');
disp('contains decimal values.');

fprintf('Question 1.4 done! Press enter to continue...\n\n');
pause;

%% Q1.5
fprintf('Question 1.5 starting...\n');

image = rgb2gray(imread('puppy.jpg'));         % Load in a 640x480 image

% Instructions never specified using manual smoothing, so I'm using
% fspecial() and imfilter()

% For a standard deviation (sigma) of 8, length of vector is 6*sigma+1 = 49
kernel2D = fspecial('gaussian',49,8);     
kernelRows = fspecial('gaussian',[49,1],8); 
kernelColumns = fspecial('gaussian',[1,49],8); 

disp('Time measurement of the 2D process:');
tic;
img2D = imfilter(image, kernel2D, 'conv');
toc;

disp('Time measurements of both 1D processes:');
tic;
img1D = imfilter(image, kernelRows, 'conv');
img1D = imfilter(img1D, kernelColumns, 'conv');
toc;

maxVal = max(max(img2D-img1D));

disp(' ');
disp('The gaussian kernel can be separated into two 1D processes, therefore');
disp('it is separable. The computation of the separable convolution is O(2w)');
disp('where w is the wxw size of the kernel, compared to O(w^2) for the full');
disp('2D convolution. This is verified by looking at the computation speed of');
disp('the processes. The 2D process takes about 3x as long as the 1D process');
disp('to complete.');
disp(' ');

fprintf('Question 1.5 done!\n');