function varargout = GUI_interactive_graph(varargin)
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

% Last Modified by GUIDE v2.5 19-Jun-2017 11:50:54

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

clc
disp('-------------------------------------------------------------------------------------')
disp(' Welcome ! ')
disp('-------------------------------------------------------------------------------------')

global DATA



disp('Initialization : ')
disp('')


disp('- Adding to path all subfolders of the project')
addPath()

disp('- Set Structure name (a modifier avec données d''Arvind)')
load example_allExperimentData.mat % To be deleted
set(handles.TXT_Name_data, 'String', fieldnames(DATA))

% Hide panel
disp('- Hide panel')
set(handles.PANEL_projection_dimension, 'Visible', 'Off')
set(handles.PANEL_Plot_robustness, 'Visible', 'Off')
set(handles.GRAPH_graph1, 'Visible', 'Off')


% axis(handles.GRAPH_Verimag);
% imshow('verimag.PNG')
% 
% axis(handles.GRAPH_Toyota);
% imshow('toyota.PNG')

warning('TO DO : popup avec N valeurs au lieu de 10')


disp('')
disp('End initialization')
disp('-------------------------------------------------------------------------------------')

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

% --- Executes on button press in BUT_load_data.
function BUT_load_data_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DATA

% disp('- TO DO : make code smarter')
data = DATA.Out_exp1 ;
Out_exp1 = data ;


global OUT
OUT = Out_exp1 ;
disp('-------------------------------------------------------------------------------------')
disp('Data loaded')
disp('-------------------------------------------------------------------------------------')

set(handles.PANEL_projection_dimension, 'Visible', 'On')


% --- Executes on selection change in POPUP_valueX.
function POPUP_valueX_Callback(hObject, eventdata, handles)
% hObject    handle to POPUP_valueX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns POPUP_valueX contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POPUP_valueX


% --- Executes during object creation, after setting all properties.
function POPUP_valueX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POPUP_valueX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in POPUP_valueY.
function POPUP_valueY_Callback(hObject, eventdata, handles)
% hObject    handle to POPUP_valueY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns POPUP_valueY contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POPUP_valueY


% --- Executes during object creation, after setting all properties.
function POPUP_valueY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POPUP_valueY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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




% --- Executes on button press in BUT_plot_rectangles.
function BUT_plot_rectangles_Callback(hObject, eventdata, handles)

global OUT
% hObject    handle to BUT_plot_rectangles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x = handles.POPUP_valueX.Value ;
y = handles.POPUP_valueY.Value ;

cla %clear axes

plot_rectangles(OUT, x, y)

set(handles.GRAPH_graph1, 'Visible', 'On')
set(handles.PANEL_Plot_robustness, 'Visible', 'On')


disp('Plot rectangles')
disp('-------------------------------------------------------------------------------------')


% --- Executes on button press in BUT_robustness.
function BUT_robustness_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_robustness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global OUT

% recover x and y you wnat to plot
x = handles.POPUP_valueX.Value ;
y = handles.POPUP_valueY.Value ;

% call of the function to plot the x and y selected 
% to have more detail tape 'help(interactive_graph)'
column = handles.POPUP_rectangle.Value ; 
interactive_graph(OUT, x, y, column)
disp('Open interactive graph ')
disp('Use left click on the points to get their robustness value and their position')
disp('Use right click to delete all the texts on the figure')
disp('-------------------------------------------------------------------------------------')





% --------------------------------------------------------------------
function MENU_help_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning('TO DO')


% --------------------------------------------------------------------
function MENU_license_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_license (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning('TO DO')


% --------------------------------------------------------------------
function MENU_document_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_document (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('- Open super word document of nono')



% --------------------------------------------------------------------
function MENU_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function MENU_save_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning('TO DO')


% --------------------------------------------------------------------
function MENU_load_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning('TO DO')



% --------------------------------------------------------------------
function blabla_Callback(hObject, eventdata, handles)
% hObject    handle to blabla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
