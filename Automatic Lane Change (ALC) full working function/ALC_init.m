%%
clc; close all;clear all;

% ALC init script
%% Defining velocity and time values for lane change
Vx = 10;  % Velocity in mps
Tf = 5;   % Time to complete lane change in seconds
Ts = 0.1; % Sampling time in seconds

%% Lane change path planning
path = path_planning_fcn(Vx,Tf,Ts);
xRef = path.XRef;
yRef = path.YRef;
yawRef = path.yawRef;

%% Defining the time vectors
T_lane = path.T_lane
tRef = 0:Ts:T_lane;

%%
xRef_max = max(xRef); % Maximum longitudinal displacement

%% Model parameters
m = 1140;
I_z = 1436.24; %kgm2
l_f = 1.165; 
l_r = 1.165;
c_f = 155494.663;
c_r = 1554494.663;

m = 1140;
Iz = 1436.24;
lf = 1.165;
lr = 1.165;
Cf = 155494.663;
Cr =1554494.663;

% assuming constant velocity
v_x = Vx; %mps

%% Dynamic bicycle model 
% continous A B C D matrixes
A = [0 1 Vx 0;
     0 -2*(c_f+c_r)/(m*v_x) 0 -2*(l_f*c_f + l_r*c_r)/(m*v_x) - v_x;
     0 0 0 1;
     0 2*(l_r*c_r - l_f*c_f)/(I_z*v_x)  0  -2*(l_r^2*c_r - l_f^2*c_f)/(I_z*v_x)];
 
B = [0;
    2*c_f/m;
    0;
    2*l_f*c_f/I_z];

C= [1 0 0 0;
       0 1 0 0];
D = [0;0];

%%
vehicle = ss(A,B,C,D)
%%
load('mpc1.mat')

%% Overview of simulink model
% open simulink model
mdl = 'ALC_MPC_Lateral_Control_Model';
open_system(mdl)

%% Checking for safe distance N.B: Refer to flow chart for path planning algorithm to recall
safe_d = 2; % Defined safe distance between target and host in meters

target_x = 75; % Position of target vehicle after our lane change is complete in meters

if (target_x - xRef_max) > safe_d
    % run model
    out = sim(mdl);
    disp('Lane change performed')
else
    disp('Lane change not available')
end





