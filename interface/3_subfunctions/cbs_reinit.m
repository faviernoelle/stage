%% Breach Interface Object Creation

global PARAM

model_name = 'AbstractFuelControl_M1NFM';
load('AbstractFuelControl_M1.mat')
fprintf('\n Creating breach interface with simulink model %s\n',model_name)

% simTime = 50 ; 
fprintf('\n Simulation time horizon is %d seconds\n',PARAM.simTime)

% fprintf('\n Press any key to continue')
% pause

BrSys = CoverageBreachSet(model_name,{});
BrSys.SetTime([0 PARAM.simTime]);


%% Set input signals

fprintf('\n Parametrizing input signal Pedal Angle as piecewise constant....\n')
Input_Gen.type = 'UniStep';

% N = 10; % Number of control points
Input_Gen.cp = PARAM.Nb_point;
BrSys.SetInputGen(Input_Gen);
fprintf('Number of control points is %d\n',PARAM.Nb_point)

% fprintf('\n Press any key to continue\n')
% pause

%% Specifying parameter names
for i=0:PARAM.Nb_point-1
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
Sys.SetParamRanges(signal_u0,ones(PARAM.Nb_point,1)*[0 PARAM.max_pedal_angle]);
Sys.SetParam(signal_u1,ones(PARAM.Nb_point,1)*PARAM.engine_speed);
Sys.SetParam(signal_u2,ones(PARAM.Nb_point,1)*PARAM.Sensor_Offset);
Sys.SetEpsGridsize(PARAM.Grid_discretisation*ones(PARAM.Nb_point,1));
Sys.SetDeltaGridsize(2*Sys.epsgridsize);

global CBS 
CBS = Sys.copy();

% fprintf('\n Press any key to continue\n ')
% pause