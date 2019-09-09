% External excitation to the SMA schemas
% are due to the environmental trigger

%weights.w_STIM_PRES  = 0.6  + envNoise*randn;  %0.5
             % this parameter is essential for
             % the excitation of motor schemas
             % from the environment
     
% basic excitation for all the motor schemas
o_EXT_SMA(:,tt) = weights.w_STIM_BASE + unifrnd(-extNoise,extNoise);

switch char(stimuli(counter.trial_num).colour)
   
    case 'red' 
        o_EXT_SMA(1,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 'green'
        o_EXT_SMA(2,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 'yellow' 
        o_EXT_SMA(3,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 'blue'
        o_EXT_SMA(4,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
        
end

switch stimuli(counter.trial_num).itemnum 
   
    case 1
        o_EXT_SMA(1,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 2
        o_EXT_SMA(2,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 3
        o_EXT_SMA(3,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 4
        o_EXT_SMA(4,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
        
end


switch char(stimuli(counter.trial_num).shape)
   
    case 'triangle' 
        o_EXT_SMA(1,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 'star'
        o_EXT_SMA(2,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 'cross' 
        o_EXT_SMA(3,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
    case 'circle'
        o_EXT_SMA(4,tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise);
        
end
