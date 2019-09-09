
%% Update counter.trial_num
if (counter.trial_num_time == 0) && counter.trial_num <= lstim
    
    counter.trial_num = counter.trial_num + 1;
    performances.CCTrial(counter.trial_num) = performances.CC;
    %counter.tt_trial_num(counter.trial_num) = tt;
    
    %fprintf('Trial # %1i - Rule set %s - %1.0f corrects in a row\n', counter.trial_num, category(performances.CC),counter.correct_counter); 
    %fprintf(fileID, 'Trial # %1i\n', counter.trial_num); 
        
end
  
counter.correct_prop = sum(counter.correct_counter_vector)/counter.trial_num;
