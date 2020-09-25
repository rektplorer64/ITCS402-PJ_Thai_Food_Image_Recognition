function finalImage = scaleimage(fileName)
%SCALEIMAGE Summary of this function goes here
%   Detailed explanation goes here
image = imread(fileName);

RES_NET_INPUT_SIZE = 224;

[height, width, ~] = size(image);

if height < RES_NET_INPUT_SIZE
   scalingFactor = ceil(RES_NET_INPUT_SIZE / height); 
   image = imresize(image, scalingFactor);
elseif width < RES_NET_INPUT_SIZE
   scalingFactor = ceil(RES_NET_INPUT_SIZE / width); 
   image = imresize(image, scalingFactor);
end
finalImage = image;
end

