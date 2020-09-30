function trainAnImage(excelFilePath, image, imageFileName, className)
    % 'Training an image'
    [meanRed, meanGreen, meanBlue, meanGrayscale, bwArea, entropyVal, energy, contrast, correlation, homogeneity, sobelArea, cannyArea] = extractFeaturesFromAnImage(image);

    path = convertCharsToStrings(imageFileName);
    class = {className};
    newTableRow = table(path, class, meanRed, meanGreen, meanBlue, meanGrayscale, bwArea, entropyVal, energy, contrast, correlation, homogeneity, sobelArea, cannyArea);
    
    % featureArray = [path className meanRed meanGreen meanBlue meanGrayscale bwArea entropyVal energy contrast correlation homogeneity sobelArea cannyArea]
    
    if isfile(excelFilePath)
        needHeader = size(readtable(excelFilePath), 1) <= 0;
    else
        needHeader = true;
    end
    writetable(newTableRow, excelFilePath, 'WriteMode', 'Append', 'WriteVariableNames', needHeader, 'WriteRowNames', false);

    %alphabet = ['A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N', 'O', 'P', 'Q'];
    %usedAlphabets = alphabet(1:totalFeatures);
    
    %startingRange = strcat(usedAlphabets(1), num2str(row + 2));
    %endingRange = strcat(usedAlphabets(end), num2str(row + 2));
    %range = strcat(startingRange, ':', endingRange);
    %writematrix(featureArray, excelFilePath, 'Range', range)

    % system('taskkill /F /IM EXCEL.EXE');