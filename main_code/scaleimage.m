function finalImage = scaleimage(image)
%SCALEIMAGE Summary of this function goes here
%   Detailed explanation goes here

    if ischar(image)
        image = imread(image);
    end
    
    RES_NET_INPUT_SIZE = 224;
   
    targetHeight = min(size(image, 1), size(image, 2));

    croppingWindow = centerCropWindow2d(size(image), [targetHeight targetHeight]);
    
    readImage = imcrop(image, croppingWindow);
    
    %[height, width, ~] = size(readImage);

    %if height ~= RES_NET_INPUT_SIZE
    %   scalingFactor = RES_NET_INPUT_SIZE / height;
    %   readImage = imresize(readImage, scalingFactor);
    %elseif width ~= RES_NET_INPUT_SIZE
    %   scalingFactor = RES_NET_INPUT_SIZE / width;
    %   readImage = imresize(readImage, scalingFactor);
    %end


    if targetHeight ~= RES_NET_INPUT_SIZE
       scalingFactor = RES_NET_INPUT_SIZE / targetHeight;
       readImage = imresize(readImage, scalingFactor);
    end
    
    size(readImage)
    finalImage = readImage;
end

