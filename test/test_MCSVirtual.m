% test_MCS


cDir = fileparts(mfilename('fullpath'));
addpath(fullfile(cDir, '..', 'src'));


%% Create, init, and open
comm = smaract.MCSVirtual();
comm.init();

%% Get locator
comm.getSystemLocator()

%% Find reference
comm.getIsReferenced(0)
comm.findReferenceMark(0)
comm.getIsReferenced(0)

%% Move to position
comm.goToPositionAbsolute(0, 5e6)
comm.getStatusOfMovement(0)
comm.getPosition(0)
comm.getSensorEnabled();

%% Close
comm.closeSystem();