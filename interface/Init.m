
addPath

bdclose all
close all
% clear vars
InitBreach



%% Breach Interface Object Creation

global PARAM

model_name = 'AbstractFuelControl_M1NFM';
load('AbstractFuelControl_M1.mat')
fprintf('\n Creating breach interface with simulink model %s\n',model_name)

simTime = 50 ; 
fprintf('\n Simulation time horizon is %d seconds\n',simTime)

PARAM = struct('simTime', simTime) ;

% fprintf('\n Press any key to continue')
% pause

BrSys = CoverageBreachSet(model_name,{});
BrSys.SetTime([0 simTime]);


%% Set input signals

fprintf('\n Parametrizing input signal Pedal Angle as piecewise constant....\n')
Input_Gen.type = 'UniStep';

N = 10 ; % Number of control points
Input_Gen.cp = N;

[PARAM(:).Nb_point] = N ;

BrSys.SetInputGen(Input_Gen);
fprintf('Number of control points is %d\n',N)

% fprintf('\n Press any key to continue\n')
% pause

%% Specifying parameter names
for i=0:N-1
    signal_u0{1,i+1}=strcat('Pedal_Angle_u',num2str(i));
    signal_u1{1,i+1}=strcat('Engine_Speed__rpm__u',num2str(i));
    signal_u2{1,i+1}=strcat('AF_Sensor_Offset_u',num2str(i));
end

%% Initializing CBS object parameters

% Input ranges

fprintf('\n Range of Pedal Angle is [0, 40]\n')
fprintf('Engine Speed is constant at 1000\n')
fprintf('AF-Sensor Offset is constant at 1')
fprintf('\n Grid discretization unit for Pedal Angle signal value range is 4 units\n')

Sys = BrSys.copy;
Sys.SetParamRanges(signal_u0,ones(N,1)*[0 40]);
Sys.SetParam(signal_u1,ones(N,1)*1000);
Sys.SetParam(signal_u2,ones(N,1)*1);
Sys.SetEpsGridsize(4*ones(N,1));
Sys.SetDeltaGridsize(2*Sys.epsgridsize);

[PARAM(:).max_pedal_angle] = 40 ;
[PARAM(:).engine_speed] = 1000 ;
[PARAM(:).Sensor_Offset] = 1 ;
[PARAM(:).Grid_discretisation] = 4*ones(N,1) ; 

global CBS 
CBS = Sys.copy();


% fprintf('\n Press any key to continue\n ')
% pause


%% Specifying STL formula

formulas = STL_ReadFile('prop1.stl');
global phi 
phi = phi26;

fprintf('\n The STL formula is\n ')
disp(phi)

% fprintf('\n Press any key to continue\n')
% pause

