%% initialization script for Combined control model feature.
%%
clc;
clear all; close all
%%
%% Waypoints extraction from scenerio
% scenario = course1_lancechange;
% scenario = course1_lanechange;

% scenario = course2_fig8;

% scenario = course3_city_road;
% scenario = course3_city_road_10mps;
% scenario = course3_city_road_25mps;

% scenario = lane_change_15mps;
% scenario = lane_change_25mps;

% Vx = 30;

% n = size(scenario);

% for ii =1:n(2)
%     refPose(:,ii) = [scenario(ii).ActorPoses.Position(1);scenario(ii).ActorPoses.Position(2);scenario(ii).ActorPoses.Yaw];
%     yaw_rate_pose(ii) = scenario(ii).ActorPoses.AngularVelocity(3);
% end 
% xRef = refPose(1,:);
% % yRef = refPose(2,:);
% yRef = refPose(2,:) + 2; %for lane change course
% yawRef = refPose(3,:);
% refPose = refPose'; % reference waypoints
% yaw_rate_pose = deg2rad(yaw_rate_pose); % angular velocity of the path

% %% Define initial position
% X_o = xRef(1,1); % initial vaehicle position
% Y_o = yRef(1,1); % initial vehicle position
% psi_o = deg2rad(yaw_rate_pose); % angular velocity of the path
% 
% %% define reference time 
% sim_time = 200;  % simulation time for city road
% 
% s = size(xRef);
% tRef = (linspace(0,sim_time,s(2)))'; % this time variable is used in the "2D Visualization" block for plotting the reference points. 

%% 
%% Define the sample time Ts and the simulation duration T in seconds
Ts = 0.1; % MPC sample time

%% curvature preview and calculation
PredictionHorizon = 10;
% md = get_curvature(Vx, yaw_rate_pose, tRef);
% data = mpc_previewer_maskinit(md, tRef);

u_min = -0.5; % constraint for the steering angle on the anticlockwise motion -30deg
u_max = 0.5;  % constraint for the steering angle on the clockwise motion +30deg

% Radius = abs(1./md.signals.values);

%% ACC Parameters
% specify the inital position and velocity for the two vehicles
x0_lead = 50; % initial position of the lead car (m)
v0_lead = 25; % initial position of the lead car (m/s)

x0_ego = 10; % initial position of the ego car (m)
v0_ego = 25; % initial position of the ego car (m/s)

t_gap = 1.4; % time gap in sec.
D_default = 10; % default stopping distance in meters

%% Specifying the drivers set velocity
v_set = 30; % velocity in m/s

%% Considering the physical limitation of the vehicle dynamics
% acceleration is constrained to a range [-3 2](m/s^2)
amin_ego = -3; 
amax_ego = 2;

%% Model parameters
m = 1140;      %kg
Iz = 1436.24; %kgm2
lf = 1.165; 
lr = 1.165;
Cf = 155494.663;
Cr = 1554494.663;

g = 9.81;
rho = 1.2;
Cd = 0.3;
f = 0.0125;
v_0 = 22;
vw_0 = 1.2;
a = 2.24;

%% Vehicle dynamics
Vx = 30;
tau = m /(rho*Cd*a*(v_0 - vw_0));

DCG = 1 /(rho*Cd*a*(v_0 - vw_0));

% longitudinal vehicle dynamics
A_1 = [-1/tau 0; 1 0];
B_1 = [1/tau; 0];
C_1 = [0 1; 0 0];
D_1 = 0;

% lateral vehicle dynamics
A_2 = [-2*(Cf + Cr)/(m*Vx)  -Vx-2*(Cf*lf - Cr*lr)/(m*Vx);...
           -2*(Cf*lf -Cr*lr)/(Iz*Vx) -2*(Cf*lf.^2 + Cr*lr.^2)/ (Iz*Vx)];
   
B_2 = [2*Cf/m; 2*lf*Cf/Iz];

C_2 = [1 0; 0 1];
D_2 = [0; 0];

% combined dynamics
A = [A_1 zeros(2,2); zeros(2,2) A_2];
B = [B_1 zeros(2,1); zeros(2,1) B_2];
C = [C_1 zeros(2,2); zeros(2,2) C_2];
D = 0;

Vehicle = ss(A,B,C,D);

