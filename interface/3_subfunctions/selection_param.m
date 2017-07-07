function varargout = selection_param(varargin)
% SELECTION_PARAM MATLAB code for selection_param.fig
%      SELECTION_PARAM, by itself, creates a new SELECTION_PARAM or raises the existing
%      singleton*.
%
%      H = SELECTION_PARAM returns the handle to a new SELECTION_PARAM or the handle to
%      the existing singleton*.
%
%      SELECTION_PARAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECTION_PARAM.M with the given input arguments.
%
%      SELECTION_PARAM('Property','Value',...) creates a new SELECTION_PARAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before selection_param_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to selection_param_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help selection_param

% Last Modified by GUIDE v2.5 05-Jul-2017 09:42:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @selection_param_OpeningFcn, ...
                   'gui_OutputFcn',  @selection_param_OutputFcn, ...
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


% --- Executes just before selection_param is made visible.
function selection_param_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to selection_param (see VARARGIN)

% Set parameters of all sliders

% Set parameters of slider SLID_rob_wt
% Set the range for rob
set(handles.SLID_rob_wt, 'Min', 0) ;
set(handles.SLID_rob_wt, 'Max', 1) ;
% Select data to set intervale of the sliders
sliderMin_rob = get(handles.SLID_rob_wt, 'Min') ;
sliderMax_rob = get(handles.SLID_rob_wt, 'Max') ;
SliderStep_rob = [0.01 0.1] / (sliderMax_rob - sliderMin_rob) ;
% Set parameters of this slider
set(handles.SLID_rob_wt, 'SliderStep', SliderStep_rob)  ;
set(handles.SLID_rob_wt, 'Value', 0.5) ;
% Set text under this slider
set(handles.TXT_rob_min, 'String', num2str(0))
set(handles.TXT_rob_max, 'String', num2str(1))
set(handles.TXT_rob_current, 'String', get(handles.SLID_rob_wt,'Value'))


% Set parameters of slider SLID_min_sample
% Set the range for min sample
set(handles.SLID_min_sample, 'Min', 10)  ;
set(handles.SLID_min_sample, 'Max', 200) ;
% Select data to set intervale of the sliders
sliderMin_samp = get(handles.SLID_min_sample, 'Min') ;
sliderMax_samp = get(handles.SLID_min_sample, 'Max') ;
SliderStep_samp = [5 10] / (sliderMax_samp - sliderMin_samp) ;
% Set parameters of this slider
set(handles.SLID_min_sample, 'SliderStep', SliderStep_samp)  ;
set(handles.SLID_min_sample, 'Value', 10) ;
% Set text under this slider
set(handles.TXT_sample_min, 'String', num2str(10))
set(handles.TXT_sample_max, 'String', num2str(200))
set(handles.TXT_sample_current, 'String', get(handles.SLID_min_sample,'Value'))


% Set parameters of slider SLID_max_simu
% Set the range for max simu
set(handles.SLID_max_simu, 'Min', 200)  ;
set(handles.SLID_max_simu, 'Max', 2000) ;
% Select data to set intervale of the sliders
sliderMin_simu = get(handles.SLID_max_simu, 'Min') ;
sliderMax_simu = get(handles.SLID_max_simu, 'Max') ;
SliderStep_simu = [50 100] / (sliderMax_simu - sliderMin_simu) ;
% Set parameters of this slider
set(handles.SLID_max_simu, 'SliderStep', SliderStep_simu)  ;
set(handles.SLID_max_simu, 'Value', 1000) ;
% Set text under this slider
set(handles.TXT_simu_min, 'String', num2str(200))
set(handles.TXT_simu_max, 'String', num2str(2000))
set(handles.TXT_simu_current, 'String', get(handles.SLID_max_simu,'Value'))


% Set parameters of slider SLID_max_time
% Set the range for max_time
set(handles.SLID_max_time, 'Min', 200)  ;
set(handles.SLID_max_time, 'Max', 5000) ;
% Select data to set intervale of the sliders
sliderMin_time = get(handles.SLID_max_time, 'Min') ;
sliderMax_time = get(handles.SLID_max_time, 'Max') ;
SliderStep_time = [100 200] / (sliderMax_time - sliderMin_time) ;
% Set parameters of this slider
set(handles.SLID_max_time, 'SliderStep', SliderStep_time)  ;
set(handles.SLID_max_time, 'Value', 2000) ;
% Set text under this slider
set(handles.TXT_time_min, 'String', num2str(200))
set(handles.TXT_time_max, 'String', num2str(5000))
set(handles.TXT_time_current, 'String', get(handles.SLID_max_time,'Value'))

fprintf('\n Weightage to robustness information is %f\n',...
    get(handles.SLID_rob_wt,'Value'))
fprintf('\n Limit on number of simulations during global search is %d.\n',...
    get(handles.SLID_max_simu,'Value'))
fprintf('\n Threshold number of samples for classification is %d\n ',...
    get(handles.SLID_min_sample,'Value'))

global start
start = 1 ;

set(handles.BUT_start,'Visible','On')
set(handles.BUT_stop,'Visible','Off')
set(handles.BUT_visu,'Visible','Off')


% Choose default command line output for selection_param
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes selection_param wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = selection_param_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function SLID_rob_wt_Callback(hObject, eventdata, handles)
% hObject    handle to SLID_rob_wt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.TXT_rob_current, 'String', num2str(0.01 * floor(handles.SLID_rob_wt.Value * 100)))


% --- Executes during object creation, after setting all properties.
function SLID_rob_wt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLID_rob_wt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function SLID_min_sample_Callback(hObject, eventdata, handles)
% hObject    handle to SLID_min_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.TXT_sample_current, 'String', num2str(5 * floor(handles.SLID_min_sample.Value/5)))


% --- Executes during object creation, after setting all properties.
function SLID_min_sample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLID_min_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function SLID_max_simu_Callback(hObject, eventdata, handles)
% hObject    handle to SLID_max_simu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.TXT_simu_current, 'String', num2str (50 * floor(handles.SLID_max_simu.Value / 50)))


% --- Executes during object creation, after setting all properties.
function SLID_max_simu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLID_max_simu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function SLID_max_time_Callback(hObject, eventdata, handles)
% hObject    handle to SLID_max_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.TXT_time_current, 'String', num2str( 100 * floor(handles.SLID_max_time.Value/100)))


% --- Executes during object creation, after setting all properties.
function SLID_max_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLID_max_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in BUT_start.
function BUT_start_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.BUT_stop,'Visible','On')
set(handles.BUT_start,'Visible','Off')
set(handles.BUT_start, 'String', 'Continue simulation')


% global ROB_WT MIN_SAMPLE MAX_SIMU MAX_TIME 
global r CBS phi
w_rob    = 0.01 * floor(handles.SLID_rob_wt.Value     * 100) ;
init_sim = 5    * floor(handles.SLID_min_sample.Value / 5)   ;
max_sim  = 50   * floor(handles.SLID_max_simu.Value   / 50)  ; 
time_lim = 100  * floor(handles.SLID_max_time.Value   / 100) ;

global first_simu Out DATA start
if first_simu ~= 1
    cbs_reinit     
else 
 Out = [] ;
 first_simu = 0 ;   
end

% Lancer simulation
disp('Lancer simu')

% r = input('0, 5000, 10000 or 15000\n');
rng(r,'twister');  
timervar_1 = tic;



start = 1 ;

Out = StatFalsify(Out, CBS, phi, w_rob, init_sim, max_sim, time_lim);

DATA = struct('exp', Out) ; 

set(handles.BUT_visu,'Visible','On')

time_1 = toc(timervar_1);  
fname = ['cl',num2str(r)];
save(fname, 'Out')


% --- Executes on button press in BUT_stop.
function BUT_stop_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global start
start = 0 ;
set(handles.BUT_start,'Visible','On')


% --- Executes on button press in BUT_visu.
function BUT_visu_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_visu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Out DATA

DATA = struct('exp', Out) ; 

coverage_inspection
