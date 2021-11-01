function [fig_trajectory_result] = trajectory_plot_lanechange(all_data,wheel_base)
% all_data = [x_state y_state yaw_state xRefq yRefq]
% sim_options = ["one lane", "3-lane","reference track"];



fig_trajectory_result = figure();

% collect all the data into variables
x_pos =all_data(:,1);
y_pos = all_data(:,2);
yaw_pos = all_data(:,3)
ref_x = all_data(:,4);
ref_y = all_data(:,5);

%% create reference road lines
% for lane change manuever we need two adjacent lanes

fig_trajectory_result; hold on; 
lane_width = 3.8;
road_center = [-20.1 0.2; 70.3 -0.1]; % [x y; xend yend]

y_end1 = road_center(1,2) +lane_width;
y_end2 = road_center(2,2) - lane_width ;
y_center = 0;
yline(y_end1, 'Linewidth', 3);
yline(y_end1+0.1, 'Linewidth',3);
yline(y_end2, 'Linewidth', 3);
yline(y_end2-0.1, 'Linewidth', 3);
yline(y_center,'--', 'Linewidth', 3);

xlabel('Time (sec)'); 
%% plot limits for plot image
x_min = road_center(1,1) -4;
x_max = road_center(2,1) + 4
y_max = y_end1 +5;
y_min  = y_end2 -5;


%% plot the reference path and road lines
fig_trajectory_result; hold on;
plot(ref_x,ref_y,'-*');

%% Plot the car motion

% initialize video
% myVideo = VideoWriter('myVideoFile'); %open video file
% myVideo.FrameRate = 15; 
% open(myVideo)

z_axis = [0 0 1];
fig_trajectory_result; hold on;
body =[];
    for ii = 1: length(x_pos)

        L =wheel_base;
        rear_x = x_pos(ii);
        rear_y = y_pos(ii);
        yaw =rad2deg( yaw_pos(ii));
        rear_length = 1.6;
        front_length = 1.6;
        side_width = 1;
        front_x = rear_x + L;
        front_y = rear_y;
        delete(body);

        plot(x_pos(ii),y_pos(ii),'-ro');
        drawnow;
% 
%         body = plot([rear_x-rear_length, front_x+front_length, front_x+front_length, rear_x-rear_length, rear_x-rear_length], ...
%             [rear_y-side_width, front_y-side_width, front_y+side_width, rear_y+side_width, rear_y-side_width],'r','Linewidth',2);
        
         body = plot([rear_x-rear_length, front_x+front_length, front_x+front_length, rear_x-rear_length, rear_x-rear_length], ...
            [rear_y-side_width, front_y-side_width, front_y+side_width, rear_y+side_width, rear_y-side_width],'r','Linewidth',2);
        rear_origin = [rear_x, rear_y, 0];
        front_origin = [rear_x + L*cos(yaw), rear_y + L*sin(yaw), 0];
        rotate(body, z_axis, yaw , rear_origin);
        
%         xlim([x_min-20 x_max+20]) ; ylim([y_min-10 y_max+10]);
%          xlim([xlim_max(ii)-20 xlim_max(ii)+20]) ; ylim([y_min-10 y_max+10]);
        xlim([x_min x_max]) ; ylim([y_min y_max]); 
        drawnow();
%         frame = getframe(gcf); %get frame
%         writeVideo(myVideo, frame);
    end
%     close(myVideo)

end