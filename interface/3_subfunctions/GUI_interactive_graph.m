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

% Last Modified by GUIDE v2.5 26-Jul-2017 18:28:03

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

global first_simu
first_simu = 1 ;
global start n
start = 1 ;
n = 0 ;
global W_ROB MIN_SAMPLE MAX_SIMU MAX_TIME 
W_ROB = 0.5 ; 
MIN_SAMPLE = 10 ; 
MAX_SIMU = 200 ; 
MAX_TIME = 2000 ;
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

global DATA PARAM COVERAGE
 
[PARAM(:).tab_dim] = zeros(PARAM.Nb_point,3) ;
PARAM.tab_dim(:,3) = PARAM.max_pedal_angle ; 
PARAM.tab_dim(:,1) = 1:PARAM.Nb_point ;

% Adding images
disp('- Adding images')
axes(handles.GRAPH_Verimag);
imshow('verimag.PNG')
axes(handles.GRAPH_Toyota);
imshow('toyota.PNG')

% Initializing every panels 

disp('- Clear rectangle graph')
cla(handles.GRAPH_graph1) % clear graph on the right

set(handles.TXT_rect_selected,'Visible','Off')

if ~isempty(DATA)
    set_param(hObject,eventdata,handles)
end 


% Set properties of the graph on the left
disp('- Set properties of the graph on the left')
% set(handles.GRAPH_graph1,'ButtonDownFcn',{@MouseClicking handles});
% set(handles.GRAPH_graph1,'ButtonDownFcn',{@Test handles});
set(hObject,'WindowButtonDownFcn',{@MouseClicking handles})

disp('End initialization')

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


function CellEditCallback(hObject, eventdata, handles)
% disp('changes on the table')

global PARAM DATA

axes(handles.GRAPH_graph1)
cla %clear axe on the right

data = handles.select_dim_and_limits.Data ;

test_x = zeros(10,1) ;
for i= 1:PARAM.Nb_point
    test_x(i) = data{i,2} ;
end

x = find(test_x == 1) ;
y = find(test_x == 2) ;

for i=1:PARAM.Nb_point 
    PARAM.tab_dim(i,2) = handles.select_dim_and_limits.Data{i,5} ;
    PARAM.tab_dim(i,3) = handles.select_dim_and_limits.Data{i,6} ;
end

axes(handles.GRAPH_graph1)
plot_new_rectangles(DATA.exp, x, y, 1, PARAM) 


function CellSelectionCallback(hObject, eventdata, handles)
% disp('column selected')

axes(handles.GRAPH_graph1)
cla % clear axe on the right

global PARAM DATA

data1 = handles.select_rect_to_plot.Data ;
data2 = handles.select_dim_and_limits.Data ;

test_x = zeros(10,1) ;
for i= 1:PARAM.Nb_point
    test_x(i) = data2{i,2} ;
end

x = find(test_x == 1) ;
y = find(test_x == 2) ;


Cellule = eventdata.Indices;
if isempty(Cellule)
    Cellule= [1 1] ;
end
rectangle_to_plot = data1(Cellule(1), 1) ;

disp(['rectangle sélectionné : ', num2str(rectangle_to_plot)])

set(handles.TXT_rect_selected,'String',rectangle_to_plot) ;

plot_new_rectangles(DATA.exp, x, y, rectangle_to_plot, PARAM)


function MouseClicking(~, eventdata, handles)

% function which act when the click is used :
% When we do a left click in every case disp (left click) and
    % if it's on a point -> plot robustness value
    % if it's not on a point -> do nothing
% left click clear texts on the figure
    
global DATA PARAM


data2 = handles.select_dim_and_limits.Data ;

test_x = zeros(10,1) ;
for i= 1:PARAM.Nb_point
    test_x(i) = data2{i,2} ;
end

x = find(test_x == 1) ;
y = find(test_x == 2) ;


rectangle_to_plot = str2double(get(handles.TXT_rect_selected,'String')) ;

% Left click
if strcmpi(get(gcf,'SelectionType'), 'Normal')

% set value epsilon such that if the mouse is to far away from the point do
% nothing 
    epsilon = 0.5 ;
    [PARAM(:).epsilon] = epsilon ;
    
    actual_fewest_dist = 1 ;
    
    line = 0 ;
   
    pointeur_x = handles.GRAPH_graph1.CurrentPoint(1,1) ;
    pointeur_y = handles.GRAPH_graph1.CurrentPoint(1,2) ;
    
    % for every point test the distance between the value X of the point
    % and the value X of the mouse and the same for Y and if both values
    % are smaller than epsilon write on the graph the robustness value of
    % the point
    for l=1:length(DATA.exp.clusters{rectangle_to_plot}.pts)
        % test the difference between position of the point and position of
        % the mouse
        % Define a cercle of radius epsilon arround the point such that if the 
        % mouse is in this cercle the values of the point are written 
        % otherwise they are not written
        dist =  (pointeur_y - DATA.exp.clusters{rectangle_to_plot}.pts(l,y)) * ...
                (pointeur_y - DATA.exp.clusters{rectangle_to_plot}.pts(l,y)) + ...
                (pointeur_x - DATA.exp.clusters{rectangle_to_plot}.pts(l,x)) * ...
                (pointeur_x - DATA.exp.clusters{rectangle_to_plot}.pts(l,x)) ;
        
        
        if sqrt(dist) < PARAM.epsilon
             
            if dist < actual_fewest_dist
                actual_fewest_dist = dist ; 
                line = l ; 
            end
            
            
            % Part of the code to get the parameters to put the texts at the right position
            min = DATA.exp.regions{rectangle_to_plot}(y,1);
            max = DATA.exp.regions{rectangle_to_plot}(y,2);
            
            affich_text_robu = 3/40 ; % parameter calculed to optimize visualization
            [PARAM(:).affich_text_robu] = affich_text_robu ;
            delta = (max-min)*(PARAM.affich_text_robu) ;

        else
            % Do nothing
        end
    end
    
    if line ~= 0
        % Write robustness value on the graph, the first two values are
        % used to define the position where the text will be written
        % Writte robustness
        text(DATA.exp.clusters{rectangle_to_plot}.pts(line,x),...
            DATA.exp.clusters{rectangle_to_plot}.pts(line,y), ...
        num2str(DATA.exp.clusters{rectangle_to_plot}.vals(line)))
        % Writte position /x
        text(DATA.exp.clusters{rectangle_to_plot}.pts(line,x),...
            DATA.exp.clusters{rectangle_to_plot}.pts(line,y)-delta, ...
            ['x = ' num2str(DATA.exp.clusters{rectangle_to_plot}.pts(line,x))]); 
        % Writte position /y
        text(DATA.exp.clusters{rectangle_to_plot}.pts(line,x),...
            DATA.exp.clusters{rectangle_to_plot}.pts(line,y)-2*delta, ...    
            ['y = ' num2str(DATA.exp.clusters{rectangle_to_plot}.pts(line,y))]);
    else 
        % Do nothing
    end
    
% Right click
elseif strcmpi(get(gcf,'SelectionType'), 'Alt')
    allText = findobj(gca,'Type','Text') ;
    delete(allText)
end


% --- Executes on button press in BUT_plot_signal.
function BUT_plot_signal_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_plot_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global PARAM DATA 

data2 = handles.select_dim_and_limits.Data ;

test_x = zeros(10,1) ;
for i= 1:PARAM.Nb_point
 test_x(i) = data2{i,2} ;
end

x = find(test_x == 1) ;
y = find(test_x == 2) ;

rectangle_to_plot = str2double(get(handles.TXT_rect_selected,'String')) ;

plot_signal(DATA.exp,x,y,rectangle_to_plot, PARAM)


% --------------------------------------------------------------------
function MENU_help_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
function MENU_open_Callback(hObject, ~, handles)
% hObject    handle to MENU_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, Pathname] = uigetfile ;
addpath(Pathname)
open(filename)
set_param 


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


% --- Executes on button press in BUT_start_simu.
function BUT_start_simu_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_start_simu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.BUT_stop_simu,'Visible','On')
set(handles.BUT_start_simu,'Visible','Off')

global first_simu Out DATA start COVERAGE n PARAM

global r CBS phi

global W_ROB MIN_SAMPLE MAX_SIMU MAX_TIME 

w_rob = W_ROB ;
init_sim = MIN_SAMPLE ;
max_sim = MAX_SIMU ;
time_lim = MAX_TIME ; 

coverage = COVERAGE ;

if first_simu ~= 1
    cbs_reinit     
else 
    Out = [] ;
    COVERAGE = [] ;

    first_simu = 0 ;
end

% Lancer simulation
disp('Lancer simu')

rng(r,'twister');  
timervar_1 = tic;


start = 1 ;

while n <= max_sim  && start == 1 
    nb_before_calc_coverage = 20 ; 
    Out = StatFalsify(Out, CBS, phi, w_rob, init_sim, ...
        nb_before_calc_coverage, time_lim) ;
    coverage = [coverage ; compute_global_coverage(Out, PARAM) ] ;
    COVERAGE = coverage ;
    n = Out.num_samples(1,1) ;
end

set(handles.BUT_start_simu,'Visible','On')

DATA = struct('exp', Out) ;

r = DATA.exp.num_samples(1) ;

set_param(hObject,eventdata,handles)

time_1 = toc(timervar_1);  
fname = ['cl',num2str(r)];
save(fname, 'Out')



% --- Executes on button press in BUT_stop_simu.
function BUT_stop_simu_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_stop_simu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global start;
start = 0 ;

function set_param(hObject, eventdata, handles)

global DATA PARAM 

disp('- Plot the rectangle containing the point with the lowest robustness')
    % Get rectangle containing the point of minimal robustness
    [rank_rob, ~, rob] = sort_robustness(DATA.exp) ;
    [cov, rank_cov] = sort(DATA.exp.coverage) ;

    disp('- plot global coverage and show its value ')
    % Compute global coverage value (call function compute_global_coverage)
    % See help compute_global_coverage to get more details
    coverage = compute_global_coverage(DATA.exp, PARAM) ;
    set(handles.TXT_global_coverage,'String',coverage)

    % Column names and column format
    columnname1 = {'Rectangle','Robustness rank','Coverage rank'} ;
    columnformat1 = {'numeric','numeric','numeric'} ;

    % Column names and column format
    columnname2 = {'Dimension','Plot axis','Rect lower bound',...
        'Rect uppur bound', 'Plot lower Bound', 'Plot upper bound'} ;
    columnformat2 = {'numeric','numeric','numeric','numeric','numeric','numeric'} ;

    % Define the data of the first table
    d = (1:PARAM.Nb_point)' ;
    for i=1:PARAM.Nb_point
        data2(i,:) = {d(i) 0 0 PARAM.max_pedal_angle PARAM.tab_dim(i,2) PARAM.tab_dim(i,3)} ;   
    end

    d1 = 1:numel(DATA.exp.regions) ;
    for i = 1:numel(DATA.exp.regions)
        data1(i,:) = {d1(i) rank_rob(i) rank_cov(i)} ;
    end

    for j=1:3
        for i=1:numel(DATA.exp.regions)
            data_table(i,j) = data1{i,j} ;
        end
    end

    data2{1,2} = 1 ;
    data2{2,2} = 2 ;

    % define the data of the second table

    set(handles.select_dim_and_limits, 'ColumnName', columnname2)
    set(handles.select_dim_and_limits, 'ColumnFormat', columnformat2)
    set(handles.select_dim_and_limits, 'Data', data2)
    set(handles.select_dim_and_limits, 'ColumnEditable',...
        [false true false false true true] )
    set(handles.select_dim_and_limits, 'CellEditCallback', ...
        {@CellEditCallback handles})

    set(handles.select_rect_to_plot, 'ColumnName', columnname1)
    set(handles.select_rect_to_plot, 'ColumnFormat', columnformat1)
    set(handles.select_rect_to_plot, 'Data', data_table)
    set(handles.select_rect_to_plot, 'ColumnEditable',...
        [false false false] )
    set(handles.select_rect_to_plot, 'CellSelectionCallback', ...
        {@CellSelectionCallback handles})

    test_x = zeros(10,1) ;
    for i= 1:PARAM.Nb_point
        test_x(i) = data2{i,2} ;
    end
    % test_y(:) = data{:,2} ;

    x = find(test_x == 1) ;
    y = find(test_x == 2) ;

    axes(handles.GRAPH_graph1)
    plot_new_rectangles(DATA.exp, x, y, 1, PARAM) 

    disp('- Hide static text for rectangle selected')
    set(handles.TXT_rect_selected,'String',1) 
    
    % a faire : 
    % Tracer la couverture


% --------------------------------------------------------------------
function MENU_Prop_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_Prop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection_param
if ~isempty(DATA)
    set_param (hObject, eventdata, handles)
end


% --------------------------------------------------------------------
function MENU_new_sim_Callback(hObject, eventdata, handles)
% hObject    handle to MENU_new_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
