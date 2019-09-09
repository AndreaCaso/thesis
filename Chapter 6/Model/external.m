% External excitation to the SMA schemas
% are due to the environmental trigger

% Basic excitation for all the motor schemas
o_EXT_SMA(:,tt) = weights.w_STIM_BASE + unifrnd(-extNoise,extNoise);

% Excitation for the sensorimotor schema from the environment
o_EXT_SMA(stimuli(counter.trial_num),tt) = weights.w_STIM_PRES + unifrnd(-extNoise,extNoise); 