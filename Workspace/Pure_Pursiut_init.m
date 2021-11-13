%% Pure Pursuit Controller and Stanley Controller
clc;
% clear all;
close all;
%% Load the scenerio data file generated from Driving Scenerio Designer App
scenerio = course1_lanechange;                    %This represents function from Drive scenerio lane change.
% scenerio = course2_fig8;                      %This represents function from Drive scenerio fig eight course.
% scenerio = course3_city_road;                             %This represents function from Drive scenerio city road
n = size(scenerio);

for ii = 1:n(2)
    refPose = [scenerio(ii).ActorPoses.Position(1);scenerio(ii).ActorPoses.Position(2);scenerio(ii).ActorPoses.Yaw];
end
xRef = refPose(1,:);
yRef = refPose(2,:);
yawRef = refPose(3,:);
Vref = 10;
refPose = refPose'; % Reference way points stored in a matrix form

%% Define reference times for plotting
% Ts = 120;   % Simulation time for city road
Ts = 9;       % Simulation time for lane change
% Ts = 15.4;  % Simulation time for figure eight road
s = size(xRef);
tRef = (linspace(0,Ts, s(2))); % Time variable used for 2D visualization block for plotting reference points

%% Defining parameters used in the model
L = 4.7; % Wheelbase length
Ld = 10; %Lookahead distance
X_0 = xRef(1,1); % Initial vehicle posiiton
Y_0 = yRef(1,1); % Initial vehicle posiiton
psi_0 = 0; % Yaw angle for lane change scenerio 
% psi_0 = -1.617; % Yaw angle for city course scenerio 
% psi_0 = 4.17239; % Yaw angle for eight course scenerio 
