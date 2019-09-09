%% Run the whole program

%clc;
%clear;
%tic;
dbstop if error;  %debug if there's an error
warning off;
%% Initialise variables

%fileID = fopen('logWCST.txt','w');
loopNum = 2;

%initialise;  % INITIALISE MOVED TO THE BEGINNING of other files

externalGoal;

%% Start loops

for tt = 2:timeSteps-1
    
    updateTrial; 
    
    if trial > 64 || catNum > 7
        break;
    end
    
    showCard; %shows the card
   
    decCounter = decCounter + 1;

    %% Environment signal
    
    external; % excites the SMA schemas
              % environmental trigger
       
    ruleWeights; % sets the task-dependent
                % weights from PFC to SMA
     
    
    
%% Brain Activity
for loop = 1:loopNum
       
       sma; 
       pfc; 
         
       basalGangliaPFC;
       basalGangliaMotor;
       
       thalamusPFC
       thalamusMotor;
       
end

%% Environment feedback
        
        checkCorrect;
       
end 

errorTypesFinal;

catNum = catNum - 1; %transform the current category...
                     %into the completed category
%{
                     
fprintf('\nCorrect trials: %1.0d out of %d. (%1.1f percent)\n',sum(correctTrial),length(correctTrial),correctProportion*100);
fprintf('\nCategories completed: %1.0d out of 6\n',catNum);

fprintf('Total Errors (TE): %2.0d\n',TEerrors);
fprintf('Set Loss Errors (Heaton) %1.0f\n', sum(SL5errors)); 
fprintf('Perseverative errors %2.0d\n', sum(PEerrors)); 
fprintf('Non-perseverative errors %2.0d\n', NPEerrors); 

fprintf('\nLearning to learn %1.1f percent\n', LTL*100); 
fprintf('Trials to first category %1.0f\n', TFC);

fprintf('\nTotal time taken %1.0d\n', tt); 
fprintf('Time for decision %3.0f %s %2.0f\n', mean(decCounterTot), char(177), std(decCounterTot)); 

%% Plot schemas
plotOutput;
%plotOutputSolo;
%fclose(fileID);

%% Analyse performances
%elapsedSec = toc;
%fprintf('\nTime elapsed: %1.1f seconds (%1.2f minutes) \n', elapsedSec, elapsedSec/60);
%clear elapsedSec;
%beep;

 %}
                      
                  