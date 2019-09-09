%% Check if the response is correct

for nn = 1:num_circles
 counter.sma_value(nn) = sma.o_SMA(nn,tt); % Values of sensorimotor schemas
end
 counter.area_sma = counter.area_sma + counter.sma_value*counter.trial_num_time; % Area below motor schemas
 counter.trial_num_time_tot(counter.trial_num) = counter.trial_num_time;

% Race model: Are under the curve && minimum amount 
if any(counter.area_sma > area_threshold) && any(counter.sma_value > 0.5)
    
    counter.trial_num_time = 0; % Reset Counter (this calls for update counter.trial_num)
    counter.trial_num_timePFC = 0; % Reset Counter for PFC too
    
    sma.indexSMA = find(counter.sma_value == max(counter.sma_value));
    sma.indexSMA = sma.indexSMA(1);
    %fprintf('Circle %i selected\n', sma.indexSMA);
    counter.tt_trial_num(counter.trial_num) = tt; 
    responses(counter.trial_num) = sma.indexSMA;
    %sma.o_SMA(:,tt:timeSteps) = 0;
    
    counter.area_sma = zeros(1,num_circles); % Reset Counter(SMA)
    counter.area_pfc = zeros(1,num_rules); % Reset Counter(PFC)
    
    if responses(counter.trial_num) == stimuli(counter.trial_num+1,2) 
       counter.correct_counter_vector(counter.trial_num) = + 1;
       %fprintf('Correct\n');
    else
       counter.correct_counter_vector(counter.trial_num) = 0;
       %fprintf('Incorrect\n');
    end

%fprintf('Target appearing next is circle %i\n', stimuli(counter.trial_num+1,2) );
    
%% Bias the pFC in order to maximise reward.reward_value (correct answers)

biasPFC;
%biasSMA;

newRule = 1; 

end

