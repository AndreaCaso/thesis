%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file bias the prefrontal cortex in two different ways:
% In the cortical schemas and in the basal ganglia unit
% (for the COGNITIVE SCHEMAS)
% The script is run each timeStep 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate the time interval 
if counter.trial_num > 1
    tt_int = (tt - counter.trial_num_time_tot(counter.trial_num-1)) : tt;
else
    tt_int = 1:tt;
end

% Calculate the mean PFC activation
pfc.actPFC(counter.trial_num,:) = mean(pfc.o_PFC(:,tt_int),2)';

% Calculate the memory weights for this activation
mem_weight = 2.^(-repmat((counter.trial_num:-1:1)',[1 num_rules]));

% Calculate the predicted activation
pfc.pred_act(counter.trial_num,:) = sum(pfc.actPFC(1:counter.trial_num,:).*mem_weight); % predicted activation

% Generally, rewards for all the cog schemas are assigned to minus 1
match_sgn = -1*ones(1,num_rules); 

% Rule indices are calculated with activation pattern
% For the last two stimuli
reward.reward_value(counter.trial_num,:) = calculateReward(stimuli(:,2),counter,rules_set);
 
reward.TDV(counter.trial_num,:) = reward.reward_value(counter.trial_num,:) - pfc.actPFC(counter.trial_num,:) + reward.discount_TDV*pfc.pred_act(counter.trial_num,:); 
pfc.entropyPFC(counter.trial_num,:) = calculate_entropy(pfc.actPFC(counter.trial_num,:));
 
satfnc.alpha_pfc = 5 - 50*epsilon.eps_pfc*log(pfc.entropyPFC(counter.trial_num,:));
satfnc.alpha_pfc = satfnc.alpha_pfc*(1 + pfc.pfcNoise(counter.trial_num));
    
satfnc.beta_str_pfc = satlin(satfnc.beta_str_pfc - epsilon.eps_str.*reward.TDV(counter.trial_num,:));

for tx = tt:timeSteps
  satfnc.beta_str_pfc_hist(:,tx) = satfnc.beta_str_pfc;
end
