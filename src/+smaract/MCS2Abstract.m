classdef MCS2Abstract < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Abstract)
        
        %@param {uint32} absolute position to move to in nm
        goToPositionAbsolute(this, u32Channel, i64Position)
       
        findReferenceMark(this, u32Channel)

        l = getIsConnected(this)
        
        l = getIsReferenced(this, u32Channel)
            
        l = getIsMoving(this, u32Channel)
           
        i64Position = getPosition(this, u32Channel)

        calibrate(this, u32Channel)

        delete(this)

        disconnect(this)

        this = connect(this, cLocation)

        
    end
    
    
end

