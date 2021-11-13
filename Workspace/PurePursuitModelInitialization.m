% Pure Pursuit Model Initialization
%
% Copyright 2020 The MathWorks, Inc.
%% add Image to the path
addpath(genpath('Images'));
%% load the scene data file generated from Driving Scenario Designer
load(lane_change_scenerio.mat);
%% define reference points
refPose = data.ActorSpecifications.Waypoints;
xRef = refPose(:,1);
yRef = -refPose(:,2);
%% define reference time for plotting 
Ts = 9; % simulation time
s = size(xRef);
tRef = (linspace(0,Ts,s(1)))'; % this time variable is used in the "2D Visualization" block for plotting the reference points. 
%% define parameters used in the models
K = 5;    % K is the tuning

L = 4.7;  % bicycle length

X_0 = xRef(1,1); % Initial vehicle posiiton
Y_0 = yRef(1,2); % Initial vehicle posiiton

psi_0 = 3.9775; % Yaw angle for lane change scenerio 
% psi_0 = -1.617; % Yaw angle for city course scenerio 