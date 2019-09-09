% Reset PFC to SMA weights (TO-FROM)
 
for nn = 1:num_rules
 counter.pfc_value(nn) = pfc.o_PFC(nn,tt-1); % Values of motor schemas
end
counter.area_pfc = counter.area_pfc + counter.pfc_value*counter.trial_num_time; % Area below motor schemas

actW = 0;
if any(counter.area_pfc > area_threshold) && any(counter.pfc_value > 0.5)
 pfc.indexPFC(counter.trial_num) = find(counter.pfc_value == max(counter.pfc_value), 1, 'last' );
 actW = weights.w_RULE_PRES;
end

applyRule();
