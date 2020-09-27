function initializeDataset(excelFilePath, rootPath)

    fileCount = 0;
    D = rootPath;
    S = dir(fullfile(D, '*'));
    N = setdiff({S([S.isdir]).name}, {'.', '..'}); % list of subfolders of D.

    if exist('dataset-map.mat', 'file') == 2
     % File exists.
         % 'exists'
         load('dataset-map.mat', 'FILENAME_MAP')
    else
         % File does not exist.
         % 'not exists'
         FILENAME_MAP = containers.Map;
    end
    
    for ii = 1:numel(N)
        T = dir(fullfile(D, N{ii}, '*')); % improve by specifying the file extension.
        C = {T(~[T.isdir]).name}; % files in subfolder.

        for jj = 1:numel(C)
            F = fullfile(D, N{ii}, C{jj});
            
            className = N{ii};
            
            try
                FILENAME_MAP(F);
            catch
                'Checking file'
                FILENAME_MAP(F) = 1;
                trainAnImage(excelFilePath, imread(F), F, className)
            end
            
            % do whatever with file F.
            fileCount = fileCount + 1;
           
        end

    end
    
    save('dataset-map.mat', 'FILENAME_MAP')

    fileCount
