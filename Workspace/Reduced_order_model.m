%% Vehicle model longitudinal dynamics
%% Reduced order model from root locus diagram
m = 1084;               % mass of vehicle in Kg.
g = 9.81;               % acceleration due to gravity in mpss
Cd = 0.3;               % drag coefficient
f = 0.0125;             % Rolling coefficient
V0 = 27.8;              % Initial velocity of the car in m/s
Vw_0 = 1.2;             % Initial wind velocity in m/s
A = 2.24;               % Cross sectional Area of the tyre surface
rho = 1.2;              % pressure in Km/m^3

zeroes = [1/m];
poles = [1 rho*Cd*A*(V0 - Vw_0)/m];
sys = tf(zeroes,poles);