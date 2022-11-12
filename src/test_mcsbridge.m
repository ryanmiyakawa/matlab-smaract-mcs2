BF_LIST_DEVICES                 =0    ;
BF_SA_CTL_Open                  =1     ;
BF_SA_CTL_Close                 =2      ;
BF_SA_CTL_GetProperty_i32      = 3      ;
BF_SA_CTL_GetProperty_i64      = 4       ;
BF_SA_CTL_SetProperty_i32      = 5  ;
BF_SA_CTL_SetProperty_i64      = 6  ;
BF_SA_CTL_Reference            = 7;
BA_SA_CTL_OpenFirstDevice       = 8;
BF_IS_REFERENCED = 9;
BF_IS_CHANNEL_ACTIVE = 10;

% Smaract constants:
SA_CTL_PKEY_POSITION = hex2dec('0x0305001D');

%%
% List devices:
smaract.mcs_bridge(BF_LIST_DEVICES)

%% OPen device by name 

cDeviceName = 'network:sn:MCS2-00005705';
[dResult, dHandle] = smaract.mcs_bridge(BF_SA_CTL_Open, cDeviceName);

%% Set CL Frequency
dFrequency = 6000;
u32Channel = 0;
u64Property = hex2dec('0x0305002F');
dResult =  smaract.mcs_bridge(...
                    BF_SA_CTL_SetProperty_i32, ...
                    dHandle, ...
                    u32Channel, ...
                    u64Property, ...
                    dFrequency) 


%% Reference
channel = 0;
dResult = smaract.mcs_bridge(BF_SA_CTL_Reference, dHandle, channel);

%% Check is referenced
channel = 0;
[dResult, lIsReferenced] = smaract.mcs_bridge(BF_IS_REFERENCED, dHandle, channel)

%% Check channel active:
channel = 0;
[dResult, lIsActive] = smaract.mcs_bridge(BF_IS_CHANNEL_ACTIVE, dHandle, channel)

%% Get position:
channel = 0;
[dResult, dPos] = smaract.mcs_bridge(BF_SA_CTL_GetProperty_i64, dHandle, 0, SA_CTL_PKEY_POSITION);
fprintf('Channel %d is at position %0.3f\n', channel, dPos);

%% Set position:
channel = 0;
dPos = -1000000;
dResult = smaract.mcs_bridge(BF_SA_CTL_SetProperty_i64, dHandle, 0, SA_CTL_PKEY_POSITION, dPos);


%% Close device:
dResult = smaract.mcs_bridge(BF_SA_CTL_Close, dHandle);

