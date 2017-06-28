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

% Last Modified by GUIDE v2.5 28-Jun-2017 11:26:14

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
cla(handles.GRAPH_graph1) 

% Informing the user
disp('-------------------------------------------------------------------------------------')
disp(' Welcome ! ')
disp('-------------------------------------------------------------------------------------')
disp('Initialization : ')
disp('- Adding to path all subfolders of the project')
addPath() % Adding to path all subfolders of the project

% Set properties of objects
disp('- Set properties of objects')

global DATA

% Getting the name of the differents data to post
name_fields = fieldnames(DATA) ;

% Set Structure name
set(handles.TXT_Name_data, 'String', name_fields)

% Hide panel
disp('- Hide panel')
set(handles.PANEL_projection_dimension, 'Visible', 'Off')
set(handles.PANEL_Plot_robustness, 'Visible', 'Off')
set(handles.GRAPH_graph1, 'Visible', 'Off')

% Adding images
disp('- Adding images')
axes(handles.GRAPH_Verimag);
imshow('verimag.PNG')
axes(handles.GRAPH_Toyota);
imshow('toyota.PNG')

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


cla(handles.GRAPH_graph1) % clear graph on the right




global DATA

name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.TXT_Name_data.Value} ;


disp('-------------------------------------------------------------------------------------')
disp('Data loaded')
disp('-------------------------------------------------------------------------------------')

set(handles.POPUP_rectangle, 'String', num2str((1:1:numel(DATA.(valeurs).regions))'));

% Set the number of projection dimension possible 
set(handles.POPUP_valueX, 'String', num2str((1:1:(numel(DATA.(valeurs).clusters{1}.pts(1,:))))')) ;
set(handles.POPUP_valueY, 'String', num2str((1:1:(numel(DATA.(valeurs).clusters{1}.pts(1,:))))')) ;

set(handles.POPUP_valueY,'Value',2)

% Make a new part of the interface visible
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

cla(handles.GRAPH_graph1)  % clear axes

global DATA

% recover x and y you wnat to plot
x = handles.POPUP_valueX.Value ;
y = handles.POPUP_valueY.Value ;

% Recover the zone you want to plot
column = handles.POPUP_rectangle.Value ; 

name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.TXT_Name_data.Value} ;

% Write the size of selected rectangle in the panel choose rectangle to
% plot
set(handles.TXT_size_rect_x, 'String',...
    ['Size/x = ' num2str(DATA.(valeurs).regions{column}(x,:))])
set(handles.TXT_size_rect_y, 'String',...
    ['Size/y = ' num2str(DATA.(valeurs).regions{column}(y,:))])

% Plot rectangle in the graph on the right and color the border of the
% selected one and the points inside it
plot_rectangles_and_colore_selected_one(DATA.(valeurs), x, y, column)

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

global DATA
% hObject    handle to BUT_plot_rectangles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x = handles.POPUP_valueX.Value ;
y = handles.POPUP_valueY.Value ;
column = handles.POPUP_rectangle.Value ; 

% Delete all texts on the graph
allText = findobj(gca,'Type','Text') ;
delete(allText)
 
cla(handles.GRAPH_graph1)  %clear axes

% Get the name of the fields contained in DATA
name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.TXT_Name_data.Value} ;

% Write the size of selected rectangle in the panel 'choose rectangle to
% plot'
set(handles.TXT_size_rect_x, 'String',...
    ['Size/x = ' num2str(DATA.(valeurs).regions{column}(x,:))])
set(handles.TXT_size_rect_y, 'String',...
    ['Size/y = ' num2str(DATA.(valeurs).regions{column}(y,:))])


% Plot in the graph on the left the rectangles in projection dimension
% selected and color each point according to the value of its robustness
% To have more details tape 'help plot_rectangles_and_colore_selected_one'
axes(handles.GRAPH_graph1)
plot_rectangles_and_colore_selected_one(DATA.(valeurs), x, y, column)

% Make a new part of the UI visible
set(handles.GRAPH_graph1, 'Visible', 'On')
set(handles.PANEL_Plot_robustness, 'Visible', 'On')


disp('Plot rectangles')
disp('-------------------------------------------------------------------------------------')


% --- Executes on button press in BUT_robustness.
function BUT_robustness_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_robustness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DATA

% recover x and y you wnat to plot
x = handles.POPUP_valueX.Value ;
y = handles.POPUP_valueY.Value ;

% Recover the zone you want to plot
column = handles.POPUP_rectangle.Value ; 

% Get the name of the fields contained in DATA
name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.TXT_Name_data.Value} ;

% call of the function to plot the x and y selected 
% to have more detail tape 'help interactive_graph'
interactive_graph(DATA.(valeurs), x, y, column)

disp('Open interactive graph ')
disp('Use left click on the points to get their robustness value and their position')
disp('Use right click to delete all the texts on the figure')
disp('-------------------------------------------------------------------------------------')


% --- Executes on button press in BUT_plot_signal.
function BUT_plot_signal_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_plot_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DATA

% recover x and y you wnat to plot
x = handles.POPUP_valueX.Value ;
y = handles.POPUP_valueY.Value ;

% Recover the zone you want to plot
column = handles.POPUP_rectangle.Value ; 

% Get the name of the fields contained in DATA
name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.TXT_Name_data.Value} ;

plot_signal(DATA.(valeurs), x, y, column)


% --- Executes on selection change in TXT_Name_data.
function TXT_Name_data_Callback(hObject, eventdata, handles)
% hObject    handle to TXT_Name_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns TXT_Name_data contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TXT_Name_data



% --- Executes during object creation, after setting all properties.
function TXT_Name_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TXT_Name_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




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
disp('- Open PDF Document to learn how to use this interface')
open 'User_guide.pdf'


% --------------------------------------------------------------------
function MENU_Menu_Callback(hObject, ~, handles)
% hObject    handle to MENU_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function MENU_open_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, Pathname] = uigetfile ;
addpath(Pathname)
open(filename)


% disp('Writte the name of the file you want to load : (for instance fig1.fig) ')
% nameFig = input('', 's') ;
% open(nameFig)
% disp('Open selected version of the interface')


% --------------------------------------------------------------------
function MENU_saveas_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_saveas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% disp('Save as')
[Filename, Pathname] = uiputfile({'*.fig';'*.jpg';'*.png';'*.*'},'Save as'); 
bakCD = cd ; 
cd(Pathname) ;
saveas(handles.figure1,Filename)
cd(bakCD) ;
