%% model parameter
sim_time = 15; % in Sec
m = 10; % in Kg
b = 10; % Damping coefficient in Nm/s
k = 20; % spring coefficient in Nm
step_value = 1; % Reference input

% sim ('Spring_Mass_Damper')

zeros = 1;
poles = [m b k];

X = roots([m b k]);

system = tf(zeros, poles);

%% Plotting the output of various section
% figure
% plot(out.Force.time, out.Force.data, 'Linewidth', 2)
% hold all; grid on; xlabel('time(sec)'); ylabel('output');
% plot(out.SMD1.time, out.SMD1.data, 'Linewidth', 2)
% plot(out.SMD2.time, out.SMD2.data, 'Linewidth', 2)