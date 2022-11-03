classdef MCSVirtual < smaract.MCSAbstract
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    
    properties (Access = private)
        u32Positions = zeros(1, 5);
        lIsReferenced = false(1, 5);
    end
    
    methods 
        
        function this = MCSVirtual()
            
            
        end
        
        %@param {uint32} absolute position to move to in nm
        function goToPositionAbsolute(this, u32Channel, u32Position)
            this.u32Positions(u32Channel + 1) = u32Position;
        end
        
       
        function findReferenceMark(this, u32Channel)
            this.lIsReferenced(u32Channel + 1) = true;
        end
        
        
        function l = getIsReferenced(this, u32Channel)
            l = this.lIsReferenced(u32Channel + 1);
        end
            
            
        function l = getIsMoving(this, u32Channel)
            l = false;
        end
           
        function u32Position = getPosition(this, u32Channel)
            u32Position = this.u32Positions(u32Channel + 1);
        end
        
    end
    
    
end

