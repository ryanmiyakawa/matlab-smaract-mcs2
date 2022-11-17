

stage = smaract.MCS2();

cDeviceLocation = 'network:sn:MCS2-00005705';


stage.connect(cDeviceLocation);

%% Check if referenced:

lIsReferenced = stage.getIsReferenced(-1)

if(lIsReferenced)
    disp('Stage is referenced');
else
    disp('Stage is not referenced');

    stage.findReferenceMark(-1)
end



%% Check position:
dPosition = stage.getPosition(0)

% move to position:
channel = 0;
dPos = 1e9;
dResult = stage.goToPositionAbsolute(channel, dPos);

dPosition = stage.getPosition(0)
dPos = 0;
dResult = stage.goToPositionAbsolute(channel, dPos);

dPosition = stage.getPosition(0)


%% Disconnect
stage.disconnect();
