function [meanRed, meanGreen, meanBlue, meanGrayscale, bwArea, entropyVal, energy, contrast, correlation, homogeneity, sobelArea, cannyArea] = extractFeaturesFromAnImage(image)
    [meanRed, meanGreen, meanBlue] = findColorChannelMeans(image);

    gray = rgb2gray(image);
    glcm = graycomatrix(gray,'O', [0,1]);
    [contrast, correlation, energy, homogeneity] = extractGlcmStats(glcm);

    meanGrayscale = mean(mean(gray));

    bw =~ imbinarize(gray); 
    bwArea = bwarea(bw) / 100;
    [cannyEdge, cannyArea] = calculateCannyEdge(bw);
    [sobelEdge, sobelArea] = calculateSobelEdge(bw);

    entropyVal = entropy(rangefilt(image)) * 100;
    