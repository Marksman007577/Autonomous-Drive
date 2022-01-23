%% Cruise Control design for Vehicle model longitudinal dynamics
m = 1084;               % mass of vehicle in Kg.
g = 9.81;               % acceleration due to gravity in mpss
Cd = 0.3;               % drag coefficient
f = 0.0125;             % Rolling coefficient
V0 = 27.80;              % Initial velocity of the car in m/s
Vw_0 = 1.2;             % Initial wind velocity in m/s
A = 2.24;               % Cross sectional Area of the tyre surface
rho = 1.2;              % pressure in Km/m^3


%% Plant Model
plant_num = 9.22123*1e-4;
plant_den = [1 0.01978804428];
G_plant = tf(plant_num, plant_den);

sim_time = 600;
%% PI and PID Gain Values from PID Tuner App
%Velocity control
Kp_vel = 174.6119;
Ki_vel = 10.1187;

%Headway control
Kp_hw = 143.6748;
Ki_hw = 7.4723;
Kd_hw = -8.9604;
Tf = 0.062366;
