%% stability check
% zeros = [3 -2];
% poles = [1 -9 20];
% 
% system = tf(zeros, poles)

ts = trackingScenario;
height = 100;
d = 1;
wayPoints = [ ...
    -30   -25   height;
    -30    25-d height;
    -30+d  25   height;
    -10-d  25   height;
    -10    25-d height;
    -10   -25+d height;
    -10+d -25   height;
    10-d -25   height;
    10   -25+d height;
    10    25-d height;
    10+d  25   height;
    30-d  25   height;
    30    25-d height;
    30   -25+d height;
    30   -25   height];

elapsedTime = linspace(0,10,size(wayPoints,1));

target = platform(ts);
traj = waypointTrajectory('Waypoints',wayPoints,'TimeOfArrival',elapsedTime);
target.Trajectory = traj;

r = record(ts);
pposes = [r(:).Poses];
pposition = vertcat(pposes.Position);

tp = theaterPlot('XLim',[-40 40],'YLim',[-40 40]);
trajPlotter = trajectoryPlotter(tp,'DisplayName','Trajectory');
plotTrajectory(trajPlotter,{pposition})

restart(ts);
trajPlotter = platformPlotter(tp,'DisplayName','Platform');

while advance(ts)
    p = pose(target,'true');
    plotPlatform(trajPlotter, p.Position);
    pause(0.1)
    
end