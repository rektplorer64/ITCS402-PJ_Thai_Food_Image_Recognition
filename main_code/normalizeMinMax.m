function normalizedVector = normalizeMinMax(inputArray)
%MINMAXNORMALIZATION Summary of this function goes here
%   Detailed explanation goes here
normalizedVector = (inputArray - min(inputArray)) ./ (max(inputArray) - min(inputArray));
end

