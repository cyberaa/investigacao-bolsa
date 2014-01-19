function varargout = Analyser(varargin)
% ANALYSER MATLAB code for Analyser.fig
%      ANALYSER, by itself, creates a new ANALYSER or raises the existing
%      singleton*.
%
%      H = ANALYSER returns the handle to a new ANALYSER or the handle to
%      the existing singleton*.
%
%      ANALYSER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYSER.M with the given input arguments.
%
%      ANALYSER('Property','Value',...) creates a new ANALYSER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Analyser_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Analyser_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Analyser

% Last Modified by GUIDE v2.5 19-Jan-2014 20:26:41

% Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @Analyser_OpeningFcn, ...
                       'gui_OutputFcn',  @Analyser_OutputFcn, ...
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


% --- Executes just before Analyser is made visible.
function Analyser_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Analyser (see VARARGIN)

    add_paths();

    %Generate time series used in case user does not give us one
    handles.t=(0:500)';
    data = generate_time_series(-1,1,length(handles.t),-5,5);
    handles.data = data';
    handles.data_miss = add_missing(handles.data, 0.10);
    [handles.data_outliers,handles.outlier_locations]=add_outliers(handles.data, 0.15,std(handles.data)*1.15,std(handles.data)*1.15);
    
    handles.data_fix_outliers = [];
    handles.dL = [];
    handles.dH = [];
    handles.t_fix = 0;%Time vector correspondent to the time series without missing values

    handles.plotReferences = [];%Stores the plots computed by the GUI

    %User decision in terms of algorithms and data resampling and filling missing values
    handles.resampleData = 0;
    handles.samplingPeriod = 0;
    handles.fillMissing = 1;
    set(handles.fillmissingcheckbox,'Value',handles.fillMissing);%Check the fill missing checkbox
    handles.fillMissingMethod = 'Linear';
    handles.model = [];%Stores the methods chosen by the user
    handles.metrics = [];%Stores the metrics to compare the results, selected by the user
    handles.results = [];%Stores the results to be presented to the user in the 3rd tab table
    handles.showModel = 0;%If we want to show the plots of the accommodated data
    handles.parameters = [];%Stores values for the parameters as selected by the user
    handles.fileName = '';%Stores the root name of files saved
    handles.directoryName = '';%Stores the direcotry of the saved files
    handles.data_fix = []; handles.t_fix = [];
    
    %Show the main tab
    setVisibility(1,handles,hObject);
    
    %Hide sampling period boxes
    set(handles.missValsCountText,'enable','on');
    set(handles.methodText,'enable','on');
    set(handles.resampleDataCheckbox,'enable','on');        
    set(handles.linearmenu,'enable','on'); 
        
    set(handles.newSamplingPeriodText,'enable','off');
    set(handles.samplingPeriodText,'enable','off'); 
    
    %Don't show the inputFile path
    set(handles.filePathText,'String', '');
    
    % Choose default command line output for Analyser
    handles.output = hObject;
    
    handles.data_miss = handles.data_outliers;
    
    %Stores the parameters selected by the user
    handles.parameters = default_parameters();

    % Update handles structure
    guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Analyser_OutputFcn(hObject, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;
    
    % Update handles structure
    guidata(hObject, handles);



% --- Executes on button press in data_depur_bt.
function data_depur_bt_Callback(hObject, ~, handles)
% hObject    handle to data_depur_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    setVisibility(2,handles,hObject);%Advance to the second tab
    

% --- Executes on button press in inputFile_bt.
function inputFile_bt_Callback(hObject, ~, handles)
% hObject    handle to inputFile_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [filename, pathname] = uigetfile({'*.xls;*.xlsx', 'Microsfot Excel File (*.xls,*.xlsx)';'*.csv','Comma Sperated Value (*.csv)' },'Choose a File');
    fullpathname = [pathname filename];
    
    [status,t, data] = get_data_from_file(fullpathname);
        
    errorMessage = 'File corrupted or with unexpected content\nValid files must consist of two rows or two columns, representing the time (first) and the data/samples (second). Use NaN to represent missing values';
    
    if status == 0        
        errordlg(errorMessage,'Invalid File Content');
        set(handles.filePathText,'String', '');
    else
        handles.t = t;    
        handles.data_miss = data;
        
        cla(handles.axes1);
        plot(handles.axes1,t,data,'b');
        title(handles.axes1,'Collected Data'); 
        legend(handles.axes1,'Original Series');
        
        %Set filePathText to show the path to the file
        set(handles.filePathText,'String', fullpathname);
    end
    
    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in iqrButton
function iqrButton_Callback(hObject,~,handles)
% hObject    handle to outputFile_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.parameters(3,:) = ParametersSpecification({'IQRM - Interquartile Range Multiplier',2.31,'Interquartile range multiplier. Recommended: 2.31'});%Open the window
    
    close(handles.parameters(3,1));%Close it
    
    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in sndButton
function sndButton_Callback(hObject,~,handles)
% hObject    handle to outputFile_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.parameters(1,:) = ParametersSpecification({'SND - Standard Normal Deviation',2,'Standard Deviation multiplier. Recommended: 2, 2.5, 3'});%Open the window
    
    close(handles.parameters(1,1));%Close it
    
    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in modifiedZScoreButton
function modifiedZScoreButton_Callback(hObject,~,handles)
% hObject    handle to outputFile_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.parameters(5,:) = ParametersSpecification({'Z-score Threshold',3.5,'Threshold with which each point os compared. Recommended: 3.5'});%Open the window
    
    close(handles.parameters(5,1));%Close it
    
    % Update handles structure
    guidata(hObject, handles);
    
    
% --- Executes on button press in madButton.
function madButton_Callback(hObject, eventdata, handles)
% hObject    handle to madButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.parameters(6,:) = ParametersSpecification({'MADe Coefficient',3,'Multiplier for MAD values. Recommended: 2,3, 1.483'});%Open the window
    
    close(handles.parameters(6,1));%Close it
    
    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in grubbsButton
function grubbsButton_Callback(hObject,~,handles)
% hObject    handle to outputFile_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.parameters(4,:) = ParametersSpecification({'Confidence',0.05,'Confidence to predict outlier. Recommended: 0.05, 0.25'});%Open the window
    
    close(handles.parameters(4,1));%Close it
    
    % Update handles structure
    guidata(hObject, handles);
   
    
% --- Executes on button press in linearButton.
function linearButton_Callback(hObject, eventdata, handles)
% hObject    handle to linearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.parameters(2,:) = ParametersSpecification({'SND - Standard Normal Deviation',3,'Standard Deviation multiplier. Recommended: 2, 2.5, 3'});%Open the window
    
    close(handles.parameters(2,1));%Close it
    
    % Update handles structure
    guidata(hObject, handles);
 
    
function samplingPeriodText_Callback(hObject, eventdata, handles)
% hObject    handle to samplingPeriodText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samplingPeriodText as text
%        str2double(get(hObject,'String')) returns contents of samplingPeriodText as a double

	handles.samplingPeriod = get(hObject,'String');
    handles.samplingPeriod = str2double(get(hObject,'String'));   

    % Update handles structure
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function samplingPeriodText_CreateFcn(hObject, ~, handles)
% hObject    handle to samplingPeriodText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in Tab1.   
function Tab1_Callback(hObject, ~, handles)
% hObject    handle to Tab1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    setVisibility(1,handles,hObject);

% --- Executes on button press in Tab2.
function Tab2_Callback(hObject, ~, handles)
% hObject    handle to Tab2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    setVisibility(2,handles,hObject);


% --- Executes on button press in Tab3.
function Tab3_Callback(hObject, ~, handles)
% hObject    handle to Tab3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    setVisibility(3,handles,hObject); 


% --- Executes on button press in go_bt.
function go_bt_Callback(hObject, ~, handles)
% hObject    handle to go_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    cla(handles.axes1);
    cla(handles.axes2);
    cla(handles.axes3);
    handles.showModel = 0;
    legend(handles.axes1,'hide');
    legend(handles.axes2,'hide');
    legend(handles.axes3,'hide');

    %%%
    %%  FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME 
    %%%
    minV = min(handles.data_miss);
    maxV = max(handles.data_miss);
    meanV = mean(handles.data_miss); 
    stdV = std(handles.data_miss);    
    
    if validate_preprocessing_data(handles) == 0
        errorMessage = 'Invalid preprocessing data (maybe invalid resampling value?)';
        errordlg(errorMessage,'Invalid Data');
        return;
    end

    %Start ploting the data
    %Reset the axes
    cla(handles.axes1);

    plot(handles.axes1,handles.t,handles.data_miss,'b');
    title(handles.axes1,'Collected Data'); 
    hold(handles.axes1,'on');
    
    %%%
    %%  FIXME FIXME ISTO NAO ESTA BEM A FAZER A CENA DOS MISSING VALUES, EU E QUE DEVO SER NABO E NAO ESTOU A REPRESENTAR ISTO LA MUITO BEM
    %%  COME AGAIN FOR BIG FUDGE???!!!!
    %%%

    %Do Prepocessing!
    if (handles.fillMissing == 1)
        
        %Count the missing values
        set(handles.missValsCountText,'String',['Missing Value Count: ' num2str(sum(isnan(handles.data_miss)))]);
                
        if handles.resampleData
            [handles.t_fix,handles.data_fix] = fix_missing(handles.t,handles.data_miss, interp_method(handles.fillMissingMethod), handles.samplingPeriod);                            
        else
            [handles.t_fix,handles.data_fix] = fix_missing(handles.t,handles.data_miss, interp_method(handles.fillMissingMethod));                
        end
        plot(handles.axes1,handles.t_fix,handles.data_fix,'r--');
        legend(handles.axes1,'Original Series', 'Pre-Processed Series (to be Accomodated)');
        hold(handles.axes1,'on');
    else
        handles.t_fix = handles.t;
        handles.data_fix = handles.data_miss;
        legend(handles.axes1,'Original Series');
    end
    
    if handles.fillMissing && handles.resampleData
        t_temp = handles.t_fix;
        data_temp = handles.data_fix;
    else
        [t_temp, data_temp] = fix_missing(handles.t,handles.data_miss,'linear');
    end
        %length(data_temp)
        %length(t_temp)
        %round(0.10*length(data_temp))
    [~,outliers_detect,~,~] = accomodate_outliers(t_temp, data_temp, round(0.10*length(data_temp)), round(0.10*length(data_temp))-1,0,1,2.5);
    
    numberOutliers = sum(outliers_detect);
    set(handles.estnumoutliers,'String',['Estimated Number of Outliers: ' num2str(numberOutliers)]);
    set(handles.mean,'String', ['Mean: ' num2str(meanV)]);
    set(handles.std,'String', ['Standard Deviation: ' num2str(stdV)]);
    set(handles.minValue,'String',['Miniimum Value: ' num2str(minV)]);
    set(handles.maxValue,'String',['Maximum Value: ' num2str(maxV)]);
    
    % Update handles structure
    guidata(hObject, handles);
  

% --- Executes on button press in
function fillmissingcheckbox_Callback(hObject, ~, handles)
% hObject    handle to fillmissingcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fillmissingcheckbox

    %handles.fillMissing = mod(handles.fillMissing+1,2);
    %set(handles.fillmissingcheckbox,'Value',handles.fillMissing);
    %if (handles.fillMissing)
    if (get(handles.fillmissingcheckbox, 'Value'))
        set(handles.missValsCountText,'enable','on');
        set(handles.methodText,'enable','on');
        set(handles.resampleDataCheckbox,'enable','on');        
        set(handles.linearmenu,'enable','on'); 
    else
        set(handles.missValsCountText,'enable','off');
        set(handles.methodText,'enable','off');
        set(handles.resampleDataCheckbox,'enable','off');
        set(handles.linearmenu,'enable','off'); 

    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on selection change in linearmenu.
function linearmenu_Callback(hObject, eventdata, handles)
% hObject    handle to linearmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns linearmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from linearmenu

    contents = cellstr(get(hObject,'String'));
    handles.fillMissingMethod = contents{get(hObject,'Value')};    
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function linearmenu_CreateFcn(hObject, ~, handles)
% hObject    handle to linearmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in resampleDataCheckbox.
function resampleDataCheckbox_Callback(hObject, ~, handles)
% hObject    handle to resampleDataCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of resampleDataCheckbox
    handles.resampleData = handles.resampleData + 1;
    handles.resampleData = mod(handles.resampleData,2);
    
    %if (handles.resampleData) %Show text box to specify sampling period
    if (get(handles.resampleDataCheckbox, 'Value'))
        set(handles.newSamplingPeriodText,'Enable','on');
        set(handles.samplingPeriodText,'Enable','on');
    else %Hide the box
        set(handles.newSamplingPeriodText,'Enable','off');
        set(handles.samplingPeriodText,'Enable','off');
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in eucldistcheckbox.
function eucldistcheckbox_Callback(hObject, ~, handles)
% hObject    handle to eucldistcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of eucldistcheckbox
    
    if (get(handles.eucldistcheckbox,'Value'))
        handles.metrics = [handles.metrics 1];
    elseif (ismember(1,handles.metrics) == 1)%If we unselected the method we must remove it from the list of methods
        handles.metrics = handles.metrics(handles.metrics ~= 1);
    end
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in differencecheckbox.
function differencecheckbox_Callback(hObject, ~, handles)
% hObject    handle to differencecheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of differencecheckbox
    
    if (get(handles.differencecheckbox,'Value'))
        handles.metrics = [handles.metrics 2];
    elseif (ismember(2,handles.metrics) == 1)%If we unselected the method we must remove it from the list of methods
        handles.metrics = handles.metrics(handles.metrics ~= 2);
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in complextimecheckbox.
function complextimecheckbox_Callback(hObject, ~, handles)
% hObject    handle to complextimecheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of complextimecheckbox
    
    if (get(handles.complextimecheckbox,'Value'))
        handles.metrics = [handles.metrics 3];
    elseif (ismember(3,handles.metrics) == 1)%If we unselected the method we must remove it from the list of methods
        handles.metrics = handles.metrics(handles.metrics ~= 3);
    end
    
    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in absoluteDifferenceCheckbox.
function absoluteDifferenceCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to absoluteDifferenceCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of absoluteDifferenceCheckbox

    if (get(handles.complextimecheckbox,'Value'))
        handles.metrics = [handles.metrics 4];
    elseif (ismember(4,handles.metrics) == 1)%If we unselected the method we must remove it from the list of methods
        handles.metrics = handles.metrics(handles.metrics ~= 4);
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in iqrcheckbox.
function iqrcheckbox_Callback(hObject, ~, handles)
% hObject    handle to iqrcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of iqrcheckbox
    
    %handles.iqr = mod((handles.iqr + 1),2);
    
    if (get(handles.iqrcheckbox,'Value'))
        handles.model = [handles.model 2];
    elseif (ismember(2,handles.model) == 1)%If we unselected the method we must remove it from the list of methods
        handles.model = handles.model(handles.model ~= 2);
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in sndcheckbox.
function sndcheckbox_Callback(hObject, ~, handles)
% hObject    handle to sndcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sndcheckbox
    
    if (get(handles.sndcheckbox,'Value'))
        handles.model = [handles.model 0];
    elseif (ismember(0,handles.model) == 1)%If we unselected the method we must remove it from the list of methods
        handles.model = handles.model(handles.model ~= 0);
    end
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in madcheckbox.
function madcheckbox_Callback(hObject, ~, handles)
% hObject    handle to madcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of madcheckbox
    
    if (get(handles.madcheckbox,'Value'))
        handles.model = [handles.model 5];
        elseif (ismember(5,handles.model) == 1)%If we unselected the method we must remove it from the list of methods
        handles.model = handles.model(handles.model ~= 5);
    end
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in gurbbscheckbox.
function gurbbscheckbox_Callback(hObject, ~, handles)
% hObject    handle to gurbbscheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gurbbscheckbox
    
    if (get(handles.gurbbscheckbox,'Value'))
        handles.model = [handles.model 3];
    elseif (ismember(3,handles.model) == 1)%If we unselected the method we must remove it from the list of methods
        handles.model = handles.model(handles.model ~= 3);
    end
    
    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in mzscorecheckbox.
function mzscorecheckbox_Callback(hObject, ~, handles)
% hObject    handle to mzscorecheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mzscorecheckbox
    
    if (get(handles.mzscorecheckbox,'Value'))
        handles.model = [handles.model 4];
    elseif (ismember(4,handles.model) == 1)%If we unselected the method we must remove it from the list of methods
        handles.model = handles.model(handles.model ~= 4);
    end
    
    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in linearMethodCheckbox.
function linearMethodCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to linearMethodCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of linearMethodCheckbox

    if (get(handles.linearMethodCheckbox,'Value'))
        handles.model = [handles.model 1];
    elseif (ismember(1,handles.model) == 1)%If we unselected the method we must remove it from the list of methods
        handles.model = handles.model(handles.model ~= 1);
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in accommodate_bt.
function accommodate_bt_Callback(hObject, ~, handles)
% hObject    handle to accommodate_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    if validate_accomodation_data(handles) == 0
        legend(handles.axes2,'hide');
        errordlg('Invalid parameters selected or data not pre-processed','No Data Processed');
        set(handles.filePathText,'String', '');
        return;
    end
    
    %Ask user if he/she wants to save the results in a file
    resultFile = AskFile();   
    
    close(resultFile{1});%Close it
     
    handles.fileName = resultFile(2);
    handles.directoryName = resultFile(3);
    
    handles.fileName
    handles.directoryName
    

    %outlier_locations = handles.outlier_locations';
    handles.data_fix_outliers = zeros(length(handles.model),length(handles.data_fix));
    outliers = zeros(length(handles.model),length(handles.data_fix));
    handles.dL = zeros(length(handles.model),length(handles.data_fix));
    handles.dH = zeros(length(handles.model),length(handles.data_fix));
    
    handles.results = [];%%FIXME 
    handles.showModel = 1;
    
    for i=1:length(handles.model)
        
        %SUPERFIXME: Joca, tinhas comentado estas merdas, o que fazia com
        %que nada desse, porque efectivamente faltam os valores por
        %defeito. Para ja mantenho a linha com valores hardcoded, mas tens de tratar dos valores por defeito para se remover isto      
        %if (length(handles.parameters)<2) %User did not specify the parameters for the method, so we will use some default parmeters
        %    [handles.data_fix_outliers(i,:),outliers(i,:),handles.dL(i,:),handles.dH(i,:)] = accomodate_outliers(handles.t_fix,handles.data_fix,round(0.01*length(handles.t_fix)),round(0.01*length(handles.t_fix))-1,handles.model(i),0,0.85);
        %else
        
        j = handles.model(i) + 1;            
        ACCOMODATION_TYPE = handles.parameters(j,5); %0 = average ; 1 = linear; 2 = median JOCA FIXME

        if (handles.parameters(j,4)==-1)
            handles.parameters(j,4) = round(0.01*length(handles.t))-1;
        end
        [handles.data_fix_outliers(i,:),outliers(i,:),handles.dL(i,:),handles.dH(i,:)] = accomodate_outliers(handles.t_fix,handles.data_fix,handles.parameters(j,3),handles.parameters(j,4),handles.model(i),ACCOMODATION_TYPE,handles.parameters(j,2));
        %end
        
        
        
        handles.results(i,1) = sum(outliers(i,:));
        handles.results(i,2) = max(handles.data_fix_outliers(i,:));
        handles.results(i,3) = min(handles.data_fix_outliers(i,:));
        handles.results(i,4) = mean(handles.data_fix_outliers(i,:));
        handles.results(i,5) = std(handles.data_fix_outliers(i,:)); 
        
        handles.cnames = {'Number of Outliers Detected','Max Value', 'Min Value', 'Mean', 'STD'};  

        [handles.diffseries, quaddiff, complexdiff, absdiff] = compare_series(handles.data_fix',handles.data_fix_outliers(i,:));
        
        %Now we will compute the metric's comparison
        for j=1:length(handles.metrics)
            
            if (handles.metrics(j) == 1)
                handles.cnames{length(handles.cnames)+1} = 'Euclidean';
                handles.results(i,length(handles.cnames)) = quaddiff; 
            
            elseif (handles.metrics(j) == 4)
                handles.cnames{length(handles.cnames)+1} = 'Absolute Difference';
                handles.results(i,length(handles.cnames)) = absdiff;
            
            elseif (handles.metrics(j) == 3)
                handles.cnames{length(handles.cnames)+1} = 'Comp Time-Invariant';
                handles.results(i,length(handles.cnames)) = complexdiff;
            end
        end
    end
    
    %fprintf('Inserted %d outliers, found %d.\n', sum(outlier_locations), sum(sum(outliers)));

    %Plot the results of the Outlier accommodation methods used
    plotData(hObject,handles,handles.axes2);
    
    if (~isempty(find(handles.metrics == 2, 1)))%Difference metric selected
        plotDifferenceSeries(hObject, handles);
    end
    
    %%%
    %% Get methods - For now this will stay here... Maybe we could do this on the callback function where we select each method, however it would be
    %%               more difficult to implement this. Same goes to the metrics
    %%%
    handles.methodsName = {};
    
    % MEU, tanto COPY PASTE d�me CANCRO! Duas destas linhas podiam estar
    % fora da cascata de elseifs!!!!!! e a cascata podia ser substitu�a
    % por um array lookup! I'm dying!
    for i=1:length(handles.model)
        if (handles.model(i) == 2)
            handles.methodsName{length(handles.methodsName)+1} = 'IQR Method';
            
            if (strcmp('',handles.fileName) == 0)%Save File to Disk
                name = strcat(handles.fileName,'/IQR Method.csv');
                fullpath = strcat(char(handles.directoryName), name);
                save_file(fullpath,handles.t_fix,handles.data_fix_outliers(i,:));
            end
            
        elseif (handles.model(i) == 1)
            handles.methodsName{length(handles.methodsName)+1} = 'SND Method';
            
            if (strcmp('',handles.fileName) == 0)%Save File to Disk
                name = strcat(handles.fileName,'/SND Method.csv');
                fullpath = strcat(char(handles.directoryName), name);
                save_file(fullpath,handles.t_fix,handles.data_fix_outliers(i,:));
            end
            
        elseif (handles.model(i) == 4)
            handles.methodsName{length(handles.methodsName)+1} = 'Modified Z-Score';
            
            if (strcmp('',handles.fileName) == 0)%Save File to Disk
                name = strcat(handles.fileName,'/Modified Z-Score.csv');
                fullpath = strcat(char(handles.directoryName), name);
                save_file(fullpath,handles.t_fix,handles.data_fix_outliers(i,:));
            end
            
        elseif (handles.model(i) == 5)
            handles.methodsName{length(handles.methodsName)+1} = 'MAD Test';
            
            if (strcmp('',handles.fileName) == 0)%Save File to Disk
                name = strcat(handles.fileName,'/MAD Test.csv');
                fullpath = strcat(char(handles.directoryName), name);
                save_file(fullpath,handles.t_fix,handles.data_fix_outliers(i,:));
            end
            
        else
            handles.methodsName{length(handles.methodsName)+1} = 'Grubbs Test';
            
            if (strcmp('',handles.fileName) == 0)%Save File to Disk
                name = strcat(handles.fileName,'/Grubbs Test.csv');
                fullpath = strcat(char(handles.directoryName), name);
                save_file(fullpath,handles.t_fix,handles.data_fix_outliers(i,:));
            end
            
        end
    end
    
    %Update Table with metrics
    set(handles.table,'data',handles.results,'ColumnName',handles.cnames,'RowName',handles.methodsName);
    
   % handles.parameters = default_parameters();%Restore default parameters
    
    % Update handles structure
    guidata(hObject, handles);

    

% --- Plots the results of the Outlier's accommodation methods applied, as selected by the user
function plotData(hObject,handles,axesHandler)   
    data_outliers = handles.data_fix';
    t_outlier = handles.t_fix; 
    handles.plotReferences = [];    
        
    %Reset the axes
    cla(axesHandler);

    % Update handles structure
    guidata(hObject, handles);

    if (~isempty(handles.model))
        %Plot the data
        plot(axesHandler,t_outlier,data_outliers,'r');
        title(axesHandler,'Outlier Detection and Accomodation');
        hold(axesHandler,'on');

        for i=1:length(handles.model)
            %Plot the data
            %size(handles.data_fix_outliers(i,:))
            %size(handles.dL(i,:))
            %size(handles.dH(i,:))
            %size(handles.t)
            plot(axesHandler,handles.t_fix,handles.data_fix_outliers(i,:),'g--', handles.t_fix,handles.dL(i,:), 'k',handles.t_fix,handles.dH(i,:), 'k');
            legend(axesHandler,'Original Data','Accommodated Data','Lower Limit','Upper Limit');        
            legend(axesHandler,'show');
            hold(axesHandler,'on');
        end
    end
    

    % Update handles structure
    guidata(hObject, handles);    
    
% --- Handles icon's visibility changes when the user is navigating through tabs
function setVisibility(tab,handles,hObject)
    if (tab==1)
        %Clear Axes3
        cla(handles.axes3);
        cla(handles.axes4);
        legend(handles.axes3,'hide');
        legend(handles.axes4,'hide');
        
        set(handles.axes1,'Visible','on');
        set(handles.axes2,'Visible','on');
        set(handles.axes3,'Visible','off');
        set(handles.axes4,'Visible','off');
        set(handles.go_bt,'Visible','on');
        
        set(handles.file_io_panel,'Visible','on');
        set(handles.miss_values_panel,'Visible','on');
        set(handles.time_series_info_panel,'Visible','on');
        
        set(handles.outlier_detection_panel,'Visible','off');
        set(handles.result_analysis_panel,'Visible','off');
        
        set(handles.table_panel,'Visible','off'); 
        
        if ( handles.showModel == 1 && isempty(handles.model) == 0 )
            legend(handles.axes2,'show');
            plotData(hObject,handles,handles.axes2);
        end
        
    elseif (tab==2)
        %Clear Axes3
        cla(handles.axes3);
        legend(handles.axes3,'hide');
        
        set(handles.axes1,'Visible','on');
        set(handles.axes2,'Visible','on');
        set(handles.axes3,'Visible','off');
        set(handles.axes4,'Visible','on');
        set(handles.go_bt,'Visible','off');
        
        set(handles.file_io_panel,'Visible','off');
        set(handles.miss_values_panel,'Visible','off');
        set(handles.time_series_info_panel,'Visible','off');
        
        set(handles.outlier_detection_panel,'Visible','on');
        set(handles.result_analysis_panel,'Visible','on');
        
        set(handles.table_panel,'Visible','off');
        
        if ( handles.showModel == 1 && isempty(handles.model) == 0 )
            legend(handles.axes2,'show');
            plotData(hObject,handles,handles.axes2);
        end
        if (~isempty(find(handles.metrics == 2, 1)))%Difference metric selected
            plotDifferenceSeries(hObject, handles);
        end
        
    elseif (tab==3)
        %Clear the axes2
        cla(handles.axes2);  
        cla(handles.axes4);
        legend(handles.axes2,'hide');
        legend(handles.axes4,'hide');
        
        set(handles.axes1,'Visible','on');
        set(handles.axes2,'Visible','off');
        set(handles.axes3,'Visible','on');
        set(handles.axes4,'Visible','off');
        set(handles.go_bt,'Visible','off');
        
        set(handles.file_io_panel,'Visible','off');
        set(handles.miss_values_panel,'Visible','off');
        set(handles.time_series_info_panel,'Visible','off');
        
        set(handles.outlier_detection_panel,'Visible','off');
        set(handles.result_analysis_panel,'Visible','off');
        
        set(handles.table_panel,'Visible','on');
        
        if ( handles.showModel == 1 && isempty(handles.model) == 0 )           
            plotData(hObject,handles,handles.axes3);
            legend(handles.axes3,'show');
        end
    end
    
    % Update handles structure
    guidata(hObject, handles);
    
function m = interp_method(in)
    if strcmp(in,'Linear')
        m = 'linear';
    elseif strcmp(in, 'Zero-Order Hold')
        m = 'zoh';
    else
        disp('error');
    end
    
function valid=validate_preprocessing_data(handles)    
    if isempty(handles.data_miss) || isempty(handles.t)
        valid = 0; return;
    end

    
    if handles.resampleData && ( handles.samplingPeriod > handles.t(end)-handles.t(1) || handles.samplingPeriod <= 0)
        valid = 0; return;
    end
    
    valid = 1;
    
function valid = validate_accomodation_data(handles)

    %Make sure we've got pre-processed data
    if isempty(handles.data_fix)
        valid = 0; return;
    end
    
    %Make sure we've got at least something selected (is this right?
    if isempty(handles.model)
        valid = 0; return;
    end
    
    
    for i=1:length(handles.model)
        
            % If the user hasn't set any parameters, it's okay, just move
            % on (FIXME: Later on we can remove this if)
            if (length(handles.parameters)<2)
                continue;
            end
            j = handles.model(i) + 1;        
            
            % Check that the window is in the range ]0,N]�: N is length of
            % data
            if handles.parameters(j,3) <= 0 || handles.parameters(j,3) > length(handles.data_fix)
                valid = 0; return;
            end
            
            % Check that the overlap is < window size and >= 0
            if handles.parameters(j,4) > handles.parameters(j,3) || handles.parameters(j,4) <= 0
                valid = 0; return;
            end
    end
valid = 1;

%%%
%%  This next function will store the default values of the parameters
%%%
function z = default_parameters()
    
    z = zeros(6,5);%To store all the parameters
    
    z(1,2:5) = [2 20 2 1];
    z(2,2:5) = [3 20 2 1];
    z(3,2:5) = [2.31 20 2 1];
    z(4,2:5) = [0.05 20 2 1];
    z(5,2:5) = [3.5 20 2 1];
    z(6,2:5) = [3 20 2 1];
    
%%%
%%  This function plots the difference to original data
%%%
function plotDifferenceSeries(hObject, handles) 

    %Plot difference between the series
    plot(handles.axes4,handles.t_fix,handles.diffseries,'--');
    legend(handles.axes4,'Difference Between the Two Series');
    title('Difference to Original Data');
    legend(handles.axes4,'show');
    hold(handles.axes4,'on');
    
    % Update handles structure
    guidata(hObject, handles);
    
    
function save_file(fullpath,time,data)
    fullpath = char(fullpath)
    csvwrite(fullpath,  [ time data' ])
