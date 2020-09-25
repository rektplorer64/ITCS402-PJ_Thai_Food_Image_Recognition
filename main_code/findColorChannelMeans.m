function [meanRed, meanGreen, meanBlue] = findColorChannelMeans(image)
    meanRed = mean(mean(image(:,:,1)));
    meanGreen = mean(mean(image(:,:,2)));
    meanBlue = mean(mean(image(:,:,3)));