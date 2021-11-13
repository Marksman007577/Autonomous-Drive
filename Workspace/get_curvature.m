function md = get_curvature(Vx,yaw_rate_pose,time)
% V = omega*R
radius = zeros(length(yaw_rate_pose),1);

for ii = 1:length(yaw_rate_pose)
    radius(ii) = Vx/yaw_rate_pose(ii);
end

curvature = (1./radius);

md.time = time;
md.signals.values = curvature;
end