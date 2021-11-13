%%
clc;
clear all; close all
%% Waypoints extraction
% scenario = course1_lanechange;
scenario = course2_fig8;
% % scenario = course3_city_road;
n = size(scenario);

Vx = 30;
for ii =1:n(2)
    refPose(:,ii) = [scenario(ii).ActorPoses.Position(1);scenario(ii).ActorPoses.Position(2);scenario(ii).ActorPoses.Yaw];
    yaw_rate_pose(ii) = scenario(ii).ActorPoses.AngularVelocity(3);
end 
xRef = refPose(1,:);
yRef = refPose(2,:);
% yRef = refPose(2,:) + 2; %for lane change course
yawRef = refPose(3,:);
refPose = refPose'; % reference waypoints
%% define reference time 
% Ts = 290; % simulation time for city road
% Ts = 26;% simulation time for lance change road
Ts =65 ; % smulation time for figure eight course
s = size(xRef);
tRef = (linspace(0,Ts,s(2)))'; % this time variable is used in the "2D Visualization" block for plotting the reference points. 

%% Model parameters
m = 1140;
I_z = 1436.24; %kgm2
l_f = 1.165; 
l_r = 1.165;
c_f = 155494.663;
c_r = 1554494.663;

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