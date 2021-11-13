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
plant_den = [1 1/50.5355];
G_plant = tf(plant_num, plant_den);

sim_time = 100;
%% PID Gain Values from PID Tuner App
Kp = 174.6119;
Ki = 10.1187;
Kd = 0;

%% Script to demand set speed value from user
prompt_user = {'Enter set speed in Kph'};
dlgtitle = 'Input';
dims = 1;
definput = {'0'};
answer = cell2mat(inputdlg(prompt_user, dlgtitle, dims, definput));
V_set_speed = str2double(answer);

%% Plotting the output of various section
% figure
% plot(out.V_set_speed_mps.time, out.V_set_speed_mps.data, 'Linewidth', 2)
% hold all; grid on; xlabel('Time(sec)'); ylabel('Velocity(mps)');
% plot(out.Velocity_kph.time, out.Velocity_kph.data, 'Linewidth', 2)
% plot(out.Velocity_mps.time, out.Velocity_mps.data, 'Linewidth', 2)