% test_MCS


cDir = fileparts(mfilename('fullpath'));
addpath(fullfile(cDir, '..', 'src'));


%% Create, init, and open
comm = smaract.MCSVirtual();

%% Find reference
comm.getIsReferenced(0)
comm.findReferenceMark(0)
comm.getIsReferenced(0)

%% Move to position
comm.goToPositionAbsolute(0, 5e6)
comm.getPosition(0)
