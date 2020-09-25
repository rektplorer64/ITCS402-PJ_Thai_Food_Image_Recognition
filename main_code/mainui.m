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

    % Last Modified by GUIDE v2.5 24-Sep-2020 21:58:04

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

    setTextStatus(handles, 'Initializing Dataset')
    initializeDataset(excelFilePath, '../datasets/sample')
    setTextStatus(handles, 'Idle')

% --- Outputs from this function are returned to the command line.
function varargout = mainui_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;

function showImageLeft(handles, image)
    axes(handles.imageViewLeft); imshow(image)

function showImageRight(handles, image)
    axes(handles.imageViewRight); imshow(image)

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
    setTextRight(handles, statistic)

% --- Executes on button press in bwBtn.
function bwBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to bwBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global editedImage;
    editedImage = im2bw(originalImage);
    showImageRight(handles, editedImage);

% --- Executes on button press in redChBtn.
function redChBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to redChBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global editedImage;
    [redImg, stats] = isolateChannel('r', originalImage);
    editedImage = redImg;
    showImageRight(handles, editedImage);
    setTextRight(handles, stats);

% --- Executes on button press in greenChBtn.
function greenChBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to greenChBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global editedImage;
    [greenImg, stats] = isolateChannel('g', originalImage);
    editedImage = greenImg;
    showImageRight(handles, editedImage);
    setTextRight(handles, stats);

% --- Executes on button press in blueChBtn.
function blueChBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to blueChBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global editedImage;
    [blueImg, stats] = isolateChannel('b', originalImage);
    editedImage = blueImg;
    showImageRight(handles, editedImage);
    setTextRight(handles, stats);


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


% --- Executes on button press in homogeneityBtn.
function homogeneityBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to homogeneityBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage
    gray = rgb2gray(originalImage);
    glcm = graycomatrix(gray,'O', [0,1]);
    [contrast, correlation, energy, homogeneity] = extractGlcmStats(glcm);
    showImageRight(handles, gray)
    setTextRight(handles, strcat('Homogeneity: ', string(homogeneity)))


% --- Executes on button press in contrastBtn.
function contrastBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to contrastBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage
    gray = rgb2gray(originalImage);
    glcm = graycomatrix(gray,'O', [0,1]);
    [contrast, correlation, energy, homogeneity] = extractGlcmStats(glcm);
    showImageRight(handles, gray)
    setTextRight(handles, strcat('Contrast: ', string(contrast)))


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton17 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in entropyBtn.
function entropyBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to entropyBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    rngfil = rangefilt(originalImage);  
    entro = entropy(rngfil)*100; 
    showImageRight(handles, rngfil);
    setTextRight(handles, strcat('Entropy: ', string(entro)))

% --- Executes on button press in energyBtn.
function energyBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to energyBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage
    gray = rgb2gray(originalImage);
    glcm = graycomatrix(gray,'O', [0,1]);
    [contrast, correlation, energy, homogeneity] = extractGlcmStats(glcm);
    showImageRight(handles, gray)
    setTextRight(handles, strcat('Energy: ', string(energy)))

% --- Executes on button press in corelationBtn.
function corelationBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to corelationBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage
    gray = rgb2gray(originalImage);
    glcm = graycomatrix(gray,'O', [0,1]);
    [contrast, correlation, energy, homogeneity] = extractGlcmStats(glcm);
    showImageRight(handles, gray)
    setTextRight(handles, strcat('Correlation: ', string(correlation)))

% --- Executes on button press in sobelBtn.
function sobelBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to sobelBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    sobelEdge = edge(im2bw(originalImage), 'sobel', 0.01); 
    showImageRight(handles, sobelEdge)
    sobelArea = bwarea(sobelEdge) / 10;
    setTextRight(handles, strcat('Sobel Area: ', string(sobelArea)))

% --- Executes on button press in cannyBtn.
function cannyBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to cannyBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    cannyEdge = edge(im2bw(originalImage), 'canny', 0.05); 
    showImageRight(handles, cannyEdge)
    cannyArea = bwarea(cannyEdge) / 10;
    setTextRight(handles, strcat('Canny Area: ', string(cannyArea)))

% --- Executes on button press in histogramBtn.
function histogramBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to histogramBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;

    %Split into RGB Channels
    Red = originalImage(:,:,1);
    Green = originalImage(:,:,2);
    Blue = originalImage(:,:,3);

    %Get histValues for each channel
    [yRed, x] = imhist(Red);
    [yGreen, x] = imhist(Green);
    [yBlue, x] = imhist(Blue);

    %Plot them together in one plot
    axes(handles.imageViewRight); plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');

    hold off

% --- Executes on button press in trainBtn.
function trainBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to trainBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global originalImageAbsPath;
    global excelFilePath;
    trainAnImage(excelFilePath, originalImage, originalImageAbsPath)

% --- Executes on button press in recognizeBtn.
function recognizeBtn_Callback(hObject, eventdata, handles)
    % hObject    handle to recognizeBtn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global originalImage;
    global excelFilePath;
    
    setTextStatus(handles, 'Recognizing...')
    [matchingImagePath, distance] = recogizeByFeatures(excelFilePath, originalImage)
    
    cell2mat(matchingImagePath)
    showImageRight(handles, imread(cell2mat(matchingImagePath)));
    setTextRight(handles, strcat("Euclidean Dist. = ", num2str(distance)));
    setTextStatus(handles, 'Idle')
    
 
