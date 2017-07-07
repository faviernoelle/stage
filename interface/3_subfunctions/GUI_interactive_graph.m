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

% Last Modified by GUIDE v2.5 06-Jul-2017 10:35:14

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


cla(handles.GRAPH_graph1) 

% Informing the user
disp('-------------------------------------------------------------------------------------')
disp(' Welcome ! ')
disp('-------------------------------------------------------------------------------------')
disp('Initialization : ')
disp('- Adding to path all subfolders of the project')
addPath % Adding to path all subfolders of the project

% Set properties of objects
disp('- Set properties of objects')

global DATA

% Getting the name of the differents data to post
name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.POPUP_Name_data.Value} ;

% Set Structure name
set(handles.POPUP_Name_data, 'String', name_fields)

% Adding images
disp('- Adding images')
axes(handles.GRAPH_Verimag);
imshow('verimag.PNG')
axes(handles.GRAPH_Toyota);
imshow('toyota.PNG')

% Initializing every panels 

disp('- Clear rectangle graph')
cla(handles.GRAPH_graph1) % clear graph on the right


disp('- Plot the rectangle containing the point with the lowest robustness')
% Get rectangle containing the point of minimal robustness
region = get_min_rob(DATA.(valeurs)) ;
% Select the rectangle containing the point with the lowest robustness
set(handles.POPUP_rectangle, 'Value', region)
column = handles.POPUP_rectangle.Value ;

disp('- plot global coverage and show its value ')
% Compute global coverage value (call function compute_global_coverage)
% See help compute_global_coverage to get more details
coverage = compute_global_coverage(DATA.(valeurs)) ;
% Disp value of coverage in the panel 
set(handles.TXT_global_coverage, 'String', coverage)

disp('- Set parameter of panel "choose signal parameters"')
% Set the number of projection dimension possible 
set(handles.SLID_Pi, 'Min', 1) ;
set(handles.SLID_Pi, 'Max', numel(DATA.(valeurs).clusters{1}.pts(1,:))) ;
set(handles.SLID_Pj, 'Min', 1) ;
set(handles.SLID_Pj, 'Max', numel(DATA.(valeurs).clusters{1}.pts(1,:))) ;
% Set value of x to 1
set(handles.SLID_Pi, 'Value', 1) ;
% Set the value of y on 2 to be able to plot things without changing
% anything
set(handles.SLID_Pj, 'Value', 2) ;
% Get x(Pi) and y(Pj) values
x = floor(handles.SLID_Pi.Value) ;
y = floor(handles.SLID_Pj.Value) ;
% Writte on the text box under the slider the min, max and current values 
% of the slider for Pi value
set(handles.TXT_Pi_min,   'String', num2str(1)) ;
set(handles.TXT_Pi_max,   'String', num2str(numel(DATA.(valeurs).clusters{1}.pts(1,:)))) ;
set(handles.TXT_Pi_value, 'String', num2str(handles.SLID_Pi.Value(1))) ;
% Writte on the text box under the slider the min, max and current values 
% of the slider for Pj value
set(handles.TXT_Pj_min,   'String', num2str(1)) ;
set(handles.TXT_Pj_max,   'String', num2str(numel(DATA.(valeurs).clusters{1}.pts(1,:)))) ;
set(handles.TXT_Pj_value, 'String', num2str(handles.SLID_Pj.Value(1))) ;
% Select data to set intervale of the sliders
sliderMin = get(handles.SLID_Pi, 'Min') ;
sliderMax = get(handles.SLID_Pi, 'Max') ;
SliderStep = [1 1] / (sliderMax - sliderMin) ;
% Set interval of the slider for Pi and for Pj
% Each time the user presses an arrow key or clicks in the troug the value
% of the slidbar is increased of 1
set(handles.SLID_Pi, 'SliderStep', SliderStep)  ;
set(handles.SLID_Pj, 'SliderStep', SliderStep)  ;

disp('- Set parameter in panel "Plot rectangles" ')
% Set the popup menu with the number of rectangles
set(handles.POPUP_rectangle, 'String', num2str((1:1:numel(DATA.(valeurs).regions))'));
% Write the size of selected rectangle in the panel 'choose rectangle to
% plot'
set(handles.TXT_size_rect_x, 'String',...
    ['Size/x = ' num2str(DATA.(valeurs).regions{column}(x,:))])
set(handles.TXT_size_rect_y, 'String',...
    ['Size/y = ' num2str(DATA.(valeurs).regions{column}(y,:))])
set(handles.TXT_coverage, 'String',...
    ['local coverage = ' num2str(DATA.(valeurs).coverage(column))])
axes(handles.GRAPH_graph1)
plot_rectangles(DATA.(valeurs), x, y, column)

disp('- Set parameter in panel "add limits on projection dimensions" ')
% Set parameter in panel 'add limits on projection dimensions'
set(handles.POPUP_dim, 'String', num2str((1:numel(DATA.(valeurs).clusters{column}.pts(1,:)))'))

disp('- Reset the limits on dimensions')
% Reset the limits on dimensions
set(handles.LIST_dim, 'String', [])
global TAB_DIM
TAB_DIM = zeros(10,3) ;
TAB_DIM(:,3) = 40 ; 
TAB_DIM(:,1) = 1:length(handles.POPUP_dim.String) ;

disp('End initialization')
disp('-------------------------------------------------------------------------------------')

set(handles.POPUP_rectangle,'Value',1);


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



% --- Executes on selection change in POPUP_Name_data.
function POPUP_Name_data_Callback(hObject, eventdata, handles)
% hObject    handle to POPUP_Name_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns POPUP_Name_data contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POPUP_Name_data
% Set parameter of every panels
global DATA
name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.POPUP_Name_data.Value} ;
disp('-------------------------------------------------------------------------------------')
disp('Data loaded')
disp('-------------------------------------------------------------------------------------')

% Set the popup menu with the number of rectangles
set(handles.POPUP_rectangle, 'String', num2str((1:1:numel(DATA.(valeurs).regions))'));

disp('Clear rectangle graph')
cla(handles.GRAPH_graph1) % clear graph on the right

disp('Plot the rectangle containing the point with the lowest robustness')
% Get rectangle containing the point of minimal robustness
region = get_min_rob(DATA.(valeurs)) ;
% Select the rectangle containing the point with the lowest robustness
set(handles.POPUP_rectangle, 'Value', region)
column = handles.POPUP_rectangle.Value ;

disp('plot global coverage and show its value ')
% Compute global coverage value (call function compute_global_coverage)
% See help compute_global_coverage to get more details
coverage = compute_global_coverage(DATA.(valeurs)) ;
% Disp value of coverage in the panel 
set(handles.TXT_global_coverage, 'String', coverage)

disp('Set parameter of panel "choose signal parameters"')
% Set the number of projection dimension possible 
set(handles.SLID_Pi, 'Min', 1) ;
set(handles.SLID_Pi, 'Max', numel(DATA.(valeurs).clusters{1}.pts(1,:))) ;
set(handles.SLID_Pj, 'Min', 1) ;
set(handles.SLID_Pj, 'Max', numel(DATA.(valeurs).clusters{1}.pts(1,:))) ;
% Set value of x to 1
set(handles.SLID_Pi, 'Value', 1) ;
% Set the value of y on 2 to be able to plot things without changing
% anything
set(handles.SLID_Pj, 'Value', 2) ;
% Get x(Pi) and y(Pj) values
x = floor(handles.SLID_Pi.Value) ;
y = floor(handles.SLID_Pj.Value) ;
% Writte on the text box under the slider the min, max and current values 
% of the slider for Pi value
set(handles.TXT_Pi_min,   'String', num2str(1)) ;
set(handles.TXT_Pi_max,   'String', num2str(numel(DATA.(valeurs).clusters{1}.pts(1,:)))) ;
set(handles.TXT_Pi_value, 'String', num2str(handles.SLID_Pi.Value(1))) ;
% Writte on the text box under the slider the min, max and current values 
% of the slider for Pj value
set(handles.TXT_Pj_min,   'String', num2str(1)) ;
set(handles.TXT_Pj_max,   'String', num2str(numel(DATA.(valeurs).clusters{1}.pts(1,:)))) ;
set(handles.TXT_Pj_value, 'String', num2str(handles.SLID_Pj.Value(1))) ;
% Select data to set intervale of the sliders
sliderMin = get(handles.SLID_Pi, 'Min') ;
sliderMax = get(handles.SLID_Pi, 'Max') ;
SliderStep = [1 1] / (sliderMax - sliderMin) ;
% Set interval of the slider for Pi and for Pj
% Each time the user presses an arrow key or clicks in the troug the value
% of the slidbar is increased of 1
set(handles.SLID_Pi, 'SliderStep', SliderStep)  ;
set(handles.SLID_Pj, 'SliderStep', SliderStep)  ;

disp('Set parameter in panel "Plot rectangles" ')
% Write the size of selected rectangle in the panel 'choose rectangle to
% plot'
set(handles.TXT_size_rect_x, 'String',...
    ['Size/x = ' num2str(DATA.(valeurs).regions{column}(x,:))])
set(handles.TXT_size_rect_y, 'String',...
    ['Size/y = ' num2str(DATA.(valeurs).regions{column}(y,:))])
set(handles.TXT_coverage, 'String',...
    ['local coverage = ' num2str(DATA.(valeurs).coverage(column))])
axes(handles.GRAPH_graph1)
plot_rectangles(DATA.(valeurs), x, y, column)

disp('Set parameter in panel "add limits on projection dimensions" ')
% Set parameter in panel 'add limits on projection dimensions'
set(handles.POPUP_dim, 'String', num2str((1:numel(DATA.(valeurs).clusters{column}.pts(1,:)))'))

disp('Reset the limits on dimensions')
% Reset the limits on dimensions
set(handles.LIST_dim, 'String', [])
global TAB_DIM
TAB_DIM = zeros(10,3) ;
TAB_DIM(:,3) = 40 ; 
TAB_DIM(:,1) = 1:length(handles.POPUP_dim.String) ;


% --- Executes during object creation, after setting all properties.
function POPUP_Name_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POPUP_Name_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BUT_load_data.
function BUT_load_data_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function SLID_Pi_Callback(hObject, eventdata, handles)
% hObject    handle to SLID_Pi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% modify the textbox showing the value of the slider
set(handles.TXT_Pi_value, 'String', num2str(floor(handles.SLID_Pi.Value(1)))) ;


% --- Executes during object creation, after setting all properties.
function SLID_Pi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLID_Pi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function SLID_Pj_Callback(hObject, eventdata, handles)
% hObject    handle to SLID_Pj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% modify the textbox showing the value of the slider
set(handles.TXT_Pj_value, 'String', num2str(floor(handles.SLID_Pj.Value(1)))) ;


% --- Executes during object creation, after setting all properties.
function SLID_Pj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLID_Pj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in BUT_plot_rectangles.
function BUT_plot_rectangles_Callback(hObject, eventdata, handles)

global DATA TAB_DIM

% hObject    handle to BUT_plot_rectangles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x = floor(handles.SLID_Pi.Value) ;
y = floor(handles.SLID_Pj.Value) ;

% Get the name of the fields contained in DATA
name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.POPUP_Name_data.Value} ;

% Get rectangle containing the point of minimal robustness
region = get_min_rob(DATA.(valeurs)) ;

% Select the rectangle containing the point with the lowest robustness
set(handles.POPUP_rectangle, 'Value', region)

% get the value of the pop_up to choose the rectangle
column = handles.POPUP_rectangle.Value ; 
 
cla(handles.GRAPH_graph1)  %clear axes

% Write the size of selected rectangle in the panel 'choose rectangle to
% plot'
set(handles.TXT_size_rect_x, 'String',...
    ['Size/x = ' num2str(DATA.(valeurs).regions{column}(x,:))])
set(handles.TXT_size_rect_y, 'String',...
    ['Size/y = ' num2str(DATA.(valeurs).regions{column}(y,:))])
set(handles.TXT_coverage, 'String',...
    ['local coverage = ' num2str(DATA.(valeurs).coverage(column))])

% Plot in the graph on the left the rectangles in projection dimension
% selected and color each point according to the value of its robustness
% To have more details tape 'help plot_rectangles_and_colore_selected_one'
axes(handles.GRAPH_graph1)
plot_new_rectangles(DATA.(valeurs), x, y, column, TAB_DIM)

disp('Plot rectangles')
disp('-------------------------------------------------------------------------------------')


% --- Executes on selection change in POPUP_rectangle.
function POPUP_rectangle_Callback(hObject, eventdata, handles)
% hObject    handle to POPUP_rectangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns POPUP_rectangle contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POPUP_rectangle

cla(handles.GRAPH_graph1)  % clear axes

global DATA TAB_DIM

% recover x and y you wnat to plot
x = floor(handles.SLID_Pi.Value) ;
y = floor(handles.SLID_Pj.Value) ;

% Recover the zone you want to plot
column = handles.POPUP_rectangle.Value ; 

name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.POPUP_Name_data.Value} ;

% Write the size of selected rectangle and its coverage value in the panel 
% choose rectangle to plot
set(handles.TXT_size_rect_x, 'String',...
    ['Size/x = ' num2str(DATA.(valeurs).regions{column}(x,:))])
set(handles.TXT_size_rect_y, 'String',...
    ['Size/y = ' num2str(DATA.(valeurs).regions{column}(y,:))])
set(handles.TXT_coverage, 'String',...
    ['local coverage = ' num2str(DATA.(valeurs).coverage(column))])

% Plot rectangle in the graph on the right and color the border of the
% selected one and the points inside it
plot_new_rectangles(DATA.(valeurs), x, y, column, TAB_DIM)
disp(TAB_DIM)


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



% --- Executes on button press in BUT_robustness.
function BUT_robustness_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_robustness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DATA

% recover x and y you wnat to plot
x = floor(handles.SLID_Pi.Value) ;
y = floor(handles.SLID_Pj.Value) ;

% Recover the zone you want to plot
column = handles.POPUP_rectangle.Value ; 

% Get the name of the fields contained in DATA
name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.POPUP_Name_data.Value} ;

% call of the function to plot the x and y selected 
% to have more detail tape 'help plot_robustness'
plot_robustness(DATA.(valeurs), x, y, column)

disp('Open new graph ')
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
x = floor(handles.SLID_Pi.Value) ;
y = floor(handles.SLID_Pj.Value) ;

% Recover the zone you want to plot
column = handles.POPUP_rectangle.Value ; 

% Get the name of the fields contained in DATA
name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.POPUP_Name_data.Value} ;

disp('Plot signal')
plot_signal(DATA.(valeurs), x, y, column)

disp('Open new graph ')
disp('Use left click on the points to plot their signal')
disp('Use right click not on a point to plot a new signal')
disp('-------------------------------------------------------------------------------------')


% --- Executes on selection change in POPUP_dim.
function POPUP_dim_Callback(hObject, eventdata, handles)
% hObject    handle to POPUP_dim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns POPUP_dim contents as cell array
%        contents{get(hObject,'Value')} returns selected item from POPUP_dim
set(handles.EDIT_min_range,'String',0)
set(handles.EDIT_max_range,'String',40)


% --- Executes during object creation, after setting all properties.
function POPUP_dim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to POPUP_dim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function EDIT_min_range_Callback(hObject, eventdata, handles)
% hObject    handle to EDIT_min_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EDIT_min_range as text
%        str2double(get(hObject,'String')) returns contents of EDIT_min_range as a double
% Set parameters of the table
handles.listbox2.String = get(handles.POPUP_dim,'Value') ;
% handles.listbox2.UserData(1,2) = num2str(handles.EDIT_min_range.Value) ;
% handles.listbox2.UserData(1,3) = num2str(handles.EDIT_max_range.Value) ;


% --- Executes during object creation, after setting all properties.
function EDIT_min_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDIT_min_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EDIT_max_range_Callback(hObject, eventdata, handles)
% hObject    handle to EDIT_max_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EDIT_max_range as text
%        str2double(get(hObject,'String')) returns contents of EDIT_max_range as a double


% --- Executes during object creation, after setting all properties.
function EDIT_max_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDIT_max_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BUT_new_rect.
function BUT_new_rect_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_new_rect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.GRAPH_graph1)
cla % clear axe

global TAB_DIM DATA

% recover x and y and the rectangle you wnat to plot
x = floor(handles.SLID_Pi.Value) ;
y = floor(handles.SLID_Pj.Value) ;
column = handles.POPUP_rectangle.Value ;

% Get the name of the fields contained in DATA
name_fields = fieldnames(DATA) ;
valeurs = name_fields{handles.POPUP_Name_data.Value} ;

plot_new_rectangles(DATA.(valeurs),x, y,column, TAB_DIM)
disp('Plot limited rectangles')


% --- Executes on button press in BUT_limit.
function BUT_limit_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

val = handles.POPUP_dim.Value ;
a = num2str(val) ;

old_str = get(handles.LIST_dim, 'String') ;

N = length(old_str) ;

for i=1:N
    if a == old_str(i)
        old_str(i) = [] ;
        break
    end
end

str_part = a ;

new_str = strvcat(old_str, str_part) ;
set(handles.LIST_dim, 'String', new_str)

global TAB_DIM

TAB_DIM(val,2) = str2double(handles.EDIT_min_range.String) ;
TAB_DIM(val,3) = str2double(handles.EDIT_max_range.String) ;

disp('Affichage des limites')
disp(TAB_DIM)

handles.TXT_min_range.String{1} = handles.EDIT_min_range.String ;
handles.TXT_max_range.String{1} = handles.EDIT_max_range.String ;
nb_elem = length(handles.LIST_dim.String) ;

set(handles.LIST_dim, 'Value', nb_elem)


% --- Executes on selection change in LIST_dim.
function LIST_dim_Callback(hObject, eventdata, handles)
% hObject    handle to LIST_dim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LIST_dim contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LIST_dim

% Get the dimension selected
current_str = get(handles.LIST_dim, 'String') ;
to_plot = str2double(current_str(handles.LIST_dim.Value)) ;

global TAB_DIM 

% write limits on dimension selected
handles.TXT_min_range.String{1} = TAB_DIM(to_plot,2) ;
handles.TXT_max_range.String{1} = TAB_DIM(to_plot,3) ;

% --- Executes during object creation, after setting all properties.
function LIST_dim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LIST_dim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BUT_reset_lim.
function BUT_reset_lim_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_reset_lim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% reset listbox
set(handles.LIST_dim, 'String', [])

% reset table containing the limits
global TAB_DIM
TAB_DIM = zeros(10,3) ;
TAB_DIM(:,3) = 40 ; 
TAB_DIM(:,1) = 1:length(handles.POPUP_dim.String) ;


% --- Executes on button press in BUT_suppr_lim.
function BUT_suppr_lim_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_suppr_lim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = handles.LIST_dim.Value ;
new_str = get(handles.LIST_dim, 'String') ;
new_str(a)=[] ;

set(handles.LIST_dim, 'String', new_str)

global TAB_DIM
TAB_DIM(a,2) = 0 ;
TAB_DIM(a,3) = 40 ;

% write on the textbox the value of the selected dimension
current_str = get(handles.LIST_dim, 'String') ;
to_plot = str2double(current_str(handles.LIST_dim.Value)) ;

handles.TXT_min_range.String{1} = TAB_DIM(to_plot,2) ;
handles.TXT_max_range.String{1} = TAB_DIM(to_plot,3) ;


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


% --------------------------------------------------------------------
function MENU_saveas_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_saveas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[Filename, Pathname] = uiputfile({'*.fig';'*.jpg';'*.png';'*.*'},'Save as'); 
bakCD = cd ; 
cd(Pathname) ;
saveas(handles.figure1,Filename)
cd(bakCD) ;
