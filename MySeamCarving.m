function [output] = MySeamCarving(image,hori,vert)
%MYSEAMCARVING Seam carves input image to fit new resolution
%   Takes an RGB image and uses horizontal and vertical seam carving to
%   return the image with the new desired resolution (hori x vert)

[imgRows, imgCol, ~] = size(image);

seamImg = image;

if (imgCol-hori) >= 0
    % Pixel deletion
    for i = 1:imgCol-hori
        seamImg = CarvingHelper(seamImg);
    end
else
    % Pixel addition
    for i = 1:hori-imgCol
        seamImg = CarvingHelperAdd(seamImg);
    end
end

seamImg = rot90(seamImg,1);

if (imgRows-vert) >= 0
    % Pixel deletion
    for i = 1:imgRows-vert
        seamImg = CarvingHelper(seamImg);
    end 
else
    % Pixel addition
    for i = 1:vert-imgRows
        seamImg = CarvingHelperAdd(seamImg);
    end 
end

output = rot90(seamImg,3);
end

