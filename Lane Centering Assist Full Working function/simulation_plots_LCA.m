close all;
% for mpc based results
%% output data
lat_error = out.cross_track;
yaw_error = out.Theta_e;

%% plots
figure(1)
plot(lat_error,'Linewidth',2);
grid on;

figure(2)
plot(yaw_error,'Linewidth',2);
grid on;

%% states

n = size(yaw_error);
% match the reference input size to state output
tRefq = (linspace(0,sim_time,n(1)))';
xRefq = interp1(tRef,xRef,tRefq);
yRefq = interp1(tRef,yRef,tRefq);
yawRefq = interp1(tRef,yawRef,tRefq); % degrees

x_state = xRefq;

for ii = 1:n(1)
    y_state(ii) = lat_error(ii) + yRefq(ii);
    yaw_state(ii) = yaw_error(ii) + deg2rad(yawRefq(ii));
end
all_data = [x_state y_state' yaw_state' xRefq yRefq tRefq];
%% tracking performance
figure(3)
subplot(2,1,1)
plot(xRefq,yRefq,'linewidth',2);
xlabel('X (m)','FontSize',12,'FontWeight','bold','Color','k');ylabel('Y (m)','FontSize',12,'FontWeight','bold','Color','k');
hold on
plot(x_state,y_state,'*'); grid on;
legend('waypoints','Vehicle state')
subplot(2,1,2)
plot(lat_error, 'Linewidth',2); xlabel('Time(ms)','FontSize',12,'FontWeight','bold','Color','k');ylabel('Cross track error (m)','FontSize',12,'FontWeight','bold','Color','k');
grid on
%% movie function
lateral_movie_fcn(all_data,lat_error)
