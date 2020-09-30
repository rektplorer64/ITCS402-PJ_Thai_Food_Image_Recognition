function initializeSvmModel(svmModelFileName, rootDatasetPath)
%INITIALIZESVMMODEL Summary of this function goes here
%   Detailed explanation goes here
    if exist(svmModelFileName, 'file') == 2
        return
    end
    imgDs = imageDatastore(rootDatasetPath, ...
        'FileExtensions', {'.jpg', '.png'}, ...
        'IncludeSubfolders',true, ...
        'LabelSource',"foldernames", 'ReadFcn', @scaleimage);
    
    net = resnet101();
    
    augmentedTrainingSet = augmentedImageDatastore([224 224 3], imgDs, "OutputSizeMode", "centercrop");
    
    trainingFeatures = activations(net, augmentedTrainingSet, 'fc1000', ...
        'MiniBatchSize', 1, 'OutputAs', 'columns');

    TRAINED_SVM_CLASSIFIER = fitcecoc(trainingFeatures, imgDs.Labels, ...
        'Learners', 'linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
    
    save(svmModelFileName, 'TRAINED_SVM_CLASSIFIER')
end

