function [allData, scenario, sensor] = scenerio2()
%generateSensorData - Returns sensor detections
%    allData = generateSensorData returns sensor detections in a structure
%    with time for an internally defined scenario and sensor suite.
%
%    [allData, scenario, sensors] = generateSensorData optionally returns
%    the drivingScenario and detection generator objects.

% Generated by MATLAB(R) 9.10 (R2021a) and Automated Driving Toolbox 3.3 (R2021a).
% Generated on: 16-Feb-2022 23:43:08

% Create the drivingScenario object and ego car
[scenario, egoVehicle] = createDrivingScenario;

% Create all the sensors
sensor = createSensor(scenario);

allData = struct('Time', {}, 'ActorPoses', {}, 'ObjectDetections', {}, 'LaneDetections', {}, 'PointClouds', {}, 'INSMeasurements', {});
running = true;
while running
    
    % Generate the target poses of all actors relative to the ego vehicle
    poses = targetPoses(egoVehicle);
    time  = scenario.SimulationTime;
    
    % Generate detections for the sensor
    laneDetections = [];
    ptClouds = [];
    insMeas = [];
    [objectDetections, numObjects, isValidTime] = sensor(poses, time);
    objectDetections = objectDetections(1:numObjects);
    
    % Aggregate all detections into a structure for later use
    if isValidTime
        allData(end + 1) = struct( ...
            'Time',       scenario.SimulationTime, ...
            'ActorPoses', actorPoses(scenario), ...
            'ObjectDetections', {objectDetections}, ...
            'LaneDetections', {laneDetections}, ...
            'PointClouds',   {ptClouds}, ... %#ok<AGROW>
            'INSMeasurements',   {insMeas}); %#ok<AGROW>
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
roadCenters = [52.2 62.9 0;
    19.1 137.1 0;
    -45.4 98.4 0;
    -108.3 136.3 0;
    -165.5 41.1 0;
    -95.4 -62.1 0;
    -42.1 8.9 0;
    38.5 -8.9 0;
    52.2 62.9 0];
laneSpecification = lanespec(2);
road(scenario, roadCenters, 'Lanes', laneSpecification, 'Name', 'Road');

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [-117.3 -69.1 0], ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'Car');
waypoints = [-117.3 -69.1 0;
    -100.4 -67.1 0;
    -87 -58.6 0;
    -71.7 -32.6 0;
    -60.1 -5.7 0;
    -42.6 6.9 0;
    -29.1 9.1 0;
    -12.5 2.4 0;
    0.5 -4.8 0;
    21.6 -12.5 0;
    39.5 -11.1 0;
    50.3 -0.4 0;
    57.9 15.3 0;
    57.9 34.6 0;
    54.8 54.4 0;
    53.9 70.5 0;
    53 90.7 0;
    49.8 109.1 0;
    44 125.2 0;
    32 135.6 0;
    20.3 138.7 0;
    7.3 136 0;
    -6.2 126.7 0;
    -17.5 116.5 0;
    -31.3 105.3 0;
    -44.4 99.1 0;
    -57.8 101.6 0;
    -70.9 109.6 0;
    -81.8 119.8 0;
    -94.6 131.1 0;
    -109.2 139.1 0;
    -125.4 138.7 0;
    -140.9 132.4 0;
    -156.7 113.7 0;
    -165.6 89.7 0;
    -167 61.7 0;
    -167.8 42.2 0;
    -167.4 20.4 0;
    -167.4 -3.9 0;
    -164.2 -22.2 0;
    -158.7 -38.1 0;
    -153.1 -47.7 0;
    -146.1 -55.8 0;
    -137.7 -62.8 0;
    -130.7 -66.1 0;
    -118.5 -68.3 0];
speed = [30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30;30];
trajectory(egoVehicle, waypoints, speed);
