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
%data = [28 6 0.30 4.00 2.01 504.40 23.30;38 5.22 0.30 3.98 1.90 401.30 21.50];

%Load data into the table - FIXME this is temporary!
%set(handles.table,'Data',handles.data);

setVisibility(1,handles,hObject);

%Reset the methods
handles.model = [];

handles.iqr=0;
handles.modifiedzscore=0;
handles.grubbs=0;
handles.mad=0;
handles.snd=0;

handles.resampleData = 0;

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in data_depur_bt.
function data_depur_bt_Callback(hObject, eventdata, handles)
% hObject    handle to data_depur_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setVisibility(2,handles,hObject);%Advance to the second tab

% Update handles structure
guidata(hObject, handles);


function file_text_Callback(hObject, eventdata, handles)
% hObject    handle to file_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_text as text
%        str2double(get(hObject,'String')) returns contents of file_text as a double



% --- Executes during object creation, after setting all properties.
function file_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
    
function samplingPeriodText_Callback(hObject, eventdata, handles)
% hObject    handle to samplingPeriodText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samplingPeriodText as text
%        str2double(get(hObject,'String')) returns contents of samplingPeriodText as a double


% --- Executes during object creation, after setting all properties.
function samplingPeriodText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplingPeriodText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in alg_bt1.
function alg_bt1_Callback(hObject, eventdata, handles)
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
function alg_bt2_Callback(hObject, eventdata, handles)
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
function dm_bt1_Callback(hObject, eventdata, handles)
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
function dm_bt2_Callback(hObject, eventdata, handles)
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
function Tab1_Callback(hObject, eventdata, handles)
% hObject    handle to Tab1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    setVisibility(1,handles,hObject);

% --- Executes on button press in Tab2.
function Tab2_Callback(hObject, eventdata, handles)
% hObject    handle to Tab2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    setVisibility(2,handles,hObject);


% --- Executes on button press in Tab3.
function Tab3_Callback(hObject, eventdata, handles)
% hObject    handle to Tab3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    setVisibility(3,handles,hObject); 


% --- Executes on button press in go_bt.
function go_bt_Callback(hObject, eventdata, handles)
% hObject    handle to go_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    %%%
    %%  FIXME
    %%%
    numberOutliers = 35;
    minV = min(handles.data);
    maxV = max(handles.data);
    meanV = mean(handles.data); 
    stdV = std(handles.data);

    %Do Prepocessing!
    handles.data_fix = fix_missing(handles.t,handles.data_miss);
    %Plot the data
    plot(handles.axes1,handles.t,handles.data,handles.t,handles.data_miss,handles.t,handles.data_fix,'--');
    legend(handles.axes1,'Original', 'Missing', 'Fixed');
    title(handles.axes1,'Filling missing data'); 
    
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
function inputfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function outputfile_Callback(hObject, eventdata, handles)
% hObject    handle to outputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outputfile as text
%        str2double(get(hObject,'String')) returns contents of outputfile as a double


% --- Executes during object creation, after setting all properties.
function outputfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fillmissingcheckbox.
function fillmissingcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to fillmissingcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fillmissingcheckbox


% --- Executes on selection change in linearmenu.
function linearmenu_Callback(hObject, eventdata, handles)
% hObject    handle to linearmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns linearmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from linearmenu


% --- Executes during object creation, after setting all properties.
function linearmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to linearmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resampleDataCheckbox.
function resampleDataCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to resampleDataCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of resampleDataCheckbox
    handles.resampleData = handles.resampleData + 1;
    handles.resampleData = mod(handles.resampleData,2);
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in eucldistcheckbox.
function eucldistcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to eucldistcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of eucldistcheckbox


% --- Executes on button press in differencecheckbox.
function differencecheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to differencecheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of differencecheckbox


% --- Executes on button press in complextimecheckbox.
function complextimecheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to complextimecheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of complextimecheckbox


% --- Executes on button press in iqrcheckbox.
function iqrcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to iqrcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of iqrcheckbox
    handles.model = [handles.model 2];
    handles.iqr = mod((handles.iqr + 1),2);
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in sndcheckbox.
function sndcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to sndcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sndcheckbox
    handles.model = [handles.model 1];
    handles.snd = mod((handles.snd + 1),2);
    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in madcheckbox.
function madcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to madcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of madcheckbox
    
    handles.model = [handles.model 5];
    handles.mad = mod((handles.mad + 1),2);
    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in gurbbscheckbox.
function gurbbscheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to gurbbscheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gurbbscheckbox
    handles.model = [handles.model 3];
    handles.grubbs = mod((handles.grubbs + 1),2);
    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in mzscorecheckbox.
function mzscorecheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to mzscorecheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mzscorecheckbox
    handles.model = [handles.model 4];
    handles.modifiedzscore = mod((handles.modifiedzscore + 1),2);
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in accommodate_bt.
function accommodate_bt_Callback(hObject, eventdata, handles)
% hObject    handle to accommodate_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    %%%
    %%  FIXME FIXME FIXME CORRIGIR FORMA COMO CHAMAMOS O ACCOMODATE_OUTLIERS E COMO FAZEMOS O PLOT DOS DADOS??? PODEMOS TER ATE 5 GRAFICOS DIFERENTES
    %%  PARA FAZER!!!
    %%%
    [handles.data_outliers,outlier_locations]=add_outliers(handles.data, 0.15,std(handles.data)*1.15,std(handles.data)*1.15);
    [data_fix_outliers,outliers,dL,dH] = accomodate_outliers(handles.t,handles.data_outliers,round(0.01*length(handles.t)),round(0.01*length(handles.t))-1,0.85,handles.model(1));

    fprintf('Inserted %d outliers, found %d.\n', sum(outlier_locations), sum(outliers));
    
    plot_data(hObject,handles,outlier_locations,data_fix_outliers,dL,dH);
    
    % Update handles structure
    guidata(hObject, handles);
    
   
function plot_data(hObject,handles,outliers,data_fixed,dL,dH)

    hold off;
    
    n = outliers == 1;
    handles.data_outliers = handles.data_outliers(n);
    t_outlier = handles.t(n);    
    plot(handles.axes2,t_outlier,handles.data_outliers,'r.',handles.t,handles.data_fix, 'b',handles.t,data_fixed,'g-.',handles.t,dL,'k',handles.t,dH,'c');
    hold on;
    legend(handles.axes2,'Outliers', 'Original', 'Accomodated','Upper Limit','Lower Limit');
    title(handles.axes2,'Outlier Detection and Accomodation');
    
    % Update handles structure
    guidata(hObject, handles);
     
    
% --- Handles icon's visibility changes when the user is navigating through tabs
function setVisibility(tab,handles,hObject)

    if (tab==1)
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
    elseif (tab==2)
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
    elseif (tab==3)
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
    end
    
    % Update handles structure
    guidata(hObject, handles);
