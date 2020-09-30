function className = recognizeByCnnFeatures(svmModelFileName, imageToBeClassified)
%RECOGNIZEBYCNNFEATURES Summary of this function goes here
    %   Detailed explanation goes here
    if exist(svmModelFileName, 'file') == 2
           
        'Scaling Image...'
        image = scaleimage(imageToBeClassified);
        
        imageSize = size(image)
        
        'Extracting Features via ResNet-50'
        % Extract test features using the CNN
        testFeatures = activations(resnet101(), image, 'fc1000', ...
        'MiniBatchSize', 32, 'OutputAs', 'columns');

        'Load a trained Classifier...'
        load(svmModelFileName, 'TRAINED_SVM_CLASSIFIER')
        
        'Classifying Image...'
        % Pass CNN image features to trained classifier
        prediction = predict(TRAINED_SVM_CLASSIFIER, testFeatures, 'ObservationsIn', 'columns');
        className = string(prediction);
        return
    end
    className = 'No Trained Classifier Present!';
end

