function [contrast, correlation, energy, homogeneity] = extractGlcmStats(glcm)
    result = graycoprops(glcm);
    contrast = result.Contrast * 100;
    correlation = result.Correlation * 100;
    energy = result.Energy * 1000;
    homogeneity = result.Homogeneity * 100;
