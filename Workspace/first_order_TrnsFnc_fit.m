%%
clc;clear all;close all;
%%
ts = 0.1;
N = 250;
time = 0:ts:N-1;
Gp = tf([1e-3],[1 0.013]);
throttle_input = [];
for ii = 1:length(time)
    throttle_input(ii, 1) = 500;
end

%%
fs = 1/N
[out,t] = lsim(Gp, throttle_input,time);
plot(t,out)

data = iddata(out,throttle_input,ts);

%% fit a first order Transfer Function Linear Time-Invariant
np = 1; %first order tf
sys = tfest(data,np)