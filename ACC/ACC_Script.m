%% Adaptive Cruise Control design for Vehicle model longitudinal dynamics
m = 1084;               % mass of vehicle in Kg.
g = 9.81;               % acceleration due to gravity in mpss
Cd = 0.3;               % drag coefficient
f = 0.0125;             % Rolling coefficient
V0 = 27.80;              % Initial velocity of the car in m/s
Vw_0 = 1.2;             % Initial wind velocity in m/s
A = 2.24;               % Cross sectional Area of the tyre surface
rho = 1.2;              % pressure in Km/m^3


%% Plant Model
plant_num = 9.2251*1e-4;
plant_den = [1 1/50.531];
G_plant = tf(plant_num, plant_den);