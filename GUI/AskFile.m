function varargout = AskFile(varargin)
% ASKFILE MATLAB code for AskFile.fig
%      ASKFILE, by itself, creates a new ASKFILE or raises the existing
%      singleton*.
%
%      H = ASKFILE returns the handle to a new ASKFILE or the handle to
%      the existing singleton*.
%
%      ASKFILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASKFILE.M with the given input arguments.
%
%      ASKFILE('Property','Value',...) creates a new ASKFILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AskFile_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AskFile_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AskFile

% Last Modified by GUIDE v2.5 19-Jan-2014 17:29:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AskFile_OpeningFcn, ...
                   'gui_OutputFcn',  @AskFile_OutputFcn, ...
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


% --- Executes just before AskFile is made visible.
function AskFile_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to AskFile (see VARARGIN)

    % Choose default command line output for AskFile
    handles.output = hObject;


    handles.directory = '';

    handles.output = {handles.figure1 '' handles.directory};

    set(handles.fileText,'Visible','off');
    set(handles.fileNameText,'Visible','off');
    set(handles.directoryText,'Visible','off');
    set(handles.directory_bt,'Visible','off');

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes AskFile wait for user response (see UIRESUME)
    uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AskFile_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;
    
    uiresume(handles.figure1);%So the output function can be called


% --- Executes on button press in ok_bt.
function ok_bt_Callback(hObject, eventdata, handles)
% hObject    handle to ok_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if (get(handles.saveFileCheckbox,'Value'))
        if (strcmp(handles.directory,''))
            errordlg('No Directory Specified! Please select a directory','No Directory Specified');
            return;
        end
        handles.output =  {handles.figure1 get(handles.fileNameText,'String') handles.directory};
    else
        handles.output = {handles.figure1 '' handles.directory};
    end
    
    handles.output
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.figure1);


% --- Executes on button press in cancel_bt.
function cancel_bt_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    handles.output = {handles.figure1 '' ''};
    
    % Update handles structure
    guidata(hObject, handles);

    uiresume(handles.figure1);

% --- Executes on button press in saveFileCheckbox.
function saveFileCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to saveFileCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveFileCheckbox

    if (get(handles.saveFileCheckbox,'Value'))
        set(handles.fileText,'Visible','on');
        set(handles.fileNameText,'Visible','on');
        set(handles.directoryText,'Visible','on');
        set(handles.directory_bt,'Visible','on');
    else
        set(handles.fileText,'Visible','off');
        set(handles.fileNameText,'Visible','off');
        set(handles.directoryText,'Visible','off');
        set(handles.directory_bt,'Visible','off');
    end
    
    % Update handles structure
    guidata(hObject, handles);



function fileNameText_Callback(hObject, eventdata, handles)
% hObject    handle to fileNameText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileNameText as text
%        str2double(get(hObject,'String')) returns contents of fileNameText as a double


% --- Executes during object creation, after setting all properties.
function fileNameText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileNameText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in directory_bt.
function directory_bt_Callback(hObject, eventdata, handles)
% hObject    handle to directory_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.directory = uigetdir();
    
    set(handles.directoryText,'String', handles.directory);
    
    % Update handles structure
    guidata(hObject, handles);
    
