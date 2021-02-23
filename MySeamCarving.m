function [output] = MySeamCarving(image,hori,vert)
%MYSEAMCARVING Seam carves input image to fit new resolution
%   Takes an RGB image and uses horizontal and vertical seam carving to
%   return the image with the new desired resolution (hori x vert)

% Part A - Compute energies
% The instructions never specified using manual gradient/energy
% calculations, I assumed the safe usage of the functions below
[r,g,b] = imsplit(image);
% image = cat(3,r,g,b); To combine the channels into former image

[gradMagR, gradOriR] = imgradient(r);
[gradMagG, gradOriG] = imgradient(g);
[gradMagB, gradOriB] = imgradient(b);


output = image;
end

