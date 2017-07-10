function varargout = GUI_plot_signal(varargin)
% GUI_PLOT_SIGNAL MATLAB code for GUI_plot_signal.fig
%      GUI_PLOT_SIGNAL, by itself, creates a new GUI_PLOT_SIGNAL or raises the existing
%      singleton*.
%
%      H = GUI_PLOT_SIGNAL returns the handle to a new GUI_PLOT_SIGNAL or the handle to
%      the existing singleton*.
%
%      GUI_PLOT_SIGNAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PLOT_SIGNAL.M with the given input arguments.
%
%      GUI_PLOT_SIGNAL('Property','Value',...) creates a new GUI_PLOT_SIGNAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_plot_signal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_plot_signal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_plot_signal

% Last Modified by GUIDE v2.5 28-Jun-2017 16:57:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_plot_signal_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_plot_signal_OutputFcn, ...
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


% --- Executes just before GUI_plot_signal is made visible.
function GUI_plot_signal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_plot_signal (see VARARGIN)


% Global variable to plot
global CONSIGNE X_PLOT 

% Global variable to know the parameters of the signal
global VALEURS LINE COLUMN
% Global variable to know if the click was a right point not on a point or
% a left click on a point
% global POINT_SELECTED


% Graph : signal = consigne
axes(handles.GRAPH_signal)
stairs(X_PLOT, CONSIGNE)
axis([1 length(CONSIGNE(1,:)) 0 40])

[~, ~, value] = get_min_rob(VALEURS) ;

set(handles.TXT_robu_value,'String',num2str(value))
% set(handles.TXT_robu_value,'String',num2str(VALUES.clusters{COLUMN}.vals(LINE)))

% if POINT_SELECTED == 1
%     % the click was a left click on a point
%     set(handles.TXT_robu_value,'String',num2str(VALUES.clusters{COLUMN}.vals(LINE)))
% else 
%     % the point was a right click not on a point
%     set(handles.TXT_robu_value,'String',num2str(VALUES.clusters{COLUMN}.vals(LINE)))
% end



% Choose default command line output for GUI_plot_signal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);




% UIWAIT makes GUI_plot_signal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_plot_signal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BUT_test.
function BUT_test_Callback(hObject, eventdata, handles)
% hObject    handle to BUT_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('button pushed')
