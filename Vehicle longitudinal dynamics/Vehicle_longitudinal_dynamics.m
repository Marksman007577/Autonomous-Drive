%% Vehicle model longitudinal dynamics
m = 1084;               % mass of vehicle in Kg.
g = 9.81;               % acceleration due to gravity in mpss
Cd = 0.3;               % drag coefficient
f = 0.0125;             % Rolling coefficient
V0 = 22;              % Initial velocity of the car in m/s
Vw_0 = 1.2;             % Initial wind velocity in m/s
A = 2.24;               % Cross sectional Area of the tyre surface
rho = 1.2;              % pressure in Km/m^3

sim('Vehicle_long_dyn_LinearizedModel');

%% Plotting the output of various section
figure
plot(out.Step_input.time, out.Step_input.data, 'Linewidth', 2)
hold all; grid on; xlabel('time(sec)'); ylabel('output');
plot(out.Velocity.time, out.Velocity.data, 'Linewidth', 2)
plot(out.Theta.time, out.Theta.data, 'Linewidth', 2)
plot(out.Wind_Velocity.time, out.Wind_Velocity.data, 'Linewidth', 2)