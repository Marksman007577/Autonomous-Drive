%% Headway Control design for Vehicle model longitudinal dynamics
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


%% PID Gain from PID Tuner App
% Kp = 1.23373996546318;
% Ki = 0.00611903694432425;
% Kd = 34.7378082281947;
%  
% sim('Headway_control');

Kp = 8.4948;
Ki = 0.093505;
Kd = 132.1324;

% Script to demand set speed value from user
% prompt_user = {'Enter host speed in mps'};
% dlgtitle = 'Input';
% dims = 1;
% definput = {'0'}
% answer = cell2mat(inputdlg(prompt_user, dlgtitle, dims, definput));
% V_set_speed = str2double(answer)
% 
% %% Plotting the output of various section
% figure
% plot(out.v_host_mps.time, out.v_host_mps.data, 'Linewidth', 2)
% hold all; grid on; xlabel('Time(sec)'); ylabel('Velocity(V)');
% plot(out.v_target_mps.time, out.v_target_mps.data, 'Linewidth', 2)
% plot(out.Headway_error.time, out.Headway_error.data, 'Linewidth', 2)
% 
% %% Plotting the output of various section
% figure
% % plot(out.Range_command_m.time, out.Range_command_m.data, 'Linewidth', 2)
% hold all; grid on; xlabel('Time(sec)'); ylabel('Range(m)');
% % plot(out.Range_m.time, out.Range_m.data, 'Linewidth', 2)
% plot(out.Headway_error.time, out.Headway_error.data, 'Linewidth', 2)