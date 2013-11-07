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

% Last Modified by GUIDE v2.5 07-Nov-2013 09:49:02

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

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%%%
%%  FIXME FIXME!!!!!!!!
%%  FIXME FIXME!!!!!!!!
%%  FIXME FIXME!!!!!!!!
%%  FIXME FIXME!!!!!!!!
%%  FIXME FIXME!!!!!!!!
%%  FIXME FIXME!!!!!!!!
%%%%
data = rand(3);

handles.algorithm1 = 0;
handles.algorithm2 = 0;

%Load data into the table - FIXME this is temporary!
set(handles.table,'Data',data);

%Unpress all the buttons
set(handles.alg_bt1,'Value',0);
set(handles.alg_bt2,'Value',0);
set(handles.dm_bt1,'Value',0);
set(handles.dm_bt2,'Value',0);

setVisibility(1,handles,hObject);



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



function par_text1_Callback(hObject, eventdata, handles)
% hObject    handle to par_text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of par_text1 as text
%        str2double(get(hObject,'String')) returns contents of par_text1 as a double



% --- Executes during object creation, after setting all properties.
function par_text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to par_text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end




function par_text2_Callback(hObject, eventdata, handles)
% hObject    handle to par_text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of par_text2 as text
%        str2double(get(hObject,'String')) returns contents of par_text2 as a double



% --- Executes during object creation, after setting all properties.
function par_text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to par_text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end




function par_text3_Callback(hObject, eventdata, handles)
% hObject    handle to par_text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of par_text3 as text
%        str2double(get(hObject,'String')) returns contents of par_text3 as a double



% --- Executes during object creation, after setting all properties.
function par_text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to par_text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end




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



function par_text4_Callback(hObject, eventdata, handles)
% hObject    handle to par_text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of par_text4 as text
%        str2double(get(hObject,'String')) returns contents of par_text4 as a double




% --- Executes during object creation, after setting all properties.
function par_text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to par_text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end




function par_text5_Callback(hObject, eventdata, handles)
% hObject    handle to par_text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of par_text5 as text
%        str2double(get(hObject,'String')) returns contents of par_text5 as a double




% --- Executes during object creation, after setting all properties.
function par_text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to par_text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end



function par_text6_Callback(hObject, eventdata, handles)
% hObject    handle to par_text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of par_text6 as text
%        str2double(get(hObject,'String')) returns contents of par_text6 as a double




% --- Executes during object creation, after setting all properties.
function par_text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to par_text6 (see GCBO)
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
    
    
function dest_file_text_Callback(hObject, eventdata, handles)
% hObject    handle to dest_file_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dest_file_text as text
%        str2double(get(hObject,'String')) returns contents of dest_file_text as a double


% --- Executes during object creation, after setting all properties.
function dest_file_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dest_file_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function load_file_text_Callback(hObject, eventdata, handles)
% hObject    handle to load_file_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of load_file_text as text
%        str2double(get(hObject,'String')) returns contents of load_file_text as a double


% --- Executes during object creation, after setting all properties.
function load_file_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_file_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_bt.
function load_bt_Callback(hObject, eventdata, handles)
% hObject    handle to load_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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

% --- Handles icon's visibility changes when the user is navigating through tabs
function setVisibility(tab,handles,hObject)

    if (tab==1)
        set(handles.axes1,'Visible','off');
        set(handles.axes2,'Visible','off');
        set(handles.main_panel,'Visible','on');
        set(handles.table_panel,'Visible','off'); 
        set(handles.alg_panel,'Visible','off');
    elseif (tab==2)
        set(handles.axes1,'Visible','off');
        set(handles.axes2,'Visible','off');
        set(handles.main_panel,'Visible','off');
        set(handles.table_panel,'Visible','off');
        set(handles.alg_panel,'Visible','on');
    elseif (tab==3)
        set(handles.axes1,'Visible','on');
        set(handles.axes2,'Visible','on');
        set(handles.main_panel,'Visible','off');
        set(handles.table_panel,'Visible','on');
        set(handles.alg_panel,'Visible','off');
    end
    
    % Update handles structure
    guidata(hObject, handles);
