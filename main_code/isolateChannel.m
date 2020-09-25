
function [finalImage, statistic] = isolateChannel(channelName, image)
    tempImage = image;
    switch channelName
        case 'r'
            chIndex = 1;
            tempImage(:, :, 2) = 0;
            tempImage(:, :, 3) = 0;
        case 'g'
            chIndex = 2;
            tempImage(:, :, 1) = 0;
            tempImage(:, :, 3) = 0;
        case 'b'
            chIndex = 3;
            tempImage(:, :, 1) = 0;
            tempImage(:, :, 2) = 0;
        otherwise
            tempImage = image;
    end
    finalImage = tempImage;
    statistic = mean(mean(mean(finalImage(:,:,chIndex))));