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

% Last Modified by GUIDE v2.5 29-Oct-2013 18:03:11

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
%%  Data to plot
%%%%

ns=100;
num_outliers=17;
outlier_min=0.5;
outlier_max=1.5;
snd=1.5;
window_size=10;

series=generate_time_series2(ns);
outliers=general_add_outliers(series, num_outliers,outlier_min,outlier_max);
    
[Y,band_low,band_high]=general_detect_outliers_linear(outliers,window_size,snd,1, 1:length(outliers));
no_outliers=Y(1,:);
[Ymedia,band_lowmedia,band_highmedia]=general_detect_outliers_linear(outliers,window_size,snd,0, 1:length(outliers));
no_outliers_media=Ymedia(1,:);

handles.outliers = outliers;
handles.Alg2Linear = no_outliers;
handles.Alg2LinearMean = no_outliers_media;
handles.series = series;
handles.band_low = band_low;
handles.band_high = band_high;
handles.band_lowmedia = band_lowmedia;
handles.band_highmedia = band_highmedia;
handles.print = 0;%By default

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

val = get(hObject, 'Value');
str = get(hObject, 'String');

%%FIXME FIXME FIXME FIXME 
switch str{val}
    case 'Algorithm1'
        handles.print = 1;
    case 'Algorithm2'
        handles.print = 1;
    case 'Choose Algorithm'
        handles.print = 0;
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runAlgorithms.
function runAlgorithms_Callback(hObject, eventdata, handles)
% hObject    handle to runAlgorithms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
cla reset;%Reset plot

if (handles.print == 1)
    plot(handles.axes1,handles.outliers,'b');   
    hold(handles.axes1,'on');
    plot(handles.axes1,handles.Alg2Linear,'--r');
    hold(handles.axes1,'on');
    plot(handles.axes1,handles.Alg2LinearMean,'-.k');
    hold(handles.axes1,'on');
    plot(handles.axes1,handles.series,'g');
    hold(handles.axes1,'on');
    %{
    plot(handles.axes1,handles.band_low, 'r');
    hold(handles.axes1,'on');
    plot(handles.axes1,handles.band_high, 'r');
    hold(handles.axes1,'on');
    plot(handles.axes1,handles.band_lowmedia, 'black');
    hold(handles.axes1,'on');
    plot(handles.axes1,handles.band_highmedia, 'black');
    hold(handles.axes1,'on');
    %}
    leng = legend(handles.axes1,'Series W/Outliers', 'Series W/O Outliers (Linear)' ,'Series W/O Outliers (Mean)', 'Original Series');
    %Make legend movable : set(leng, 'XColor', 'w', 'YColor', 'w', 'Color', 'none');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


%%FIXME FIXME FIXME WHAT TO DO HERE??



% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
