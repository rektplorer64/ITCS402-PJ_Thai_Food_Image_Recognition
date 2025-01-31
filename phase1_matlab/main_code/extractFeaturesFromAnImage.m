function [meanRed, meanGreen, meanBlue, meanGrayscale, bwArea, entropyVal, energy, contrast, correlation, homogeneity, sobelArea, cannyArea] = extractFeaturesFromAnImage(image)
    [meanRed, meanGreen, meanBlue] = findColorChannelMeans(image);

    gray = rgb2gray(image);
    glcm = graycomatrix(gray,'O', [0,1]);
    [contrast, correlation, energy, homogeneity] = extractGlcmStats(glcm);

    meanGrayscale = mean(mean(gray));

    imageSize = size(image, 1) * size(image, 2);
    bw =~ imbinarize(gray); 
    bwArea = (bwarea(bw) / imageSize) * 1000;
    
    [~, rawCannyArea] = calculateCannyEdge(bw);
    cannyArea = (rawCannyArea / imageSize) * 1000;
    
    [~, rawSobelArea] = calculateSobelEdge(bw);
    sobelArea = (rawSobelArea / imageSize) * 1000;
    
    entropyVal = entropy(rangefilt(image)) * 1000;
    