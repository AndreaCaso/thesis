
%% Update trial
if (decCounter == 0) && trial <= 64
            
    trial = trial + 1;
    catNumTrial(trial) = catNum;
    
    %fprintf('Trial # %1i - Rule set %s - %1.0f corrects in a row\n', trial, category(catNum),correctCounter); 
    %fprintf(fileID, 'Trial # %1i\n', trial); 
    
end 

correctProportion = sum(correctTrial)/trial;
