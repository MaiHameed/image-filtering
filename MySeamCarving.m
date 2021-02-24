function [output] = MySeamCarving(image,hori,vert)
%MYSEAMCARVING Seam carves input image to fit new resolution
%   Takes an RGB image and uses horizontal and vertical seam carving to
%   return the image with the new desired resolution (hori x vert)

[imgRows, imgCol, ~] = size(image);

seamImg = image;
for i = 1:imgCol-hori
    seamImg = CarvingHelper(seamImg);
end

seamImg = rot90(seamImg,1);
for i = 1:imgRows-vert
    seamImg = CarvingHelper(seamImg);
end 

output = rot90(seamImg,3);
end

