%% Automatic Lane Change
m = 1084;               % mass of vehicle in Kg.


%% Plant Model
plant_num = 9.2251*1e-4;
plant_den = [1 1/50.531];
G_plant = tf(plant_num, plant_den);