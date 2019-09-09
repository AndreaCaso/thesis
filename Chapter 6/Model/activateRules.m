function ruleIndices = activateRules(stimuli,counter,rules_set)
 
 if counter.trial_num <= 1
     ruleIndices = randi([1 length(rules_set)]);
     return;
 else
     if rand < 1
      last_stimuli = stimuli(counter.trial_num); %recently changed! 
     else
      last_stimuli = randi([1 length(rules_set)],2,1);
     end
 end
 
 for nn = 1:length(rules_set)
   ruleIndices(nn) = ~isempty(strfind(rules_set{nn},last_stimuli'));
 end
 
 ruleIndices = find(ruleIndices==1);
 

end
