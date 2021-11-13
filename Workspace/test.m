%% model parameter
sim_time = 15; % in Sec
m = 10; % in Kg
b = 10; % Damping coefficient in Nm/s
k = 20; % spring coefficient in Nm
step_value = 1; % Reference input

num = [b k];
den = [m b k];

X = roots([m b k])

system = tf(num, den);