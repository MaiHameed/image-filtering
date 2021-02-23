function [output] = MyCanny(image,sigma,tau)
%MYCANNY Implements the Canny edge detection
%   Takes in a grayscale image, standard deviation for the gaussian sigma, 
%   and threshold tau

% Step 1 - Smooth the image using a 2D Gaussian
% Using the 3 sigma rule.

% Instructions never specified using manual smoothing, so I'm using
% fspecial() and imfilter()

filterSize = 6*sigma+1;
gaussian2D = fspecial('gaussian',filterSize,sigma);
smoothedImage = imfilter(image,gaussian2D,'conv');

% Step 2 - Computing the gradient and squared gradient magnitude
% Horizontal and Vertical Filters
h = fspecial('sobel');

dx = imfilter(double(smoothedImage), h', 'conv');
dy = imfilter(double(smoothedImage), h, 'conv');

gradMag = sqrt(dx.^2 + dy.^2);
% Returns degrees between [0, 180]
gradOri = atan2(dy,dx)*(180/pi);
for i = 1 : size(gradOri,1)
    for j = 1 : size(gradOri,2)
        if gradOri(i,j) < 0
            gradOri(i,j) = gradOri(i,j) + 180;
        end
    end
end

% Uses custom function roundRadians to round to enumerated values
rounded = roundDegrees(gradOri); 

enumRad = [0 45 90 135 180];
enumI = [0 -1 -1 -1 0];
enumJ = [1 1 0 -1 -1];

% Thresholding
nonMaxSup = gradMag;
nonMaxSup(nonMaxSup<tau) = 0;

% Step 3 - Non-max suppression
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
        if nonMaxSup(i+adjI,j+adjJ) >= nonMaxSup(i,j) && ...
            nonMaxSup(i+adjI,j+adjJ) >= nonMaxSup(i-adjI,j-adjJ) && ...
            nonMaxSup(i+adjI,j+adjJ) ~= 0
            nonMaxSup(i+adjI,j+adjJ) = 1;
            nonMaxSup(i,j) = 0;
            nonMaxSup(i-adjI,j-adjJ) = 0;
        elseif nonMaxSup(i,j) >= nonMaxSup(i+adjI,j+adjJ) && ...
                nonMaxSup(i,j) >= nonMaxSup(i-adjI,j-adjJ) && ...
                nonMaxSup(i,j) ~= 0
            nonMaxSup(i,j) = 1;
            nonMaxSup(i+adjI,j+adjJ) = 0;
            nonMaxSup(i-adjI,j-adjJ) = 0;
        elseif nonMaxSup(i-adjI,j-adjJ) >= nonMaxSup(i+adjI,j+adjJ) && ...
                nonMaxSup(i-adjI,j-adjJ) >= nonMaxSup(i,j) && ...
                nonMaxSup(i-adjI,j-adjJ) ~= 0
            nonMaxSup(i-adjI,j-adjJ) = 1;
            nonMaxSup(i,j) = 0;
            nonMaxSup(i+adjI,j+adjJ) = 0;
        end
    end
end

output = nonMaxSup(2:size(nonMaxSup,1)-1,2:size(nonMaxSup,2)-1);
output = logical(output);
end
