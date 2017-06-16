function varargout = GUI_interactive_graph_all_samples(all_samples, varargin)
% GUI_INTERACTIVE_GRAPH MATLAB code for GUI_interactive_graph.fig
%      GUI_INTERACTIVE_GRAPH, by itself, creates a new GUI_INTERACTIVE_GRAPH or raises the existing
%      singleton*.
%
%      H = GUI_INTERACTIVE_GRAPH returns the handle to a new GUI_INTERACTIVE_GRAPH or the handle to
%      the existing singleton*.
%
%      GUI_INTERACTIVE_GRAPH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_INTERACTIVE_GRAPH.M with the given input arguments.
%
%      GUI_INTERACTIVE_GRAPH('Property','Value',...) creates a new GUI_INTERACTIVE_GRAPH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_interactive_graph_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_interactive_graph_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_interactive_graph

% Last Modified by GUIDE v2.5 16-Jun-2017 13:38:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_interactive_graph_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_interactive_graph_OutputFcn, ...
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


% --- Executes just before GUI_interactive_graph is made visible.
function GUI_interactive_graph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_interactive_graph (see VARARGIN)

global out

out = all_samples ;

% this is just to test the code
% % to be deleted until 'end deletion' 
% load Experience1
% global out          
% out = Out_exp1 ;
% % end deletion





% Choose default command line output for GUI_interactive_graph
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_interactive_graph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_interactive_graph_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BUT_robustness.
function BUT_robustness_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_robustness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global out

% recover x and y you wnat to plot
x = str2num(handles.TXT_value_X_plot.String) ;
y = str2num(handles.TXT_value_y_plot.String) ;

disp('button pressed')



% call of the function to plot the x and y selected 
% to have more detail tape 'help(interactive_graph)'
column = handles.POPUP_rectangle.Value
interactive_graph_all_samples(out, x, y, column)





function TXT_value_y_plot_Callback(hObject, eventdata, handles)
% hObject    handle to TXT_value_y_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXT_value_y_plot as text
%        str2double(get(hObject,'String')) returns contents of TXT_value_y_plot as a double


% --- Executes during object creation, after setting all properties.
function TXT_value_y_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXT_value_y_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TXT_value_X_plot_Callback(hObject, eventdata, handles)
% hObject    handle to TXT_value_X_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXT_value_X_plot as text
%        str2double(get(hObject,'String')) returns contents of TXT_value_X_plot as a double


% --- Executes during object creation, after setting all properties.
function TXT_value_X_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXT_value_X_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in POPUP_rectangle.
function POPUP_rectangle_Callback(hObject, eventdata, handles)
% hObject    handle to POPUP_rectangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns POPUP_rectangle contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POPUP_rectangle


% --- Executes during object creation, after setting all properties.
function POPUP_rectangle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POPUP_rectangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BUT_plot_rectangles.
function BUT_plot_rectangles_Callback(hObject, eventdata, handles)

% global out
% hObject    handle to BUT_plot_rectangles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% x = str2num(handles.TXT_value_X_plot.String) ;
% y = str2num(handles.TXT_value_y_plot.String) ;


% plot_rectangles(out, x, y)



function TXT_Name_data_Callback(hObject, eventdata, handles)
% hObject    handle to TXT_Name_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TXT_Name_data as text
%        str2double(get(hObject,'String')) returns contents of TXT_Name_data as a double


% --- Executes during object creation, after setting all properties.
function TXT_Name_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXT_Name_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BUT_load_data.
function BUT_load_data_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% val = handles.TXT_Name_data.String ;
% load(val)
% global out
% out = Out_exp1 ;

% disp('Data loaded')
