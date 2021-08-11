%% Pure Pursuit Controller
clc;
% clear all;
close all;
%% Load the scenerio data file generated from Driving Scenerio Designer App
scenerio = generateSensorData;  %This represents function from Drive scenerio lane change.
% scenerio = fig_eight_course;                      %This represents function from Drive scenerio fig eight course.
% scenerio = city_road;                             %This represents function from Drive scenerio city road
n = size(scenerio);

for ii = 1:n(2)
    Ref_pose = [scenerio(ii).ActorPoses.Position(1);scenerio(ii).ActorPoses.Position(2);scenerio(ii).ActorPoses.Yaw];
end

X_ref = Ref_pose(1,:);
Y_ref = Ref_pose(2,:);
Yaw_ref = Ref_pose(3,:);
Vref = 10;
Ref_pose = Ref_pose'; % Reference way points

%% Define reference times for plotting
% Ts = 120; % Simulation time for city road
Ts = 9;   % Simulation time for lane change
% Ts = 65;  % Simulation time for figure eight road
s = size(X_ref);
Ref_t = (linspace(0,Ts, s(2))); % Time variable used for 2D visualization block for plotting reference points

%% Defining parameters used in the model
L = 4.7; % Wheelbase length
Ld = 10; %Lookahead distance
X_0 = X_ref(1,1); % Initial vehicle posiiton
Y_0 = Y_ref(1,1); % Initial vehicle posiiton
psi_0 = 0; % Yaw angle for lane change scenerio 
% psi_0 = -1.617; % Yaw angle for city course scenerio 
% psi_0 = 4.17239; % Yaw angle for lane change scenerio 