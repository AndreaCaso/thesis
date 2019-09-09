% External excitation to the SMA schemas
% are due to the environmental trigger

%wExt  = 0.6  + envNoise*randn;  %0.5
             % this parameter is essential for
             % the excitation of motor schemas
             % from the environment
     
% basic excitation for all the motor schemas
o_EXT_SMA(:,tt) = extBase + envNoise*randn;

switch char(cardsDeck(trial).colour)
   
    case 'red' 
        o_EXT_SMA(1,tt) = wExt + envNoise*randn;
    case 'green'
        o_EXT_SMA(2,tt) = wExt + envNoise*randn;
    case 'yellow' 
        o_EXT_SMA(3,tt) = wExt + envNoise*randn;
    case 'blue'
        o_EXT_SMA(4,tt) = wExt + envNoise*randn;
        
end

switch cardsDeck(trial).itemnum 
   
    case 1
        o_EXT_SMA(1,tt) = wExt + envNoise*randn;
    case 2
        o_EXT_SMA(2,tt) = wExt + envNoise*randn;
    case 3
        o_EXT_SMA(3,tt) = wExt + envNoise*randn;
    case 4
        o_EXT_SMA(4,tt) = wExt + envNoise*randn;
        
end


switch char(cardsDeck(trial).shape)
   
    case 'triangle' 
        o_EXT_SMA(1,tt) = wExt + envNoise*randn;
    case 'star'
        o_EXT_SMA(2,tt) = wExt + envNoise*randn;
    case 'cross' 
        o_EXT_SMA(3,tt) = wExt + envNoise*randn;
    case 'circle'
        o_EXT_SMA(4,tt) = wExt + envNoise*randn;
        
end
