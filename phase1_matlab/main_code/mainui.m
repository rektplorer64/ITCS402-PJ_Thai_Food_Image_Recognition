function varargout = mainui(varargin)
    % MAINUI MATLAB code for mainui.fig
    %      MAINUI, by itself, creates a new MAINUI or raises the existing
    %      singleton*.
    %
    %      H = MAINUI returns the handle to a new MAINUI or the handle to
    %      the existing singleton*.
    %
    %      MAINUI('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in MAINUI.M with the given input arguments.
    %
    %      MAINUI('Property','Value',...) creates a new MAINUI or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before mainui_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to mainui_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help mainui

    % Last Modified by GUIDE v2.5 01-Oct-2020 20:32:02

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @mainui_OpeningFcn, ...
                       'gui_OutputFcn',  @mainui_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    % End initialization code - DO NOT EDIT

% --- Executes just before mainui is made visible.
function mainui_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to mainui (see VARARGIN)

    % Choose default command line output for mainui
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes mainui wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
    
    global excelFilePath
    % cd('./main_code')
    excelFilePath = './model.xlsx';
    pwd

    global svmModelFileName
    svmModelFileName = 'trained-svm-classifier.mat';
    
    DATASET_PATH = '../datasets/FINAL DATASET';
    
    setTextStatus(handles, 'Initializing Dataset')
    initializeDataset(excelFilePath, DATASET_PATH)
    initializeSvmModel(svmModelFileName, DATASET_PATH)
    setTextStatus(handles, 'Idle')
    
    global datasetClasses;
    load('dataset-classes.mat', 'CLASSNAMES')
    datasetClasses = [];
   
    for i = 1:size(CLASSNAMES, 2)
        datasetClasses = [datasetClasses; string(CLASSNAMES(1, i))];
    end

    set(handles.labelDropdownMenu, 'String', datasetClasses)
    
    global datasetClassDropdownSelectedLabel 
    datasetClassDropdownSelectedLabel = datasetClasses(1, 1);
    
    global originalImage
    if exist('originalImage')
        showImageLeft(handles, originalImage)
    end
    
    global originalImageFileName
    if exist('originalImageFileName')
        setTextLeft(handles, originalImageFileName)
    end
    
    global GLCM_OFFSETS
    GLCM_OFFSETS = [0 1; -1 1;-1 0;-1 -1];
    
    global glcm_offsets_selection_index
    glcm_offsets_selection_index = 1;
    set(handles.offsetAngleMenu, 'String', {'0º', '45º', '90º', '135º'});
    

% --- Outputs from this function are returned to the command line.
function varargout = mainui_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;

function showImageLeft(handles, image)
    
    axes(handles.imageViewLeft)
    if ~isequal(image, [1 1; 1 1])
        res = strjoin(["Resolution: " string(size(image,2)) "×" string(size(image,1)) "px"], ' ');
        imshow(image);
    else
        res = "Resolution: -";
        cla
    end
    
    set(handles.resolutionText,'string', res)

function showImageRight(handles, image)
    axes(handles.imageViewRight)
    if ~isequal(image, [1 1; 1 1])
        imshow(image);
    else
        cla
    end

function setTextLeft(handles, textString)
    set(handles.edit1,'string', textString);

function setTextRight(handles, textString)
    set(handles.edit2,'string', textString);

function setTextStatus(handles, textString)
    set(handles.status,'string', textString);
    
% --- Executes on button press in grayscaleBtn.
function grayscaleBtn_Callback(hObject, eventdata, handles)
% hObject    handle to grayscaleBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global editedImage;
    editedImage = rgb2gray(originalImage);
    statistic = mean(mean(mean(editedImage(:,:,1))));
    showImageRight(handles, editedImage);
    setTextRight(handles, strjoin(["Average Gray level:" statistic]));

% --- Executes on button press in bwBtn.
function bwBtn_Callback(hObject, eventdata, handles)
% hObject    handle to bwBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global editedImage;
    editedImage = imbinarize(rgb2gray(originalImage));
    showImageRight(handles, editedImage);
    setTextRight(handles, strjoin(["Estimated area of the objects:" bwarea(editedImage)]));

% --- Executes on button press in redChBtn.
function redChBtn_Callback(hObject, eventdata, handles)
% hObject    handle to redChBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global editedImage;
    [redImg, meanColorLevel] = isolateChannel('r', originalImage);
    editedImage = redImg;
    showImageRight(handles, editedImage);
    setTextRight(handles, strjoin(["Average Red color level:" meanColorLevel]));

% --- Executes on button press in greenChBtn.
function greenChBtn_Callback(hObject, eventdata, handles)
% hObject    handle to greenChBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global editedImage;
    [greenImg, meanColorLevel] = isolateChannel('g', originalImage);
    editedImage = greenImg;
    showImageRight(handles, editedImage);
    setTextRight(handles, strjoin(["Average Green color level:" meanColorLevel]));

% --- Executes on button press in blueChBtn.
function blueChBtn_Callback(hObject, eventdata, handles)
% hObject    handle to blueChBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global editedImage;
    [blueImg, meanColorLevel] = isolateChannel('b', originalImage);
    editedImage = blueImg;
    showImageRight(handles, editedImage);
    setTextRight(handles, strjoin(["Average Blue color level:" meanColorLevel]));


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of edit2 as text
    %        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of edit1 as text
    %        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in loadImageBtn.
function loadImageBtn_Callback(hObject, eventdata, handles)
% hObject    handle to loadImageBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global originalImageFileName;
    global originalImageAbsPath;
    [filename, pathname] = uigetfile({'*.jpg'});
    
    originalImageAbsPath = strcat(pathname, filename);
    originalImage = imread(originalImageAbsPath);
    originalImageFileName = filename;

    showImageLeft(handles, originalImage)
    setTextLeft(handles, filename)

% --- Executes on button press in clearImageBtn.
function clearImageBtn_Callback(hObject, eventdata, handles)
% hObject    handle to clearImageBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    clear originalImage;
    showImageRight(handles, [1 1; 1 1])
    showImageLeft(handles, [1 1; 1 1])

% --- Executes on button press in homogeneityBtn.
function homogeneityBtn_Callback(hObject, eventdata, handles)
% hObject    handle to homogeneityBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage
    global GLCM_OFFSETS
    global glcm_offsets_selection_index
    
    gray = rgb2gray(originalImage);
    glcm = graycomatrix(gray,'O', GLCM_OFFSETS(glcm_offsets_selection_index, :));
    [~, ~, ~, homogeneity] = extractGlcmStats(glcm);
    showImageRight(handles, gray)
    setTextRight(handles, strjoin(['Homogeneity:' string(homogeneity)]))


% --- Executes on button press in contrastBtn.
function contrastBtn_Callback(hObject, eventdata, handles)
% hObject    handle to contrastBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage
    global GLCM_OFFSETS
    global glcm_offsets_selection_index
    
    gray = rgb2gray(originalImage);
    glcm = graycomatrix(gray,'O', GLCM_OFFSETS(glcm_offsets_selection_index, :));
    [contrast, ~, ~, ~] = extractGlcmStats(glcm);
    showImageRight(handles, gray)
    setTextRight(handles, strjoin(['Contrast:' string(contrast)]))


% --- Executes on button press in exitBtn.
function exitBtn_Callback(hObject, eventdata, handles)
% hObject    handle to exitBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
exi

% --- Executes on button press in entropyBtn.
function entropyBtn_Callback(hObject, eventdata, handles)
% hObject    handle to entropyBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    rngfil = rangefilt(originalImage);  
    entro = entropy(rngfil) * 100; 
    showImageRight(handles, rngfil);
    setTextRight(handles, strjoin(['Entropy:' string(entro)]))

% --- Executes on button press in energyBtn.
function energyBtn_Callback(hObject, eventdata, handles)
% hObject    handle to energyBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage
    global GLCM_OFFSETS
    global glcm_offsets_selection_index
    
    gray = rgb2gray(originalImage);
    
    glcm = graycomatrix(gray,'O', GLCM_OFFSETS(glcm_offsets_selection_index, :));
    [~, ~, energy, ~] = extractGlcmStats(glcm);
    showImageRight(handles, gray)
    setTextRight(handles, strjoin(['Energy:' string(energy)]))

% --- Executes on button press in corelationBtn.
function corelationBtn_Callback(hObject, eventdata, handles)
% hObject    handle to corelationBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage
    global GLCM_OFFSETS
    global glcm_offsets_selection_index
    
    gray = rgb2gray(originalImage);
    glcm = graycomatrix(gray,'O', GLCM_OFFSETS(glcm_offsets_selection_index, :));
    [~, correlation, ~, ~] = extractGlcmStats(glcm);
    showImageRight(handles, gray)
    setTextRight(handles, strjoin(['Correlation:' string(correlation)]))

% --- Executes on button press in sobelBtn.
function sobelBtn_Callback(hObject, eventdata, handles)
% hObject    handle to sobelBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    sobelEdge = edge(imbinarize(rgb2gray(originalImage)), 'sobel', 0.01); 
    
    showImageRight(handles, sobelEdge)
    sobelArea = bwarea(sobelEdge) / 10;
    setTextRight(handles, strjoin(['Sobel Edge Area:' string(sobelArea)]))

% --- Executes on button press in cannyBtn.
function cannyBtn_Callback(hObject, eventdata, handles)
% hObject    handle to cannyBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    cannyEdge = edge(imbinarize(rgb2gray(originalImage)), 'canny', 0.05); 
    showImageRight(handles, cannyEdge)
    
    cannyArea = bwarea(cannyEdge) / 10;
    setTextRight(handles, strjoin(['Canny Edge Area: ' string(cannyArea)]))

% --- Executes on button press in prewittEdgeBtn.
function prewittEdgeBtn_Callback(hObject, eventdata, handles)
% hObject    handle to prewittEdgeBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    cannyEdge = edge(imbinarize(rgb2gray(originalImage)), 'prewitt', 0.05); 
    showImageRight(handles, cannyEdge)
    
    cannyArea = bwarea(cannyEdge) / 10;
    setTextRight(handles, strjoin(['Prewitt Edge Area: ' string(cannyArea)]))
    
% --- Executes on button press in histogramBtn.
function histogramBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to histogramBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;

    setTextRight(handles, 'Color Histogram')
    
    % Split into RGB Channels
    Red = originalImage(:,:,1);
    Green = originalImage(:,:,2);
    Blue = originalImage(:,:,3);

    % Get histValues for each channel
    [yRed, ~] = imhist(Red);
    [yGreen, ~] = imhist(Green);
    [yBlue, ~] = imhist(Blue);

    [yGrayscale, ~] = imhist(rgb2gray(originalImage)); 
    
    x = 0:1:255;
    
    % Plot them together in one plot
    axes(handles.imageViewRight); plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Cyan', x, yGrayscale, 'w:');
    % legend('Red','Green', 'Blue', 'Grayscale')
    set(gca,'color',[53 54 58] / 255)
    xlim([0 255])
    ylabel('Frequency') 
    xlabel('Color Value') 

    hold off

% --- Executes on button press in trainBtn.
function trainBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to trainBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global originalImageAbsPath;
    global excelFilePath;
    global datasetClassDropdownSelectedLabel;
    
    trainAnImage(excelFilePath, originalImage, originalImageAbsPath, datasetClassDropdownSelectedLabel)

% --- Executes on button press in recognizeBtn.
function recognizeBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to recognizeBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global excelFilePath;
    
    setTextStatus(handles, 'Recognizing...')
    [matchingImagePath, distance, className] = recogizeByFeatures(excelFilePath, originalImage)
    
    cell2mat(matchingImagePath)
    showImageRight(handles, imread(cell2mat(matchingImagePath)));
    setTextRight(handles, strcat("Euclidean Dist. = ", num2str(distance)));
    setTextStatus(handles, 'Idle')
    
    set(handles.featureMatchingText,'string', strjoin(["Prediction:" className]))


% --- Executes on selection change in offsetAngleMenu.
function offsetAngleMenu_Callback(hObject, eventdata, handles)
% hObject    handle to offsetAngleMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns offsetAngleMenu contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from offsetAngleMenu
    
    contents = cellstr(get(hObject,'String'));
    i = contents{get(hObject,'Value')};
    
    global glcm_offsets_selection_index
    switch i
        case '0º'
            glcm_offsets_selection_index = 1;
        case '45º'
            glcm_offsets_selection_index = 2;
        case '90º'
            glcm_offsets_selection_index = 3;
        case '135º'
            glcm_offsets_selection_index = 4;
    end
    
% --- Executes during object creation, after setting all properties.
function offsetAngleMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to offsetAngleMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on selection change in labelDropdownMenu.
function labelDropdownMenu_Callback(hObject, eventdata, handles)
% hObject    handle to labelDropdownMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns labelDropdownMenu contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from labelDropdownMenu
    
    contents = cellstr(get(hObject,'String'));
    
    global datasetClassDropdownSelectedLabel
    datasetClassDropdownSelectedLabel = contents{get(hObject,'Value')};

% --- Executes during object creation, after setting all properties.
function labelDropdownMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to labelDropdownMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in cnnFeatureSvmClassfyBtn.
function cnnFeatureSvmClassfyBtn_Callback(hObject, eventdata, handles)
% hObject    handle to cnnFeatureSvmClassfyBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   global originalImage
   global svmModelFileName
   
   setTextStatus(handles, 'Recognizing...')
   setFeatureSvmText(handles, "Prediction in progress...")
   className = recognizeByCnnFeatures(svmModelFileName, originalImage);
   setFeatureSvmText(handles, strjoin(["Prediction:" string(className)]))
   setTextStatus(handles, 'Idle')
   
function setFeatureSvmText(handles, textString)
    set(handles.cnnFeatureSvmText,'string', textString)
