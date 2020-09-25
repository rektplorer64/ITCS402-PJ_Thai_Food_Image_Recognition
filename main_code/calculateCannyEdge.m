function [cannyEdge, cannyArea] = calculateCannyEdge(bwImage)
    cannyEdge = edge(bwImage, 'canny', 0.05); 
    cannyArea = bwarea(cannyEdge) / 10;