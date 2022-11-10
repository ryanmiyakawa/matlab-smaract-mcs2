BF_LIST_DEVICES                 =0    ;
BF_SA_CTL_Open                  =1     ;
BF_SA_CTL_Close                 =2      ;
BF_SA_CTL_GetProperty_i32      = 3      ;
BF_SA_CTL_GetProperty_i64      = 4       ;
BF_SA_CTL_SetProperty_i32      = 5  ;
BF_SA_CTL_SetProperty_i64      = 6  ;
BF_SA_CTL_Reference            = 7;
BA_SA_CTL_OpenFirstDevice       = 8;

% Smaract constants:
SA_CTL_PKEY_POSITION = hex2dec('0x0305001D');

% List devices:
smaract.mcs_bridge(BF_LIST_DEVICES)

%% Get device (not working)

cDeviceName = 'network:sn:MCS2-00005705';
dHandle = smaract.mcs_bridge(BF_SA_CTL_Open, cDeviceName);


%% Get first device
dHandle = smaract.mcs_bridge(BA_SA_CTL_OpenFirstDevice);


%% Close device:
smaract.mcs_bridge(BF_SA_CTL_Close);

%% Reference
channel = 0;
smaract.mcs_bridge(BF_SA_CTL_Reference, dHandle, channel);


%% Get position:
channel = 0;
dPos = smaract.mcs_bridge(BF_SA_CTL_GetProperty_i64, dHandle, 0, SA_CTL_PKEY_POSITION);
fprintf('Channel %d is at position %0.3f\n', channel, dPos);

%% Set position:
channel = 0;
dPos = -1000000;
smaract.mcs_bridge(BF_SA_CTL_SetProperty_i64, dHandle, 0, SA_CTL_PKEY_POSITION, dPos);
