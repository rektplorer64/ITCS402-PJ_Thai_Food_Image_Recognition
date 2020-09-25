function [sobelEdge, sobelArea] = calculateSobelEdge(bwImage)
    sobelEdge = edge(bwImage, 'sobel', 0.05); 
    sobelArea = bwarea(sobelEdge) / 10;