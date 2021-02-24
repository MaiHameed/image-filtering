function [output] = CarvingHelper(image)
%CARVINGHELPER Takes in an image and removes a vertical seam using seam
%carving
%   Takes in an RGB image and removes a vertical seam, returning the
%   original image reduced by one pixel in the horizontal resolution

% Step 1 - Obtain energies of each channel in coloured image
% The instructions never specified using manual gradient/energy
% calculations, I assumed the safe usage of the functions below
[r,g,b] = imsplit(image);

% Initialize the new 3 colour channels at the same size of original image
% minus one column, a subtraction of the image width
newR = r(:,1:end - 1);
newG = newR;
newB = newR;

[gradMagR, ~] = imgradient(r);
[gradMagG, ~] = imgradient(g);
[gradMagB, ~] = imgradient(b);

% Combine energies of all 3 channels into one matrix
E = gradMagR + gradMagG + gradMagB;

% Populate scoring matrix, M
M = [];
M(1,:) = E(1,:);
for i = 2 : size(E,1) % For each row
    for j = 1 : size(E,2) % For each column
        if j == 1 % If at left most column
            M(i,j) = E(i,j) + min([M(i-1,j), M(i-1,j+1)]);
        elseif j == size(E,2) % If at right most column
            M(i,j) = E(i,j) + min([M(i-1,j-1), M(i-1,j)]);
        else % In any middle pixel
            M(i,j) = E(i,j) + min([M(i-1,j-1), M(i-1,j), M(i-1,j+1)]);
        end
    end
end

% Obtain pixels to delete
for i = size(E,1):-1:1 % For each row in the M matrix
    if i == size(E,1) 
        % If we're at the bottom-most row, simply find the minimum value
        [~,I] = min(M(i,:));
    else
        % find the minimum of the neighbours above the currently selected
        % pixel
        if I == 1
            left = I;
            [~,I] = min(M(i,left:left+1));
            I = left-1+I;
        elseif I == size(r,2)
            left = I-1;
            [~,I] = min(M(i,left:left+1));
            I = left-1+I;
        else
            left = I-1;
            [~,I] = min(M(i,left:left+2));
            I = left-1+I;
        end
    end 
    % I corresponds to the column in the current row which contains the
    % minimum element. Proceed to delete that pixel in all 3 colour
    % channels
    if I == 1 % If the deletion is the left most pixel
        newR(i,:) = r(i,2:end);
        newG(i,:) = g(i,2:end);
        newB(i,:) = b(i,2:end);
    elseif I == size(r,2) % If the deletion is the right most pixel
        newR(i,:) = r(i,1:end-1);
        newG(i,:) = g(i,1:end-1);
        newB(i,:) = b(i,1:end-1);
    else % The deletion is somewhere in the middle
        newR(i,:) = [r(i,1:I-1) r(i,I+1:end)];
        newG(i,:) = [g(i,1:I-1) g(i,I+1:end)];
        newB(i,:) = [b(i,1:I-1) b(i,I+1:end)];
    end
end

output = cat(3,newR,newG,newB);
end

