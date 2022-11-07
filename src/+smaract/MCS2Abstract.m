classdef MCSAbstract < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Abstract)
        
        %@param {uint32} absolute position to move to in nm
        goToPositionAbsolute(this, u32Channel, u32Position)
       
        findReferenceMark(this, u32Channel)
        
        l = getIsReferenced(this, u32Channel)
            
        l = getIsMoving(this, u32Channel)
           
        u32Position = getPosition(this, u32Channel)

        calibrate(this, u32Channel)

  
        
    end
    
    
end

