%% Initialization script for Highway Assist feature.
%%
clc;
clear all; close all
%%
%% Waypoints extraction from scenerio
% scenario = lane_change_target;
% 
% n = size(scenario);

Vx = 25;%mps
V_init = Vx;%mps
V_command = 15;%mps

for ii =1:n(2)
    refPose(:,ii) = [scenario(ii).ActorPoses.Position(1);scenario(ii).ActorPoses.Position(2);scenario(ii).ActorPoses.Yaw];
    yaw_rate_pose(ii) = scenario(ii).ActorPoses.AngularVelocity(3);
end 
xRef = refPose(1,:);
% yRef = refPose(2,:);
yRef = refPose(2,:) + 2; %for lane change course
yawRef = refPose(3,:);
refPose = refPose'; % reference waypoints
yaw_rate_pose = deg2rad(yaw_rate_pose); % angular velocity of the path

%% Define initial conditions
X_o = xRef(1,1);%initial vehicle position
Y_o = yRef(1,1);%initial vehicle position
psi_o = deg2rad(yawRef(1,1));%for lane change
%% Define reference time 
sim_time = 100;  % simulation time 

s = size(xRef);
tRef = (linspace(0,sim_time,s(2)))'; % this time variable is used in the "2D Visualization" block for plotting the reference points. 

%% 
%% Define the sample time Ts and the simulation duration T in seconds
Ts = 0.1; % MPC sample time

%% curvature preview and calculation
PredictionHorizon = 10;
md = get_curvature(Vx, yaw_rate_pose, tRef);
% data = mpc_previewer_maskinit(md, tRef);

u_min = -0.5; % constraint for the steering angle on the anticlockwise motion -30deg
u_max = 0.5;  % constraint for the steering angle on the clockwise motion +30deg

Radius = abs(1./md.signals.values);

%% Model parameters
m = 1140;      %kg
I_z = 1436.24; %kgm2
l_f = 1.165; 
l_r = 1.165;
c_f = 155494.663;
c_r = 1554494.663;

m = 1140;      %kg
Iz = 1436.24; %kgm2
lf = 1.165; 
lr = 1.165;
Cf = 155494.663;
Cr = 1554494.663;

%% Pure pursuit parameters
% L = 4.7;                    %Wheelbase length
% ld = 15;                    %Lookahead distance
% X_o = xRef(1,1);            % Initial vehicle posiiton
% Y_o = yRef(1,1);            % Initial vehicle posiiton
% psi_o = 0;                  % Yaw angle for lane change scenerio 
% % psi_o = -1.617;           % Yaw angle for city course scenerio 
% % psi_o = 4.17239;          % Yaw angle for eight course scenerio
% 
% % assuming constant velocity
% v_x = Vx; %mps
%% Dynamic bicycle model 
% continous A B C D matrixes
% A = [0 1 Vx 0;
%      0 -2*(c_f+c_r)/(m*v_x) 0 -2*(l_f*c_f + l_r*c_r)/(m*v_x) - v_x;
%      0 0 0 1;
%      0 2*(l_r*c_r - l_f*c_f)/(I_z*v_x)  0  -2*(l_r^2*c_r - l_f^2*c_f)/(I_z*v_x)];
%  
% B = [0;
%     2*c_f/m;
%     0;
%     2*l_f*c_f/I_z];
% 
% C= [1 0 0 0;
%        0 1 0 0];
% D = [0;0];
% %%
% vehicle = ss(A,B,C,D);
