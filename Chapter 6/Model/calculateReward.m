% It return the rewarded rules coefficient given a memory 
% parameter. For example, if the rule 

function rews = calculateReward(stimuli,counter,rules_set,reward)
 
 last_stimuli = [0 0]; % first component is the last stimulus
 
 if counter.trial_num >= 1
    last_stimuli(2) = stimuli(counter.trial_num); % last on the second pos
 end 
 if counter.trial_num >= 2
    last_stimuli(1) = stimuli(counter.trial_num - 1); % second last on the first pos
 end
 
 rews = (-1 + reward.reward_mod)*ones(1,length(rules_set));
  
 % Third last stimulus match receives +1 - 2*mem_par
 for set_num = 1:length(rules_set)
  chunks = into_chunks(rules_set{set_num},2);
   for chunk_num = 1:length(chunks)
    is_match = ~isempty(strfind(chunks{chunk_num},last_stimuli));
    if is_match
     rews(set_num) = (+1 - reward.reward_mod);  
    end
   end
 end
 
end
