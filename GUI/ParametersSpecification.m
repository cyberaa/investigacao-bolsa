function varargout = ParametersSpecification(varargin)
% PARAMETERSSPECIFICATION MATLAB code for ParametersSpecification.fig
%      PARAMETERSSPECIFICATION, by itself, creates a new PARAMETERSSPECIFICATION or raises the existing
%      singleton*.
%
%      H = PARAMETERSSPECIFICATION returns the handle to a new PARAMETERSSPECIFICATION or the handle to
%      the existing singleton*.
%
%      PARAMETERSSPECIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAMETERSSPECIFICATION.M with the given input arguments.
%
%      PARAMETERSSPECIFICATION('Property','Value',...) creates a new PARAMETERSSPECIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ParametersSpecification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ParametersSpecification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ParametersSpecification

% Last Modified by GUIDE v2.5 19-Jan-2014 14:34:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ParametersSpecification_OpeningFcn, ...
                   'gui_OutputFcn',  @ParametersSpecification_OutputFcn, ...
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


% --- Executes just before ParametersSpecification is made visible.
function ParametersSpecification_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ParametersSpecification (see VARARGIN)

% Choose default command line output for ParametersSpecification
%handles.output = hObject;

    handles.slidingWindow = 0;    
    
    temp = varargin(1);
    
    handles.temp_2 = temp{1};
    
    set(handles.sndText,'String',handles.temp_2(1));
    set(handles.sndValue,'String',handles.temp_2(2));
    set(handles.sndHelpText,'String',handles.temp_2(3));
    
    %Set Sliding window checked
    set(handles.slidingWindowCheckbox,'Value',1);
    set(handles.windowOverlap,'Visible','off');
    set(handles.windowOverlapValue,'Visible','off');
    
    handles.accommodationType = 'Linear';
    
    snd = get(handles.sndValue,'String');    
    snd = str2double(snd);
    
    handles.output = [handles.figure1 snd 20 19 1];

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes ParametersSpecification wait for user response (see UIRESUME)
    uiwait(handles.figure1);

 

% --- Outputs from this function are returned to the command line.
function varargout = ParametersSpecification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    
    varargout{1} = handles.output;

    uiresume(handles.figure1);%So the output function can be called



function sndValue_Callback(hObject, eventdata, handles)
% hObject    handle to sndValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sndValue as text
%        str2double(get(hObject,'String')) returns contents of sndValue as a double


% --- Executes during object creation, after setting all properties.
function sndValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sndValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function windowSizeValue_Callback(hObject, eventdata, handles)
% hObject    handle to windowSizeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windowSizeValue as text
%        str2double(get(hObject,'String')) returns contents of windowSizeValue as a double


% --- Executes during object creation, after setting all properties.
function windowSizeValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowSizeValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function windowOverlapValue_Callback(hObject, eventdata, handles)
% hObject    handle to windowOverlapValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windowOverlapValue as text
%        str2double(get(hObject,'String')) returns contents of windowOverlapValue as a double


% --- Executes during object creation, after setting all properties.
function windowOverlapValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windowOverlapValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok_bt.
function ok_bt_Callback(hObject, ~, handles)
% hObject    handle to ok_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    snd = get(handles.sndValue,'String');    
    snd = str2double(snd);
    windowSize = get(handles.windowSizeValue,'String');
    windowSize = str2double(windowSize);
    windowOverlap = get(handles.windowOverlapValue,'String');
    
    if (isempty(windowOverlap))
        windowOverlap = -1;
    else
        windowOverlap = str2double(windowOverlap);%Fixme maxi verificaçoes. N�o � aqui, cabr�n!
    end
    
    if (get(handles.slidingWindowCheckbox,'Value'))
        windowOverlap = windowSize-1;
    end
    
    if (isnan(snd) || isnan(windowSize) || isnan(windowOverlap))%Alertar user input mal
        errordlg('Invalid Parameters Values! Please insert numeric values for the Parameters','Invalid Parameters Values');
        return ;
    end
        
    handles.output = [handles.figure1 snd windowSize windowOverlap];
    
    if (strcmp(handles.accommodationType,'Average'))
        handles.output(5) = 0;
    elseif(strcmp(handles.accommodationType,'Median'))
        handles.output(5) = 2;
    else
        handles.output(5) = 1;
    end

    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.figure1);


% --- Executes on button press in cancel_bt.
function cancel_bt_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    snd = get(handles.sndValue,'String');    
    snd = str2double(snd);
    
    handles.output = [handles.figure1 snd 20 19 1];
    
    handles.output
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.figure1);
    
    
    


% --- Executes on button press in slidingWindowCheckbox.
function slidingWindowCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to slidingWindowCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of slidingWindowCheckbox

    handles.slidingWindow = mod(handles.slidingWindow+1,2);
    
    if (get(handles.slidingWindowCheckbox,'Value'))
        set(handles.windowOverlap,'Visible','off');
        set(handles.windowOverlapValue,'Visible','off');
    else
        set(handles.windowOverlap,'Visible','on');
        set(handles.windowOverlapValue,'Visible','on');
    end
    
    % Update handles structure
    guidata(hObject, handles);
 


% --- Executes on selection change in accommodationTypeList.
function accommodationTypeList_Callback(hObject, eventdata, handles)
% hObject    handle to accommodationTypeList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns accommodationTypeList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from accommodationTypeList

    contents = cellstr(get(hObject,'String'));
    handles.accommodationType = contents{get(hObject,'Value')};
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function accommodationTypeList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accommodationTypeList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
    handles.output = [];
    
    % Update handles structure
    guidata(hObject, handles);
    
    delete(hObject);
