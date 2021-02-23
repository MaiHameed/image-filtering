function [output] = MyConv(image, kernel)
%MYCONV convolves the supplied image with the supplied kernel
%   Takes the supplied image as an input and convolves it with the supplied
%   kernel. Image is automatically padded with zeroes and the kernel is 
%   automatically flipped. This assumes a square kernel with an odd side
%   length.

% Window size of kernel = 2K+1
K = (size(kernel,1)-1)/2;                           % Find size of padding 
[imRows, imColumns] = size(image);                  % Get dimentions of image

imgPadded = zeros(imRows+2*K,imColumns+2*K);
imgPadded(1+K:K+imRows,1+K:K+imColumns) = image;    % Image padded with zeros

output = zeros(size(image,1),size(image,2));        % Initialize output image
totalPixel = 0;

for i = K+1 : K+imRows % Iterate through the padded image rows
    for j = K+1 : K+imColumns % Iterate through the padded image columns
        for m = 1 : size(kernel,1) % Iterate through each kernel row
            for n = 1 : size(kernel,2) % Iterate through each kernel column
                temp = kernel(m,n)*imgPadded(i+m-K-1,j+n-K-1);
                totalPixel = totalPixel + temp; % sum of each element multiplication
            end
        end
        output(i-K,j-K) = totalPixel;
        totalPixel = 0;
    end
end
output = cast(output,'uint8');