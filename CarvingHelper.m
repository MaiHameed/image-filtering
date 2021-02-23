function [output] = CarvingHelper(image)
%CARVINGHELPER Takes in an image and removes a vertical seam using seam
%carving
%   Takes in an RGB image and removes a vertical seam, returning the
%   original image reduced by one pixel in the horizontal resolution

% Find energy per split channel
% Get a single matrix E that has the sum of all 3 channel energies
% Obtain and fill the scoring matrix M
% Find the minimum value in the last row of M, and delete that pixel in the
% r,g,b channels of the original image. Note the column location
% find the minimum of the neighbouring pixels one row above current pixel.
% Make note of that column location and delete the pixel from r,g,b
% channels. Repeat till all rows are gone

output = image;
end

