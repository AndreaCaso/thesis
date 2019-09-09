%% Run the whole program 

%clc;
%clear;
dbstop if error;  %debug if there's an error
warning off;

%% Initialise variables

loopNum = 2;

%initialiseBRX;  % INITIALISE MOVED TO THE BEGINNING of other files
externalGoal;

%% Start loops

for tt = 2:timeSteps-1
    
    updateTrial; 
    
    if counter.trial_num > num_trials
        break;
    end
    
    counter.trial_num_time = counter.trial_num_time + 1;
    counter.trial_num_timePFC = counter.trial_num_timePFC + 1;

    %% Environment signal
    
    external;     % excites the SMA schemas
                  % environmental trigger
    
    ruleWeights;  % sets the task-dependent
                  % weights from PFC to SMA
    
%% Brain Activity
for loop = 1:loopNum
       
       ctx_sma;
       ctx_pfc; 
         
       bg_pfc;
       bg_sma;
       
       thal_pfc;
       thal_sma;
       
end

%% Environment feedback

       checkCorrect;
      
end

calculate_performance;
                     
clear loopNum; clear loop; 
