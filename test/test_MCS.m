% test_MCS

addpath('../src')

%% Create, init, and open
comm = smaract.MCS2();

%% Run test
comm.runTest()

%% Find reference
comm.getIsReferenced(0)
comm.findReferenceMark(0)
comm.getIsReferenced(0)

%% Move to position
comm.goToPositionAbsolute(0, 5e6)
comm.getPosition(0)

%% Cleanup
delete(comm)