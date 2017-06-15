function varargout = addition(varargin)
% ADDITION MATLAB code for addition.fig
%      ADDITION, by itself, creates a new ADDITION or raises the existing
%      singleton*.
%
%      H = ADDITION returns the handle to a new ADDITION or the handle to
%      the existing singleton*.
%
%      ADDITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADDITION.M with the given input arguments.
%
%      ADDITION('Property','Value',...) creates a new ADDITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before addition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to addition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help addition

% Last Modified by GUIDE v2.5 12-Jun-2017 13:16:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @addition_OpeningFcn, ...
                   'gui_OutputFcn',  @addition_OutputFcn, ...
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


% --- Executes just before addition is made visible.
function addition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to addition (see VARARGIN)

% Choose default command line output for addition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes addition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = addition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function TXT_chiffre1_Callback(hObject, eventdata, handles)
% hObject    handle to TXT_chiffre1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXT_chiffre1 as text
%        str2double(get(hObject,'String')) returns contents of TXT_chiffre1 as a double


% --- Executes during object creation, after setting all properties.
function TXT_chiffre1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXT_chiffre1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXT_chiffre2_Callback(hObject, eventdata, handles)
% hObject    handle to TXT_chiffre2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXT_chiffre2 as text
%        str2double(get(hObject,'String')) returns contents of TXT_chiffre2 as a double


% --- Executes during object creation, after setting all properties.
function TXT_chiffre2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXT_chiffre2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BUT_calcul.
function BUT_calcul_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_calcul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = str2num(handles.TXT_chiffre1.String) ;
b = str2num(handles.TXT_chiffre2.String) ;
c = a + b ;
set(handles.TXT_result,'String',c) ;


