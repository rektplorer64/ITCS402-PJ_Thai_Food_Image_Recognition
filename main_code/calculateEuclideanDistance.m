function distance = calculateEuclideanDistance(vector1, vector2)
%CALCULATEEUCLIDEANDISTANCE Summary of this function goes here
%   Detailed explanation goes here
    V = vector1 - vector2;
    distance = sqrt(V * V');
end

