function [output] = MyCanny(image,sigma,tau)
%MYCANNY Summary of this function goes here
%   Detailed explanation goes here

% Step 1 - Smooth the image using a 2D Gaussian
% Using the 3 sigma rule.

% Instructions never specified using manual smoothing, so I'm using
% fspecial() and imfilter()

filterSize = 6*sigma+1;
gaussian2D = fspecial('gaussian',filterSize,sigma);
smoothedImage = imfilter(double(image),gaussian2D,'conv');

% Step 2 - Computing the gradient and squared gradient magnitude
% Horizontal and Vertical Filters
h = fspecial('sobel');

dx = imfilter(double(smoothedImage), h', 'conv');
dy = imfilter(double(smoothedImage), h, 'conv');

gradMag = sqrt(dx.^2 + dy.^2);
% Returns radians between [-pi, pi]
gradOri = atan2(dy,dx);
% Uses custom function roundRadians to round to enumerated values
rounded = roundRadians(gradOri); 

enumRad = [-pi -3*pi/4 -pi/2 -pi/4 0 pi/4 pi/2 3*pi/4 pi];
enumI = [0 -1 -1 -1 0 1 1 1 0];
enumJ = [-1 -1 0 1 1 1 0 -1 -1];

nonMaxSup = zeros(size(rounded));
% Non-max suppression
for i = 2 : size(image,1)-1
    for j = 2 : size(image,2)-2
        % Find adjacent pixels
        for m = 1 : size(enumRad,2)
            if rounded(i,j) == enumRad(1,m)
                adjI = enumI(1,m); % vector row shift
                adjJ = enumJ(1,m); % vector column shift
                break;
            end
        end
        % adjacent pixels found adjI and adjJ
        % Find max pixel and suppress others
        if gradMag(i+adjI,j+adjJ) >= gradMag(i,j) && ...
            gradMag(i+adjI,j+adjJ) >= gradMag(i-adjI,j-adjJ)
            nonMaxSup(i+adjI,j+adjJ) = gradMag(i+adjI,j+adjJ);
            nonMaxSup(i,j) = 0;
            nonMaxSup(i-adjI,j-adjJ) = 0;
        elseif gradMag(i,j) >= gradMag(i+adjI,j+adjJ) && ...
                gradMag(i,j) >= gradMag(i-adjI,j-adjJ)
            nonMaxSup(i,j) = gradMag(i,j);
            nonMaxSup(i+adjI,j+adjJ) = 0;
            nonMaxSup(i-adjI,j-adjJ) = 0;
        else
            nonMaxSup(i-adjI,j-adjJ) = gradMag(i-adjI,j-adjJ);
            nonMaxSup(i,j) = 0;
            nonMaxSup(i+adjI,j+adjJ) = 0;
        end
    end
end

figure;
imshow(gradMag);
figure;
imshow(uint8(nonMaxSup));
figure;
imshow(edge(image,'Canny',tau,sigma));
figure;
imshow(edge(image));

output = image;
end
% answer = edge(image,'Canny',tau,sigma);
