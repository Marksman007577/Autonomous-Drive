% init script for LCA feature.
%%
clc;
clear all; close all
%%
%% Waypoints extraction from scenerio
% scenario = course1_lanechange;
% scenario = course2_fig8;
% scenario = course3_city_road;
n = size(scenario);

Vx = 10;
for ii =1:n(2)
    refPose(:,ii) = [scenario(ii).ActorPoses.Position(1);scenario(ii).ActorPoses.Position(2);scenario(ii).ActorPoses.Yaw];
    yaw_rate_pose(ii) = scenario(ii).ActorPoses.AngularVelocity(3);
end 
% xRef = refPose(1,:);
% yRef = refPose(2,:);
% yRef = refPose(2,:) + 2; %for lane change course
% yawRef = refPose(3,:);
% refPose = refPose'; % reference waypoints
%% define reference time 
% sim_time = 290;  % simulation time for city road
% sim_time = 26;   % simulation time for lance change road
% sim_time = 65;   % smulation time for figure eight course
s = size(xRef);
tRef = (linspace(0,sim_time,s(2)))'; % this time variable is used in the "2D Visualization" block for plotting the reference points. 

%% Define the MPC time
% Define the sample time Ts and the simulation time in seconds

Ts = 0.1;
PredictionHorizon = 10;

md = get_curvature(Vx, yaw_rate_pose, tRef);

%% Model parameters
m = 1140;      %kg
I_z = 1436.24; %kgm2
l_f = 1.165; 
l_r = 1.165;
c_f = 155494.663;
c_r = 1554494.663;

%% Pure pursuit parameters
L = 4.7;                    %Wheelbase length
ld = 15;                    %Lookahead distance
X_0 = xRef(1,1);            % Initial vehicle posiiton
Y_0 = yRef(1,1);            % Initial vehicle posiiton
psi_0 = 0;                  % Yaw angle for lane change scenerio 
% psi_0 = -1.617;           % Yaw angle for city course scenerio 
% psi_0 = 4.17239;          % Yaw angle for eight course scenerio
