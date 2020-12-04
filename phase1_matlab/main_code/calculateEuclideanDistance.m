function distance = calculateEuclideanDistance(vector1, vector2)
%CALCULATEEUCLIDEANDISTANCE Summary of this function goes here
%   Detailed explanation goes here
    V = (vector1 - vector2) .^ 2;
    distance = sqrt(sum(V, 2));
end

