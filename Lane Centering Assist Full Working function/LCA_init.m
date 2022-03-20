% initalization script for feature model for Lance centering assist
%%
clc;
clear all; close all
%% Waypoints extraction from scenarios
scenario = lane_change_25mps;
% scenario = course1_lancechange;
% scenario = lane_change_course_1;
% scenario = course2_fig8;
% scenario = course3_city_road;
n = size(scenario);

Vx = 25; %mps
for ii =1:n(2)
    refPose(:,ii) = [scenario(ii).ActorPoses.Position(1);scenario(ii).ActorPoses.Position(2);scenario(ii).ActorPoses.Yaw];
    yaw_rate_pose(ii) = scenario(ii).ActorPoses.AngularVelocity(3);
end 
xRef = refPose(1,:);
yRef = refPose(2,:) ;
yRef = refPose(2,:) + 2; %for lane change course
% yawRef = refPose(3,:);
refPose = refPose'; % reference waypoints
yaw_rate_pose = deg2rad(yaw_rate_pose); %angular velocity of the path

%% define reference time 
% sim_time = 290; % simulation time for city road
sim_time = 16;% simulation time for lance change road
% sim_time =65 ; % smulation time for figure eight course
s = size(xRef);
tRef = (linspace(0,sim_time,s(2)))'; % this time variable is used in the "2D Visualization" block for plotting the reference points. 


%%
% Define the sample time, |Ts|, and simulation duration, |T|, in seconds.
Ts = 0.1; % sample time for MPC

%% curvature preview and calculation
PredictionHorizon = 10;
md =get_curvature(Vx,yaw_rate_pose,tRef');
% data = mpc_previewer_maskinit(md,tRef');
u_min = -0.5;
u_max = 0.5;
Radius =abs(1./ md.signals.values);
%% Model parameters
m = 1140;

I_z = 1436.24; %kgm2
l_f = 1.165; 
l_r = 1.165;
c_f = 155494.663;
c_r = 1554494.663;


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

%% Parameters for Pure Pursuit
L = 4.7; % bicycle length
ld = 10; % lookahead distance
X_o = xRef(1,1); % initial vehicle position
Y_o = yRef(1,1); % initial vehicle position 
psi_o = 0; % for lane change
% psi_o =   -1.617; % initial yaw angle
% psi_o =4.17239; % initial yaw angle for fig eight
