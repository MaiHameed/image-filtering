%% Q3.1 Seam Carving - Removal Only
fprintf('Question 3.1 starting...\n');

image = imread('ryerson.jpg');

figure;
imshow(image,[]);
title('Original Ryerson image 720x480');

disp('Reducing to 640x480...');
tic;
figure;
carve1 = MySeamCarving(image,640,480);
imshow(carve1,[]);
title('Ryerson image resized to 640x480 through seam carving');
toc;

disp('Reducing to 720x320...');
tic;
figure;
carve2 = MySeamCarving(image,720,320);
imshow(carve2,[]);
title('Ryerson image resized to 720x320 through seam carving');
toc;

image2 = imread('lenna.png');

figure;
imshow(image2,[]);
title('Original Lenna image 512x512');

disp('Reducing to 360x512...');
tic;
figure;
carve3 = MySeamCarving(image2,360,512);
imshow(carve3,[]);
title('Lenna image resized to 360x512 through seam carving');
toc;

fprintf('Question 3.1 done! Press enter to continue...\n\n');
pause;

%% Q3.2 Seam Carving - Addition
fprintf('Question 3.2 starting...\n');

image = imread('ryerson.jpg');

figure;
imshow(image,[]);
title('Original Ryerson image 720x480');

disp('Increasing to 720x580...');
tic;
figure;
carve4 = MySeamCarving(image,720,580);
imshow(carve4,[]);
title('Ryerson image resized to 720x580 through seam carving');
toc;

fprintf('Question 3.2 done!\n');