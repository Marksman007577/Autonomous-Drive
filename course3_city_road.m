function [allData, scenario, sensor] = generateSensorData()
%generateSensorData - Returns sensor detections
%    allData = generateSensorData returns sensor detections in a structure
%    with time for an internally defined scenario and sensor suite.
%
%    [allData, scenario, sensors] = generateSensorData optionally returns
%    the drivingScenario and detection generator objects.

% Generated by MATLAB(R) 9.9 (R2020b) and Automated Driving Toolbox 3.2 (R2020b).
% Generated on: 07-Mar-2021 16:43:39

% Create the drivingScenario object and ego car
[scenario, egoVehicle] = createDrivingScenario;

% Create all the sensors
sensor = createSensor(scenario);

allData = struct('Time', {}, 'ActorPoses', {}, 'ObjectDetections', {}, 'LaneDetections', {}, 'PointClouds', {});
running = true;
while running
    
    % Generate the target poses of all actors relative to the ego vehicle
    poses = targetPoses(egoVehicle);
    time  = scenario.SimulationTime;
    
    % Generate detections for the sensor
    laneDetections = [];
    ptClouds = [];
    [objectDetections, numObjects, isValidTime] = sensor(poses, time);
    objectDetections = objectDetections(1:numObjects);
    
    % Aggregate all detections into a structure for later use
    if isValidTime
        allData(end + 1) = struct( ...
            'Time',       scenario.SimulationTime, ...
            'ActorPoses', actorPoses(scenario), ...
            'ObjectDetections', {objectDetections}, ...
            'LaneDetections', {laneDetections}, ...
            'PointClouds',   {ptClouds}); %#ok<AGROW>
    end
    
    % Advance the scenario one time step and exit the loop if the scenario is complete
    running = advance(scenario);
end

% Restart the driving scenario to return the actors to their initial positions.
restart(scenario);

% Release the sensor object so it can be used again.
release(sensor);

%%%%%%%%%%%%%%%%%%%%
% Helper functions %
%%%%%%%%%%%%%%%%%%%%

% Units used in createSensors and createDrivingScenario
% Distance/Position - meters
% Speed             - meters/second
% Angles            - degrees
% RCS Pattern       - dBsm

function sensor = createSensor(scenario)
% createSensors Returns all sensor objects to generate detections

% Assign into each sensor the physical and radar profiles for all actors
profiles = actorProfiles(scenario);
sensor = visionDetectionGenerator('SensorIndex', 1, ...
    'SensorLocation', [3.7 0], ...
    'MaxRange', 100, ...
    'DetectorOutput', 'Objects only', ...
    'Intrinsics', cameraIntrinsics([1814.81018227767 1814.81018227767],[320 240],[480 640]), ...
    'ActorProfiles', profiles);

function [scenario, egoVehicle] = createDrivingScenario
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [151.1 251.8 0;
    -192.6 251.8 0;
    -244 230.8 0;
    -272.7 175.5 0;
    -274.3 73.9 0;
    -271 -115.6 0;
    -247.8 -181.9 0;
    -195.4 -214.1 0;
    -74.2 -212.1 0;
    -47.7 -192.9 0;
    -39.5 -166.9 0;
    -39.8 -128 0;
    -54.4 -96.9 0;
    -98.1 -90.3 0;
    -158.3 -89 0;
    -192.1 -63.8 0;
    -212.6 -22.7 0;
    -200.7 99.8 0;
    -180.2 109.7 0;
    -149.1 121 0;
    -118.6 106.4 0;
    -98.7 41.9 0;
    -78.2 13 0;
    -37.1 15 0;
    -10.7 54.7 0;
    3.2 119 0;
    32.4 142.8 0;
    72.8 129.6 0;
    99.3 79.9 0;
    99.3 -148.6 0;
    139 -202.2 0;
    197.3 -200.2 0;
    245.6 -165.1 0;
    246.9 -46.6 0;
    250.9 111.7 0;
    234.4 207 0;
    151.1 251.8 0];
road(scenario, roadCenters, 'Name', 'Road');

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [-273.5 -1.1 0], ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'Car');
waypoints = [-273.5 -1.1 0;
    -274.2 -19.5 0;
    -274.4 -55.5 0;
    -274 -82.6 0;
    -270.9 -116.2 0;
    -264.8 -150.8 0;
    -248.1 -182.2 0;
    -229.7 -199.5 0;
    -195.5 -214.3 0;
    -164.8 -221.8 0;
    -137 -224.7 0;
    -99.7 -220.6 0;
    -74.6 -212 0;
    -57.4 -203.3 0;
    -47.7 -193.3 0;
    -39.1 -166.9 0;
    -39.9 -127.2 0;
    -43.9 -109.2 0;
    -54.4 -97.1 0;
    -67.8 -89.9 0;
    -98.3 -89.9 0;
    -133.5 -93.5 0;
    -158.5 -89.3 0;
    -178.9 -77.5 0;
    -192.7 -64 0;
    -211.4 -22.7 0;
    -225.4 13.8 0;
    -229.1 43.8 0;
    -225.8 64.1 0;
    -219.9 80.1 0;
    -200.9 99.8 0;
    -179.6 109.3 0;
    -149.2 120.7 0;
    -132.4 117.6 0;
    -118.9 106.8 0;
    -108.2 88.3 0;
    -98.8 41.9 0;
    -91.6 24.9 0;
    -78.3 13.1 0;
    -59.3 7.3 0;
    -47.3 9.3 0;
    -36.1 14.6 0;
    -24.1 25.9 0;
    -15.7 39.5 0;
    -10.6 55 0;
    -5.6 86.2 0;
    -3 103.6 0;
    2.4 119.5 0;
    11.3 131 0;
    24 140.5 0;
    32.7 142.9 0;
    53.4 142.4 0;
    73.9 129.5 0;
    89.9 107.9 0;
    99.1 80.7 0;
    103.6 46 0;
    102.8 6.4 0;
    94.9 -63.1 0;
    92.9 -105.5 0;
    98.6 -149 0;
    108.8 -173.3 0;
    124.1 -193.5 0;
    139.5 -202.4 0;
    163.3 -208.3 0;
    197.3 -200.9 0;
    224.2 -187.3 0;
    245.3 -165.4 0;
    254.3 -147 0;
    258.5 -121.3 0;
    254.5 -81.9 0;
    247.2 -45.7 0;
    243 2.3 0;
    249.6 90.3 0;
    251.9 147.9 0;
    249.7 171.6 0;
    243.8 193.2 0;
    234.9 207.1 0;
    219.2 224.4 0;
    188.5 241 0;
    150.3 251.8 0;
    100.3 262.6 0;
    62.7 266.7 0;
    -8.4 271.1 0;
    -101 266.7 0;
    -193 252.5 0;
    -226.6 241.2 0;
    -244.7 230.7 0;
    -262.3 207.9 0;
    -273 174.9 0;
    -276.7 148 0;
    -274.1 73.5 0;
    -273.9 3.3 0];
speed = [10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10;10];
trajectory(egoVehicle, waypoints, speed);

