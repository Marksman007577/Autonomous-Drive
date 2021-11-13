%% Plant parameter for the spring mass damper system
sim_time = 15; % The time is in seconds
step_value = 1; % Reference input
m = 1;
b = 10;
k = 20;
% num = 1;
% den = [m b k];
% sys = tf(num, den);
%% Defining the P controller parameter
% kp = 300;
% ki = 0;
% kd = 0;
% 
% sim('PID_controller');

%% Defining the PI controller parameter
% kp = 300;
% ki = 300;
% kd = 0;
% 
% sim('PID_controller');

%% Defining the PID controller parameter
kp = 350;
ki = 300;
kd = 25;

% sim('PID_controller');
%% Plotting the output of various section
% figure
% plot(out.input.time, out.input.data, 'Linewidth', 2)
% hold all; grid on; xlabel('time(sec)'); ylabel('output');
% plot(out.output.time, out.output.data, 'Linewidth', 2)