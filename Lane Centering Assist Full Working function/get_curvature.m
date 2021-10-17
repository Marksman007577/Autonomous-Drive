function md = get_curvature(Vx,yaw_rate_pose,time)
% get_curvature(Vx,yaw_rate_pose,Ts)
% radius from 

radius = zeros(length(yaw_rate_pose),1);
for ii = 1: length(yaw_rate_pose)
    
    radius(ii) = Vx/yaw_rate_pose(ii);
end
curvature = (1./radius);


% md.time = time(1:length(curvature));
md.time = time;
md.signals.values = curvature;

end