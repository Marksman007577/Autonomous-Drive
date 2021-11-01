function fig_trajectory_result = plotmovie(all_data, lat_error_vec)

%all_data = [x_pos y_pos yaw_pos(rad) xRef yRef t_ref]

x_pos = all_data(:,1);
y_pos = all_data(:,2);
yaw_pos =rad2deg(all_data(:,3));  % yaw position is in degrees
x_ref = all_data(:,4);
y_ref = all_data(:,5);
t = all_data(:,6);
dt = t(2)-t(1);

% difference in error and data
diff = length(x_pos) - length(lat_error_vec);

lat_error_vec = [lat_error_vec zeros(1,diff)];
sp_num = 18;
subpl1 = 'subplot(sp_num,sp_num, sp_num+1:sp_num*12);';
subpl2 = 'subplot(sp_num,sp_num, sp_num*13+1:sp_num*15);';

fig_trajectory_result = figure(1);

% plot the reference path line
set(fig_trajectory_result, 'Position', [716 735 1026 1146]);
eval(subpl1);
plot( x_ref,y_ref,'k-.'); hold on; grid on;
xlabel('x [m]'); ylabel('y [m]');

% plot the cross track error
eval(subpl2);
plot(t(1:length(lat_error_vec)), lat_error_vec, 'b'); grid on; hold on; 
xlabel('t [s]'); ylabel('cross track error [m]');
ulim = ceil(2*max(lat_error_vec))/2;
dlim = floor(2*min(lat_error_vec))/2;
ylim([dlim, ulim]);

% plot variable names
z_axis = [0 0 1];

cg = []; setpoint = []; rear_tire = []; front_tire = []; body = []; tracked = []; 
setpoint_ideal = []; error_point = []; steer_point = []; time_bar_laterror = []; time_bar_steer = [];
L = 5.7;
rear_length = 3.5;
front_length = 3.5;
side_width = 2;

fig_draw_i = 1:round(1/dt/20):length(t);

% for the movie

jj = 1;

fig_trajectory_result; hold on;

% initialize video
% myVideo = VideoWriter('myVideoFile'); %open video file
% myVideo.FrameRate = 15; 
% open(myVideo)

for ii = fig_draw_i
    eval(subpl1);
    %     disp(t(ii));
    % rear wheel axel coordinates    
    rear_x = x_pos(ii);
    rear_y = y_pos(ii);
    yaw = yaw_pos(ii);

    % fron wheel coordinates
    front_x = rear_x + L;
    front_y = rear_y;
    %     delete([setpoint, rear_tire, front_tire, body, tracked, setpoint_ideal, error_point, steer_point, time_bar_laterror, time_bar_steer]);
    delete([cg,body]);
    
   % plot elements
    tracked = plot(x_pos(1:ii),y_pos(1:ii),'r');
    cg = plot(x_pos(ii),y_pos(ii), 'o');

    title_draw = "t = "+num2str(t(ii),'%5.1f') +"  cross-track error = "+num2str(lat_error_vec(ii),'%+2.2f');


    body = plot([rear_x-rear_length, front_x+front_length, front_x+front_length, rear_x-rear_length, rear_x-rear_length], ...
    [rear_y-side_width, front_y-side_width, front_y+side_width, rear_y+side_width, rear_y-side_width],'k');
    rear_origin = [rear_x, rear_y, 0];
    front_origin = [rear_x + L*cos(yaw), rear_y + L*sin(yaw), 0];
    rotate(body, z_axis, yaw, rear_origin);
    drawnow; 
    title(title_draw);

    %% lat error
    eval(subpl2);
    error_point = plot(t(ii), lat_error_vec(ii), 'ok');

% frame = getframe(gcf); %get frame
%         writeVideo(myVideo, frame);

    end
%     close(myVideo)

end