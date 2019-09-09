%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file bias the prefrontal cortex in two different ways:
% In the cortical schemas and in the basal ganglia unit
% The script is run each timeStep 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

averaging_int = (tt - counter.tt_trial_num(counter.trial_num)+1):tt;
pfc.actPFC(counter.trial_num,:) = mean(pfc.o_PFC(:,averaging_int),2);
mem_weight = 2.^(-repmat((counter.trial_num:-1:1)',[1 3]));
pfc.pred_act(counter.trial_num,:) = sum(pfc.actPFC(1:counter.trial_num,:).*mem_weight); % predicted activation

match_sgn = [-1 -1 -1];

if strcmp(char(stimuli(counter.trial_num).colour),char(cardsTable(sma.indexSMA).colour))
    match_sgn(1) = +1; 
end
if stimuli(counter.trial_num).itemnum == cardsTable(sma.indexSMA).itemnum  
    match_sgn(2) = +1;
end
if strcmp(char(stimuli(counter.trial_num).shape),char(cardsTable(sma.indexSMA).shape))
    match_sgn(3) = +1;
end

correct_sgn = sign(counter.correct_counter_vector(counter.trial_num) - 0.1); % +1 or -1(incorrect)

reward.reward_value(counter.trial_num,:) = correct_sgn*match_sgn;

reward.TDV(counter.trial_num,:) = reward.reward_value(counter.trial_num,:) - pfc.actPFC(counter.trial_num,:) + reward.discount_TDV*pfc.pred_act(counter.trial_num,:); 
pfc.entropyPFC(counter.trial_num,:) = calculate_entropy(pfc.actPFC(counter.trial_num,:));

satfnc.alpha_pfc = 5 - 20*epsilon.eps_pfc*log(pfc.entropyPFC(counter.trial_num,:))*(1 + pfc.pfcNoise(counter.trial_num));
% satfnc.alpha_pfc = satfnc.alpha_pfc*(1 + pfc.pfcNoise(counter.trial_num)); % add noise to update
satfnc.alpha_pfc(satfnc.alpha_pfc<5)= 5;
satfnc.alpha_pfc(satfnc.alpha_pfc>25)= 25;

satfnc.beta_str_pfc =  satlin(satfnc.beta_str_pfc - epsilon.eps_str.*reward.TDV(counter.trial_num,:).*(1 + pfc.pfcNoise(counter.trial_num)) );

