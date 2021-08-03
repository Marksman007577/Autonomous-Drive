%%
clc;clear all;close all;

%% CACC Vehicle Parameters
% headway constant
h = 0.9; % Headway time gap.

%% Lead vehicle dynamics parameters
tau0 = 0.1 %lead vehivle time const.
Lambda0 = 1; %lead vehicle DC Gain.

%% Feed forward filter closed loop bandwidth
tau = 0.002; 

%% Platoon vehicle(s) dynamics parameters (DC Gains and Time constants)
tau1 = 0.5;
tau2 = 0.7;
tau3 = 0.3;
tau4 = 0.4;
tau5 = 0.6;

Lambda1 = 0.5;
Lambda2 = 0.7;
Lambda3 = 0.75;
Lambda4 = 0.4;
Lambda5 = 0.6;

%% PD Headway controller parameters
Kp = 1.5;
Kd = 1.2;