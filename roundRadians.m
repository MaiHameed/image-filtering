function [output] = roundRadians(input)
%ROUNDRADIANS Rounds an input matrix to an enumerated value
%   Given a matrix of radians in the range [-pi, pi], round the angle to one 
%   of these [-pi -3*pi/4 -pi/2 -pi/4 0 pi/4 pi/2 3*pi/4 pi]

greaterThan = [-pi -3*pi/4 -pi/2 -pi/4 0 pi/4 pi/2 3*pi/4];
% Left circular shift of greaterThan
lessThan = cat(2,greaterThan(1,2:size(greaterThan,2)),-greaterThan(1,1));

% Find midpoint of the two round values, if value to round is greater than
% this roundValue, then round up, otherwise round down
roundPoint = [];
for m = 1 : size(greaterThan,2)
    temp = ((lessThan(1,m) - greaterThan(1,m))/2)+greaterThan(1,m);
    roundPoint = cat(2,roundPoint,temp);
end

% Perform rounding
output = input;
for i = 1 : size(input,1)
    for j = 1 : size(input,2)
        for m = 1 : size(greaterThan,2)
            if input(i,j) > greaterThan(1,m) && input(i,j) < lessThan(1,m)
                if input(i,j) > roundPoint(1,m)
                    output(i,j) = lessThan(1,m);
                    break;
                else
                    output(i,j) = greaterThan(1,m);
                    break;
                end
            end
        end
    end
end

end

