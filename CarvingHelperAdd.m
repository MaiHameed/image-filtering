function [output] = CarvingHelperAdd(image)
%CARVINGHELPERADD Adds a single vertical seam to an input image
%   Uses seam carving to increase the width by 1 pixel by adding a vertical
%   seam

% Step 1 - Obtain energies of each channel in coloured image
[r,g,b] = imsplit(image);

% Initialize the new 3 colour channels at the same size of original image
% plus one column
newR = [r(:,:) zeros(size(r,1),1)];
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

% Obtain pixels to add
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
    % minimum element. Proceed to add that pixel in all 3 colour
    % channels
    if I == 1 % If the addition is the left most pixel
        newR(i,:) = [r(i,I) r(i,:)];
        newG(i,:) = [g(i,I) g(i,:)];
        newB(i,:) = [b(i,I) b(i,:)];
    elseif I == size(r,2) % If the addition is the right most pixel
        newR(i,:) = [r(i,:) r(i,I)];
        newG(i,:) = [g(i,:) g(i,I)];
        newB(i,:) = [b(i,:) b(i,I)];
    else % The addition is somewhere in the middle
        newR(i,:) = [r(i,1:I) r(i,I) r(i,I+1:end)];
        newG(i,:) = [g(i,1:I) g(i,I) g(i,I+1:end)];
        newB(i,:) = [b(i,1:I) b(i,I) b(i,I+1:end)];
    end
end

output = cat(3,newR,newG,newB);
end

