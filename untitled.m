function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 17-Dec-2013 11:45:55

% Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @untitled_OpeningFcn, ...
                       'gui_OutputFcn',  @untitled_OutputFcn, ...
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


    % --- Executes just before untitled is made visible.
    function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to untitled (see VARARGIN)


    %%%%
    %%  FIXME FIXME!!!!!!!!
    %%  FIXME FIXME!!!!!!!!
    %%  FIXME FIXME!!!!!!!!
    %%  FIXME FIXME!!!!!!!!
    %%  FIXME FIXME!!!!!!!!
    %%  FIXME FIXME!!!!!!!!
    %%%%


    %FIXME: This next lines of code are just here for testing purposes, since
    %we arent loading files dynamically into the workspace. Therefore, and to
    %have something to show our mentors, we are going to "simulate" the data.
    handles.t=(0:500)';
    data = generate_time_series(-1,1,length(handles.t),-5,5);
    handles.data = data';
    handles.data_miss = add_missing(handles.data, 0.10);
    [handles.data_outliers,handles.outlier_locations]=add_outliers(handles.data, 0.15,std(handles.data)*1.15,std(handles.data)*1.15);
    handles.data_fix_outliers = [];
    handles.dL = [];
    handles.dH = [];

    handles.plotReferences = [];%Stores the plots computed by the GUI

    %Load data into the table - FIXME this is temporary!
    %set(handles.table,'Data',handles.data);

    %User decision in terms of algorithms and data resampling and filling missing values
    handles.iqr=0;
    handles.modifiedzscore=0;
    handles.grubbs=0;
    handles.mad=0;
    handles.snd=0;
    handles.resampleData = 0;
    handles.fillMissing = 0;
    handles.model = [];%Stores the methods chosen by the user
    handles.metrics = [];%Stores the metrics to compare the results, selected by the user
    handles.results = [];%Stores the results to be presented to the user in the 3rd tab table

    %User selected metrics to compare results
    handles.euclidean=0;
    handles.differenceToOriginal=0;
    handles.complexTimeInvariant=0;
    
    %Show the main tab
    setVisibility(1,handles,hObject);
    
    
    % Choose default command line output for untitled
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, ~, handles) 
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


function file_text_Callback(hObject, eventdata, handles)
% hObject    handle to file_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_text as text
%        str2double(get(hObject,'String')) returns contents of file_text as a double



% --- Executes during object creation, after setting all properties.
function file_text_CreateFcn(hObject, ~, handles)
% hObject    handle to file_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
    % Update handles structure
    guidata(hObject, handles);
    
    
function samplingPeriodText_Callback(hObject, eventdata, handles)
% hObject    handle to samplingPeriodText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samplingPeriodText as text
%        str2double(get(hObject,'String')) returns contents of samplingPeriodText as a double


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

% --- Executes on button press in alg_bt1.
function alg_bt1_Callback(hObject, ~, handles)
% hObject    handle to alg_bt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of alg_bt1
    if ( get(hObject,'Value') == 1)
        handles.algorithm1 = 1;
        % Update handles structure
        guidata(hObject, handles);
    end


% --- Executes on button press in alg_bt2.
function alg_bt2_Callback(hObject, ~, handles)
% hObject    handle to alg_bt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of alg_bt2
    if ( get(hObject,'Value') == 1)
        handles.algorithm2 = 1;
        % Update handles structure
        guidata(hObject, handles);
    end  
    
% --- Executes on button press in dm_bt1.
function dm_bt1_Callback(hObject, ~, handles)
% hObject    handle to dm_bt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dm_bt1

    if ( get(hObject,'Value') == 1)
        set(handles.dm_bt2,'Value',0);
        % Update handles structure
        guidata(hObject, handles);
    end


% --- Executes on button press in dm_bt2.
function dm_bt2_Callback(hObject, ~, handles)
% hObject    handle to dm_bt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dm_bt2 

    if ( get(hObject,'Value') == 1)
        set(handles.dm_bt1,'Value',0);
        % Update handles structure
        guidata(hObject, handles);
    end


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


    %%%
    %%  FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME 
    %%%
    numberOutliers = 35;%FIXME HERE
    minV = min(handles.data);
    maxV = max(handles.data);
    meanV = mean(handles.data); 
    stdV = std(handles.data);

    %Start ploting the data
    %Reset the axes
    cla(handles.axes1);

    plot(handles.axes1,handles.t,handles.data,'b--',handles.t,handles.data_miss,'g--',handles.t,handles.data_outliers,'c--');
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

        handles.data_fix = fix_missing(handles.t,handles.data_miss);
        plot(handles.axes1,handles.t,handles.data_fix,'--');
        legend(handles.axes1,'Original Series', 'Series With Missing Values Corrected','Series With Outliers','Series With Missing Values Fixed');
        hold(handles.axes1,'on');
    else
        legend(handles.axes1,'Original Series', 'Series With Missing Values', 'Series With Outliers');
    end
    
    set(handles.estnumoutliers,'String',['Estimated Number of Outliers: ' num2str(numberOutliers)]);
    set(handles.mean,'String', ['Mean: ' num2str(meanV)]);
    set(handles.std,'String', ['Standard Deviation: ' num2str(stdV)]);
    set(handles.minValue,'String',['Miniimum Value: ' num2str(minV)]);
    set(handles.maxValue,'String',['Maximum Value: ' num2str(maxV)]);
    
    % Update handles structure
    guidata(hObject, handles);



function inputfile_Callback(hObject, eventdata, handles)
% hObject    handle to inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputfile as text
%        str2double(get(hObject,'String')) returns contents of inputfile as a double


% --- Executes during object creation, after setting all properties.
function inputfile_CreateFcn(hObject, ~, handles)
% hObject    handle to inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
    % Update handles structure
    guidata(hObject, handles);



function outputfile_Callback(hObject, eventdata, handles)
% hObject    handle to outputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outputfile as text
%        str2double(get(hObject,'String')) returns contents of outputfile as a double


% --- Executes during object creation, after setting all properties.
function outputfile_CreateFcn(hObject, ~, handles)
% hObject    handle to outputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in
function fillmissingcheckbox_Callback(hObject, ~, handles)
% hObject    handle to fillmissingcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fillmissingcheckbox

    handles.fillMissing = mod(handles.fillMissing+1,2);
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on selection change in linearmenu.
function linearmenu_Callback(hObject, eventdata, handles)
% hObject    handle to linearmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns linearmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from linearmenu


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
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in eucldistcheckbox.
function eucldistcheckbox_Callback(hObject, ~, handles)
% hObject    handle to eucldistcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of eucldistcheckbox
    handles.euclidean=mod((handles.euclidean+1),2);
    if (handles.euclidean == 1)
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
    handles.differenceToOriginal=mod((handles.differenceToOriginal+1),2);
    if (handles.differenceToOriginal == 1)
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
    handles.complexTimeInvariant=mod((handles.complexTimeInvariant+1),2);
    if (handles.complexTimeInvariant == 1)
        handles.metrics = [handles.metrics 3];
    elseif (ismember(3,handles.metrics) == 1)%If we unselected the method we must remove it from the list of methods
        handles.metrics = handles.metrics(handles.metrics ~= 3);
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in iqrcheckbox.
function iqrcheckbox_Callback(hObject, ~, handles)
% hObject    handle to iqrcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of iqrcheckbox
    
    handles.iqr = mod((handles.iqr + 1),2);
    if (handles.iqr == 1)
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
    
    handles.snd = mod((handles.snd + 1),2);
    if (handles.snd == 1)
        handles.model = [handles.model 0];
    elseif (ismember(1,handles.model) == 1)%If we unselected the method we must remove it from the list of methods
        handles.model = handles.model(handles.model ~= 1);
    end
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in madcheckbox.
function madcheckbox_Callback(hObject, ~, handles)
% hObject    handle to madcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of madcheckbox
    
    handles.mad = mod((handles.mad + 1),2);
    if (handles.mad == 1)
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
    
    handles.grubbs = mod((handles.grubbs + 1),2);
    if (handles.grubbs == 1)
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
    
    handles.modifiedzscore = mod((handles.modifiedzscore + 1),2);
    if (handles.modifiedzscore == 1)
        handles.model = [handles.model 4];
    elseif (ismember(4,handles.model) == 1)%If we unselected the method we must remove it from the list of methods
        handles.model = handles.model(handles.model ~= 4);
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in accommodate_bt.
function accommodate_bt_Callback(hObject, ~, handles)
% hObject    handle to accommodate_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    outlier_locations = handles.outlier_locations';
    handles.data_fix_outliers = zeros(length(handles.model),length(handles.data));
    outliers = zeros(length(handles.model),length(handles.data));
    handles.dL = zeros(length(handles.model),length(handles.data));
    handles.dH = zeros(length(handles.model),length(handles.data));
    
    for i=1:length(handles.model)
        [handles.data_fix_outliers(i,:),outliers(i,:),handles.dL(i,:),handles.dH(i,:)] = accomodate_outliers(handles.t,handles.data_outliers,round(0.01*length(handles.t)),round(0.01*length(handles.t))-1,0.85,handles.model(i));
        handles.results(i,1) = sum(outliers(i,:));
        handles.results(i,2) = max(handles.data_fix_outliers(i,:));
        handles.results(i,3) = min(handles.data_fix_outliers(i,:));
        handles.resuts(i,4) = mean(handles.data_fix_outliers(i,:));
        handles.results(i,5) = std(handles.data_fix_outliers(i,:)); 
        
        handles.cnames = {'Number of Outliers Detected','Max Value', 'Min Value', 'Mean', 'STD'};   
        
        %Now we will compute the metric's comparison
        for j=1:length(handles.metrics)
            if (handles.metrics(j) == 1)
                handles.cnames{length(handles.cnames)+1} = 'Euclidean';
                handles.results(i,length(handles.cnames)) = sqrt(sum((handles.data_outliers'-handles.data_fix_outliers).^2));                
            
            elseif (handles.metrics(j) == 2)
                handles.cnames{length(handles.cnames)+1} = 'Difference';
                handles.results(i,length(handles.cnames)) = sqrt(sum(abs(handles.data_outliers'-handles.data_fix_outliers)));                
            
            else
                handles.cnames{length(handles.cnames)+1} = 'Comp Time-Invariant';
            end
        end
    end
    
    
    fprintf('Inserted %d outliers, found %d.\n', sum(outlier_locations), sum(sum(outliers)));

    %Plot the results of the Outlier accommodation methods used
    plotData(hObject,handles,2);
    
    %%%
    %% Get methods - For now this will stay here... Maybe we could do this on the callback function where we select each method, however it would be
    %%               more difficult to implement this. Same goes to the metrics
    %%%
    handles.methodsName = {};
    for i=1:length(handles.model)
        if (handles.model(i) == 2)
            handles.methodsName{length(handles.methodsName)+1} = 'IQR Method';
        elseif (handles.model(i) == 0)
            handles.methodsName{length(handles.methodsName)+1} = 'SND Method';
        elseif (handles.model(i) == 4)
            handles.methodsName{length(handles.methodsName)+1} = 'Modified Z-Score';
        elseif (handles.model(i) == 5)
            handles.methodsName{length(handles.methodsName)+1} = 'MAD Test';
        else
            handles.methodsName{length(handles.methodsName)+1} = 'Grubbs Test';
        end
    end
    
    %Update Table with metrics
    set(handles.table,'data',handles.results,'ColumnName',handles.cnames,'RowName',handles.methodsName);
    
    % Update handles structure
    guidata(hObject, handles);
    

% --- Plots the results of the Outlier's accommodation methods applied, as selected by the user
function plotData(hObject,handles,axesNumber)     

    data_outliers = handles.data_outliers';
    t_outlier = handles.t;   
    
    handles.plotReferences = [];
    
    if (axesNumber == 2)
        axesHandler = handles.axes2;
    elseif (axesNumber == 3)
        axesHandler = handles.axes3;
    end
        
    %Reset the axes
    cla(axesHandler);

    % Update handles structure
    guidata(hObject, handles);

    %Plot the data
    plot(axesHandler,t_outlier,data_outliers,'r.',t_outlier,handles.data,'y.');
    title(axesHandler,'Outlier Detection and Accomodation');
    hold(axesHandler,'on');
    
    for i=1:length(handles.model)
        %Plot the data
        plot(axesHandler,handles.t,handles.data_fix_outliers(i,:),handles.t,handles.dL(i,:),handles.t,handles.dH(i,:));
        legend(axesHandler,'Outliers','Original','Accommodated','Lower Limit','Upper Limit');        
        legend(axesHandler,'show');
        hold(axesHandler,'on');
    end

    % Update handles structure
    guidata(hObject, handles);    
    
% --- Handles icon's visibility changes when the user is navigating through tabs
function setVisibility(tab,handles,hObject)
    if (tab==1)
        %Clear Axes3
        cla(handles.axes3);
        legend(handles.axes3,'hide');
        
        set(handles.axes1,'Visible','on');
        set(handles.axes2,'Visible','on');
        set(handles.axes3,'Visible','off');
        set(handles.go_bt,'Visible','on');
        
        set(handles.file_io_panel,'Visible','on');
        set(handles.miss_values_panel,'Visible','on');
        set(handles.resampling_panel,'Visible','on');
        set(handles.time_series_info_panel,'Visible','on');
        
        set(handles.outlier_detection_panel,'Visible','off');
        set(handles.result_analysis_panel,'Visible','off');
        
        set(handles.table_panel,'Visible','off'); 
        
        if ( isempty(handles.model) == 0 )
            legend(handles.axes2,'show');
            plotData(hObject,handles,2);
        end
        
    elseif (tab==2)
        %Clear Axes3
        cla(handles.axes3);
        legend(handles.axes3,'hide');
        
        set(handles.axes1,'Visible','on');
        set(handles.axes2,'Visible','on');
        set(handles.axes3,'Visible','off');
        set(handles.go_bt,'Visible','off');
        
        set(handles.file_io_panel,'Visible','off');
        set(handles.miss_values_panel,'Visible','off');
        set(handles.resampling_panel,'Visible','off');
        set(handles.time_series_info_panel,'Visible','off');
        
        set(handles.outlier_detection_panel,'Visible','on');
        set(handles.result_analysis_panel,'Visible','on');
        
        set(handles.table_panel,'Visible','off');
        
        if ( isempty(handles.model) == 0 )
            legend(handles.axes2,'show');
            plotData(hObject,handles,2);
        end
        
    elseif (tab==3)
        %Clear the Axes2
        cla(handles.axes2);    
        legend(handles.axes2,'hide');
        
        set(handles.axes1,'Visible','on');
        set(handles.axes2,'Visible','off');
        set(handles.axes3,'Visible','on');
        set(handles.go_bt,'Visible','off');
        
        set(handles.file_io_panel,'Visible','off');
        set(handles.miss_values_panel,'Visible','off');
        set(handles.resampling_panel,'Visible','off');
        set(handles.time_series_info_panel,'Visible','off');
        
        set(handles.outlier_detection_panel,'Visible','off');
        set(handles.result_analysis_panel,'Visible','off');
        
        set(handles.table_panel,'Visible','on');
        
        if ( isempty(handles.model) == 0 )           
            plotData(hObject,handles,3);
            legend(handles.axes3,'show');
        end
    end
    
    % Update handles structure
    guidata(hObject, handles);
