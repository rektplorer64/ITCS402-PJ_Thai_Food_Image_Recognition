function [matchingImagePath, distance, className] = recogizeByFeatures(excelFilePath, image)
    %RECOGIZEBYFEATURES Summary of this function goes here
    %   Detailed explanation goes here
    
    [meanRed, meanGreen, meanBlue, meanGrayscale, bwArea, entropyVal, energy, contrast, correlation, homogeneity, sobelArea, cannyArea] = extractFeaturesFromAnImage(image);

    % path = convertCharsToStrings(imageFileName); 
    featureVector = [meanRed meanGreen meanBlue meanGrayscale bwArea entropyVal energy contrast correlation homogeneity sobelArea cannyArea];
    
    excelTable = readtable(excelFilePath);
    
    minDistance = 100000000;
    mostSimilarIndex = 1;
    
    %for i = 1 : 1: size(excelTable)
    %    rowVector = table2array(excelTable(;, 3:end));
    %    euclideanDistance = calculateEuclideanDistance(rowVector, featureVector);
    %    
    %    if minDistance > euclideanDistance
    %        minDistance = euclideanDistance;
    %        mostSimilarIndex = i;
    %    end
    %end
    excelRows = table2array(excelTable(:, 3:end));
    euclideanDistance = calculateEuclideanDistance(excelRows, featureVector);
    [minDistance, mostSimilarIndex] = min(euclideanDistance);
    
    distance = minDistance;
    matchingImagePath = table2array(excelTable(mostSimilarIndex, 1));
    className = table2array(excelTable(mostSimilarIndex, 2));
end
