%% Stanley control init
clc;
% clear all;
close all;
%% Load the scenerio data file generated from Driving Scenerio Designer App
scenerio = lane_change;                    %This represents function from Drive scenerio lane change.
% scenerio = eight_course;                      %This represents function from Drive scenerio fig eight course.
% scenerio = city_course;                             %This represents function from Drive scenerio city road
n = size(scenerio);

for ii = 1:n(2)
    refpose = [scenerio(ii).ActorPoses.Position(1);scenerio(ii).ActorPoses.Position(2);scenerio(ii).ActorPoses.Yaw];
end
xRef = refpose(1,:);
yRef = refpose(2,:);
yawref = refpose(3,:);
vRef = 10;
refpose = refpose'; % Reference way points stored in a matrix form

%% Define reference times for plotting
% Ts = 13.1; % Simulation time for city road
Ts = 1.6;     % Simulation time for lane change
% Ts = 7.8;  % Simulation time for figure eight road
s = size(xRef);
tRef = (linspace(0,Ts, s(2))); % Time variable used for 2D visualization block for plotting reference points

%% Defining parameters used in the model
K = 5;    % K is the tuning

L = 4.7;  % bicycle length

X_0 = xRef(1,1); % Initial vehicle posiiton
Y_0 = yRef(1,1); % Initial vehicle posiiton

psi_0 = -1.4111; % Yaw angle for lane change scenerio 
% psi_0 = -28.2726; % Yaw angle for eight course scenerio 
% psi_0 = -33.0262; % Yaw angle for city course scenerio 