classdef MCS2 < handle %smaract.MCSAbstract2

    properties (Constant)

    end

    properties 
        u64SAConstants = struct()
        u64SAErrorConstants = struct()
    end
    
    properties (Access = protected)
        cLocation = 'network:sn:MCS2-00005705'

        lConnected = false
        dNumChannels = 1
        u32CLFrequency = 6000
        u32MaxHoldTime = -1

        dVelocity = 1000000000
        dAcceleration = 1000000000
       
        dHandle = -1 % {uint 32 1x1} a libpointer is passed into SA_OpenSystem and populated with a uint32
     
        lDebug = true
    end
    
    methods
        function this = MCS2(varargin)
            
            % Define constants from bridge header file:
            this = this.defineSAConstants();

            for k = 1 : 2: length(varargin)
                this.msg(sprintf('passed in %s', varargin{k}));
                if this.hasProp( varargin{k})
                    this.msg(sprintf('settting %s', varargin{k}));
                    this.(varargin{k}) = varargin{k + 1};
                end
            end
        end
        
        %@param {uint32} absolute position to move to in pm
        function dResult = goToPositionAbsolute(this, u32Channel, i64Position)
        
             if (this.getIsMoving(u32Channel))
                 return
             end
              
            dResult = smaract.mcs_bridge(this.u64SAConstants.BF_SA_CTL_Move, this.dHandle, u32Channel, i64Position);      
            this.printStatusOfError(dResult);
            
        end
        
        
        function calibrate(this, u32Channel)
           if (u32Channel == -1)
                for k = 1:this.dNumChannels
                    u32Channel = k - 1;
                    this.calibrate(u32Channel)
                end
                return
            end
            dResult = smaract.mcs_bridge(this.u64SAConstants.BF_SA_CTL_Calibrate, this.dHandle, u32Channel);        
            this.printStatusOfError(dResult);
        end

        %@param {uint32} channel.  Use -1 for all channels
        function findReferenceMark(this, u32Channel)
            if (u32Channel == -1)
                for k = 1:this.dNumChannels
                    u32Channel = k - 1;
                    this.findReferenceMark(u32Channel)
                end
                return
            end
            dResult = smaract.mcs_bridge(this.u64SAConstants.BF_SA_CTL_Reference, this.dHandle, u32Channel);        
            this.printStatusOfError(dResult);
        end

        function l = getIsConnected(this)
            l = this.lConnected;
        end

       

        %@param {uint32} channel.  Defaults to all channels, or pass -1 for all channels
        function l = getIsReferenced(this, u32Channel)
            if (~this.lConnected)
                l = false;
                return
            end

            if (u32Channel == -1 || nargin == 1)
                ls = zeros(1, this.dNumChannels);
                for k = 1 : this.dNumChannels
                    u32Channel = k - 1;
                    ls(k) = this.getIsReferenced(u32Channel);
                end
                l = all(ls);
                return
            end
            [dResult, l] = smaract.mcs_bridge(this.u64SAConstants.BF_IS_REFERENCED, this.dHandle, u32Channel);
            this.printStatusOfError(dResult);            
        end

        function stop(this, u32Channel)
            dResult = smaract.mcs_bridge(this.u64SAConstants.BF_SA_SA_CTL_Stop, this.dHandle, u32Channel);
            this.printStatusOfError(dResult);  
        end
        
        function l = getIsMoving(this, u32Channel)
            [dResult, l] = smaract.mcs_bridge(this.u64SAConstants.BF_IS_CHANNEL_ACTIVE, this.dHandle, u32Channel);
            this.printStatusOfError(dResult);            
        end
        
        % returns the position of the sensor in nm
        function i64Position = getPosition(this, u32Channel)
            if (~this.getIsReferenced(u32Channel))
                i64Position = 0;
                return
            end
            [dResult, i64Position] = this.getPropertyI64(u32Channel, this.u64SAConstants.SA_CTL_PKEY_POSITION);
            this.printStatusOfError(dResult);            
        end
        

        
        function delete(this)
            this.closeSystem()
        end

        function disconnect(this)
            this.closeSystem()
        end


        
        function this = connect(this, cLocation)

            if (this.lConnected)
                return;
            end

            if (nargin == 2)
                this.cLocation = cLocation;
            end

            this = this.openSystem();

            for k = 1:this.dNumChannels
                uint32ChannelNumber = uint32(k - 1);

                % Set closed loop frequency
                this.msg(sprintf('Initializing closed loop frequency on channel %d', uint32ChannelNumber))
                dStatus = this.setPropertyI32(uint32ChannelNumber, ...
                    this.u64SAConstants.SA_CTL_PKEY_MAX_CL_FREQUENCY, this.u32CLFrequency);


                % Set hold time
                this.msg(sprintf('Initializing hold time on channel %d', uint32ChannelNumber))
                dStatus = this.setPropertyI32(uint32ChannelNumber, ...
                    this.u64SAConstants.SA_CTL_PKEY_HOLD_TIME, -1);

                % Set Move mode
                this.msg(sprintf('Initializing move mode on channel %d', uint32ChannelNumber))
                dStatus = this.setPropertyI32(uint32ChannelNumber, ...
                    this.u64SAConstants.SA_CTL_PKEY_MOVE_MODE,  this.u64SAConstants.SA_CTL_MOVE_MODE_CL_ABSOLUTE);

                % Set Velocity
                this.msg(sprintf('Initializing velocity on channel %d', uint32ChannelNumber))
                dStatus = this.setPropertyI64(uint32ChannelNumber, ...
                    this.u64SAConstants.SA_CTL_PKEY_MOVE_VELOCITY, this.dVelocity);

                % Set Acceleration
                this.msg(sprintf('Initializing acceleration on channel %d', uint32ChannelNumber))
                dStatus = this.setPropertyI64(uint32ChannelNumber, ...
                    this.u64SAConstants.SA_CTL_PKEY_MOVE_ACCELERATION, this.dAcceleration);

                % Set Referencing options
                this.msg(sprintf('Initializing referencing options on channel %d', uint32ChannelNumber))
                dStatus = this.setPropertyI32(uint32ChannelNumber, ...
                    this.u64SAConstants.SA_CTL_PKEY_REFERENCING_OPTIONS, 0);

                % Set Referencing options
                this.msg(sprintf('Initializing calibration options on channel %d', uint32ChannelNumber))
                dStatus = this.setPropertyI32(uint32ChannelNumber, ...
                    this.u64SAConstants.SA_CTL_PKEY_CALIBRATION_OPTIONS, 0);

            end
        end
    end
    
    methods (Access = protected)

        function this = defineSAConstants(this)
            cBridgeHeaderPath = fullfile(fileparts(mfilename('fullpath')), 'include',  'mcs_bridge_constants.h');
            fid = fopen(cBridgeHeaderPath, 'r');

            % read each line:
            tline = fgetl(fid);
            while ischar(tline)
                % Match define statments like:  '#define BF_LIST_DEVICES                 0'
                tokens = regexp(tline, '#define\s*([\w]+)\s*(\d+)', 'tokens');
                if (~isempty(tokens))
                    eval(sprintf('this.u64SAConstants.%s = %s;', tokens{1}{1}, tokens{1}{2}));
                end

            %     disp(tline)
                tline = fgetl(fid);
            end

            fclose(fid);

            u64SAConstantsPath = fullfile(fileparts(mfilename('fullpath')), '..', '..', 'SDK-MCS2', 'include',  'SmarActControlConstants.h');
            fid = fopen(u64SAConstantsPath, 'r');

            % read each line:
            tline = fgetl(fid);
            while ischar(tline)
                % Match define statments like:  '#define BF_LIST_DEVICES                 0xffff'
                tokens = regexp(tline, '#define\s*([\w]+)\s*(0x[0-9a-fA-F]+)', 'tokens');
                if (~isempty(tokens))

                    % Separate out error codes:
                    if (strncmp(tokens{1}{1}, 'SA_CTL_ERROR_', 13))
                        eval(sprintf('this.u64SAErrorConstants.%s = %s;', tokens{1}{1}, tokens{1}{2}));
                    else
                        eval(sprintf('this.u64SAConstants.%s = this.hex2uint64(''%s'');', tokens{1}{1}, tokens{1}{2}));
                    end
                else
                    tokens = regexp(tline, '#define\s*([\w]+)\s*(\d+)', 'tokens');
                    if (~isempty(tokens))
                        eval(sprintf('this.u64SAConstants.%s = %s;', tokens{1}{1}, tokens{1}{2}));
                    end
                end

                tline = fgetl(fid);
            end
            fclose(fid);
        end
       
        function printStatusOfMovement(this, u64Status)
       
            if (~this.lDebug) 
                return; 
            end

            % Loop through error struct and find corrsponding error code
            cFieldNames = fieldnames(this.u64SAConstants);
            for k = 1:length(cFieldNames)
                if (this.u64SAErrorConstants.(cFieldNames{k}) == u64Status)
                    this.msg(sprintf('Status of movement: %s', cFieldNames{k}));
                    return;
                end
            end

            fprintf('Status of movement: %u, %s\n', u32Status, c);
        end
        

        
        function printStatusOfError(this, u64Status)
            
            if (~this.lDebug) 
                return; 
            end

            if (u64Status == this.u64SAErrorConstants.SA_CTL_ERROR_NONE)
                return;
            end

            % Loop through error struct and find corrsponding error code
            cFieldNames = fieldnames(this.u64SAErrorConstants);
            for k = 1:length(cFieldNames)
                if (this.u64SAErrorConstants.(cFieldNames{k}) == u64Status)
                    this.msg(sprintf('Error: %s', cFieldNames{k}));
                    return;
                end
            end
            
        end

        % Convert hex to uint64
        function y = hex2uint64(this, x)

            if (strcmp(x(1:2), '0x'))
                x = x(3:end);
            end
            % Works similar to HEX2DEC but does not support multiple rows.
                
           
            v=zeros(1,16);
            y=uint64(0);
            
            nibble=0;
            
            for i=length(x):-1:1
                v=uint64(hex2dec(x(i)));
                v=bitshift(v,nibble);
                y=bitor(y,v);
                nibble=nibble+4;
            end
        end
        
        
        function l = hasProp(this, c)

            l = false;
            if ~isempty(findprop(this, c))
                l = true;
            end

        end


        function msg(this, cMsg)
            fprintf('smaract.MCS2 %s\n', cMsg);
        end

        function dStatus = setPropertyI32(this, u32Channel, u64Property, i32Val)
            dStatus = smaract.mcs_bridge(...
                this.u64SAConstants.BF_SA_CTL_SetProperty_i32, ...
                this.dHandle, ...
                u32Channel, ...
                u64Property, ...
                i32Val);
            this.printStatusOfError(dStatus);
        end

        function dStatus = setPropertyI64(this, u32Channel, u64Property, i64Val)
            dStatus = smaract.mcs_bridge(...
                    this.u64SAConstants.BF_SA_CTL_SetProperty_i64, ...
                    this.dHandle, ...
                    u32Channel, ...
                    u64Property, ...
                    i64Val); 
            this.printStatusOfError(dStatus);
        end

        function [dStatus, i32Val] = getPropertyI32(this, u32Channel, i32Property)
            [dStatus, i32Val] = smaract.mcs_bridge(...
                    this.u64SAConstants.BF_SA_CTL_GetProperty_i32, ...
                    this.dHandle, ...
                    u32Channel, ...
                    i32Property); 
            this.printStatusOfError(dStatus);
        end

        function [dStatus, i64Val] = getPropertyI64(this, u32Channel, u64Property)
            [dStatus, i64Val] = smaract.mcs_bridge(...
                    this.u64SAConstants.BF_SA_CTL_GetProperty_i64, ...
                    this.dHandle, ...
                    u32Channel, ...
                    u64Property); 
            this.printStatusOfError(dStatus);
        end
        
        function u32StatusOfMovement = getStatusOfMovement(this, u32Channel)
            u32StatusOfMovement = -1;
        end

        function this = closeSystem(this)

            dStatus = smaract.mcs_bridge(this.u64SAConstants.BF_SA_CTL_Close);
            if dStatus == this.u64SAErrorConstants.SA_CTL_ERROR_NONE
                this.msg('device closed successfully.');
                this.lConnected = false;
            else
                this.msg('error closing device.');
                this.printStatusOfError(dStatus);
            end

        end
        
        function this = openSystem(this)
            

            [dStatus, this.dHandle] = smaract.mcs_bridge(this.u64SAConstants.BF_SA_CTL_Open, this.cLocation);
        
            if dStatus == this.u64SAErrorConstants.SA_CTL_ERROR_NONE
                this.msg('device opened successfully.');
                this.lConnected = true;
            else
                this.msg('error opening device.');
                this.printStatusOfError(dStatus);
            end
                        
            
        end

        
    end
    
end

