%% Check if the card is correct

counter.sma_value = [sma.o_SMA(1,tt) sma.o_SMA(2,tt) sma.o_SMA(3,tt) sma.o_SMA(4,tt)]; % Values of motor schemas
counter.area_sma = counter.area_sma + counter.sma_value*counter.trial_num_time; % Area below motor schemas
counter.trial_num_time_tot(counter.trial_num) = counter.trial_num_time;

% Race model: Are under the curve && minimum amount 
if any(counter.area_sma > thresholds.dynamic(timeSteps)) && any(counter.sma_value > 0.5)
    
    counter.trial_num_time = 0; % Reset Counter (this calls for update counter.trial_num)
    counter.trial_num_timePFC = 0; % Reset Counter for PFC too
    %[ii,jj] = find(SMAdrift==max(max(SMAdrift)));
    %sma.indexSMA = ii(1); % Select motor schema
    
    sma.indexSMA = find(counter.sma_value == max(counter.sma_value));
    sma.indexSMA = sma.indexSMA(1);
    counter.tt_trial_num(counter.trial_num) = tt; 
    sma.o_SMA(:,tt:timeSteps) = 0;
    
    counter.area_sma = [0 0 0 0]; % Reset Counter(SMA)
    counter.area_pfc = [0 0 0]; % Reset Counter(PFC)
    
    chosenCard(counter.trial_num) = sma.indexSMA;
    
    if strcmp(char(stimuli(counter.trial_num).colour),char(cardsTable(sma.indexSMA).colour));
            counter.feature_trial(counter.trial_num) = strcat(counter.feature_trial(counter.trial_num),'c');
            
            %fprintf('Colours in the target and stimulus match. \n');
            %fprintf(fileID, '[TIME = %4.0d] Colours in the target and stimulus match. %1d correct\n',tt, sum(counter.correct_counter.trial_nums));
   
    end
    
    if stimuli(counter.trial_num).itemnum == cardsTable(sma.indexSMA).itemnum;
           counter.feature_trial(counter.trial_num) = strcat(counter.feature_trial(counter.trial_num),'n');
           
           %fprintf('Numbers in the target and stimulus match. \n');
           %fprintf(fileID, '[TIME = %4.0d] Numbers in the target and stimulus match. %1d correct \n', tt, sum(counter.correct_counter.trial_nums));
    end
       
    if strcmp(char(stimuli(counter.trial_num).shape),char(cardsTable(sma.indexSMA).shape));
            counter.feature_trial(counter.trial_num) = strcat(counter.feature_trial(counter.trial_num),'s');
            
            %fprintf('Shapes in the target and stimulus match. \n');
            %fprintf(fileID, '[TIME = %4.0d] Shapes in the target and stimulus match. %1d correct \n', tt, sum(counter.correct_counter.trial_nums));
            
    end
    
    if isequal(counter.feature_trial(counter.trial_num), {[]})
        
        counter.feature_trial(counter.trial_num) = strcat(counter.feature_trial(counter.trial_num),'x');
        %fprintf('No feature matches. \n');
        %fprintf(fileID, '[TIME = %4.0d] No feature matches. %1d correct \n', tt, sum(counter.correct_counter.trial_nums));
          
    end
    
    %% Now check if the answer is correct  
   
    commonFeature = strfind(counter.feature_trial(counter.trial_num),category(performances.CC));

    if ~isempty(commonFeature{1})
        
        counter.correct_counter_vector(counter.trial_num) = 1;
        counter.correct_counter = counter.correct_counter + 1;
        %fprintf('Correct response. Total correct responses %1.0f\n', sum(counter.correct_counter.trial_nums));
        %fprintf(fileID, '[TIME = %4.0d] Correct response. Total correct responses %1.0f \n', tt, sum(counter.correct_counter.trial_nums));
           
    else
        
        counter.correct_counter_vector(counter.trial_num) = 0;   %redundant
       
        counter.correct_counter = 0; %reset the counter
        %fprintf('Incorrect response. \n');
        %fprintf(fileID, '[TIME = %4.0d] Incorrect response. Total correct responses %1.0f \n', tt, sum(counter.correct_counter.trial_nums));
        
    end


%% Bias the pFC in order to maximise reward.reward_value.reward.reward_value_value (correct answers)

biasPFC;

%% Change the rule if there are too many correct answers in a row

if performances.CC < 19 && counter.trial_num >= 10 
    if counter.correct_counter == 10
         
         counter.correct_counter = 0; % reset counter in a row 
         performances.CC = performances.CC + 1; % one category ticked off
         
         %fprintf(fileID, 'Change of rule: Category %1.0f\n', performances.CC);  
         %fprintf('Change of rule: Category %1.0f\n', performances.CC);
      
    end
end

end

