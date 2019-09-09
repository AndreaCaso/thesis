%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file bias the prefrontal cortex in two different ways:
% In the cortical schemas and in the basal ganglia unit
% (for the MOTOR SCHEMAS)
% The script is run each timeStep 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate the time interval 
if counter.trial_num > 1
    tt_int = (tt - counter.trial_num_time_tot(counter.trial_num-1)) : tt;
else
    tt_int = 1:tt;
end

% Calculate the mean PFC activation
sma.actSMA(counter.trial_num,:) = mean(sma.o_SMA(:,tt_int),2)';

% Calculate the memory weights for this activation
mem_weight = 2.^(-repmat((counter.trial_num:-1:1)',[1 num_circles]));

% Calculate the predicted activation
sma.pred_act(counter.trial_num,:) = sum(sma.actSMA(1:counter.trial_num,:).*mem_weight); % predicted activation
        
% Rule indices are calculated with activation pattern
% For the last two stimuli
if counter.trial_num > 1
    ruleIndices = stimuli(counter.trial_num-1:counter.trial_num,2);
else
    ruleIndices = stimuli(counter.trial_num,2);
end

match_sgn = 0*ones(1,num_circles); 
match_sgn(ruleIndices) = +1;

% Assign a correct sign to the answer: +1 (correct) or -1(incorrect)
%correct_sgn = sign(counter.correct_counter_vector(counter.trial_num) - 0.1); 
reward.reward_value_sma(counter.trial_num,:) = match_sgn;
 
reward.TDV_sma(counter.trial_num,:) = reward.reward_value_sma(counter.trial_num,:) - sma.actSMA(counter.trial_num,:) + reward.discount_TDV*sma.pred_act(counter.trial_num,:); 
sma.entropySMA(counter.trial_num,:) = calculate_entropy(sma.actSMA(counter.trial_num,:));
 
satfnc.alpha_sma = 5 - 20*epsilon.eps_pfc*log(sma.entropySMA(counter.trial_num,:));
satfnc.alpha_sma = satfnc.alpha_sma*(1 + pfc.pfcNoise(counter.trial_num));

satfnc.beta_str_sma = satlin(satfnc.beta_str_sma - 0.1*epsilon.eps_str.*reward.TDV_sma(counter.trial_num,:));

for tx = tt:timeSteps
  satfnc.beta_str_sma_hist(:,tx) = satfnc.beta_str_sma;
end
