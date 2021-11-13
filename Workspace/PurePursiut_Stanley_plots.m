close all;
%% load data from model
state = out.position;
x_state = state(:,1);
y_state= state(:,2);
yaw_state = deg2rad(state(:,3));
n = size(x_state);

% match the reference input size to state output
tRefq = (linspace(0,Ts,n(1)))';
xRefq = interp1(tRef,xRef,tRefq);
yRefq = interp1(tRef,yRef,tRefq);

% concatenate all data for funciton
all_data = [x_state y_state yaw_state xRefq yRefq tRefq];
%%
figure(1)
plot(xRefq,yRefq,'Linewidth',2); hold on
plot(x_state,y_state, 'Linewidth',2); legend('reference','state')
xlabel('X (m)');ylabel('Y(m)'); grid on
%% cross track error
refPoseq = [xRefq yRefq];
veh_xy = [x_state y_state];

for ii = 2: length(veh_xy) -5
X = [xRefq(ii) , yRefq(ii) ; x_state(ii),y_state(ii)];
a = yRefq(ii-1) - yRefq(ii+5);
b = xRefq(ii+5) - xRefq(ii-1);
c = (xRefq(ii-1)*yRefq(ii+5)) - (xRefq(ii+5)*yRefq(ii-1));

d(ii) = (a*x_state(ii) + b*y_state(ii) + c) / sqrt(a^2 + b^2);


end
error = d;
%% Plots
figure(2)
subplot(2,1,1)
plot(xRefq,yRefq,'linewidth',2);
xlabel('X (m)','FontSize',12,'FontWeight','bold','Color','k');ylabel('Y (m)','FontSize',12,'FontWeight','bold','Color','k');
hold on
plot(x_state,y_state,'*'); grid on;
legend('waypoints','Vehicle state')
subplot(2,1,2)
plot(error, 'Linewidth',2); xlabel('Time(ms)','FontSize',12,'FontWeight','bold','Color','k');ylabel('Cross track error (m)','FontSize',12,'FontWeight','bold','Color','k');
grid on
%%
figure()
plot(error, 'Linewidth',2); xlabel('Time(ms)','FontSize',12,'FontWeight','bold','Color','k');ylabel('Cross track error (m)','FontSize',12,'FontWeight','bold','Color','k');
legend('Cross track error');grid on 