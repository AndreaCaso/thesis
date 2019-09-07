%% Initialise all the three cognitive schemas

for ss = 1:num_rules
 o_EXT_PFC(ss,1:timeSteps) = extPFC + unifrnd(-extNoise,extNoise);
end