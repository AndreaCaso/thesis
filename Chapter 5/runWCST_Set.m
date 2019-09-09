%% Run WCST simulation in healthy 
%% young subjects % Score by Heaton
clear; clc;

%% Define number of trials
numTrials = 25; %set the total number of trials

%% Print initial time

fprintf('Simulating WSCT\n');
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))

%% Draw first figure

figure; %PlotSIMvsNP;
%drawnow;

for runTrial = 1:numTrials

fprintf('%1.0f of %1.0f...',runTrial, numTrials);

%% Run and register variables

initialise;
runWCST;

catNumYoungSim(runTrial) = catNum;
TEYoungSim(runTrial) = TEerrors;
PEYoungSim(runTrial) = sum(PEerrors);
PRYoungSim(runTrial) = sum(PRerrors);
NPEYoungSim(runTrial) = sum(NPEerrors);
SLYoungSim(runTrial) = sum(SL5errors);

fprintf('completed\n');

%% Update the plot everytime the trial is a multiple of the total

    %if mod(numTrials, runTrial) == 0
    save('SIMYoungData.mat','catNumYoungSim','PEYoungSim','PRYoungSim','NPEYoungSim','SLYoungSim','TEYoungSim','-append');
   % clf; PlotSIMvsNP;
   % set(gcf,'name',['Figure ',num2str(runTrial)],'numbertitle','off')
   % drawnow;    %udpates the current figure;
    %end

end

%% Final print and save

fprintf('Simulation WSCT completed\n');
fprintf('Ending time: %s\n', datestr(now,'HH:MM'))

fprintf('\n'); 
fprintf('Categories completed (Heaton) in %1.0f trials: %1.0f (SD = %1.1f), VarCoeff %1.2f\n', numTrials, mean(catNumYoungSim), std(catNumYoungSim), std(catNumYoungSim)/mean(catNumYoungSim));
fprintf('Total Errors (Heaton) in %1.0f trials: %1.0f (SD = %1.1f), VarCoeff %1.2f\n', numTrials, mean(TEYoungSim), std(TEYoungSim), std(TEYoungSim)/mean(TEYoungSim) );
fprintf('Perseverative Responses (Heaton) in %1.0f trials: %1.0f (SD = %1.1f), VarCoeff %1.2f\n', numTrials, mean(PRYoungSim), std(PRYoungSim), std(PRYoungSim)/mean(PRYoungSim) );
fprintf('Perseverative Errors (Heaton) in %1.0f trials: %1.0f (SD = %1.1f), VarCoeff %1.2f\n', numTrials, mean(PEYoungSim), std(PEYoungSim), std(PEYoungSim)/mean(PEYoungSim) );
fprintf('Non-perseverative Errors (Heaton) in %1.0f trials: %1.0f (SD = %1.1f), VarCoeff %1.2f\n', numTrials, mean(NPEYoungSim), std(NPEYoungSim), std(NPEYoungSim)/mean(NPEYoungSim) );
fprintf('Set Loss Errors (Heaton) in %1.0f trials: %1.0f (SD = %1.1f), VarCoeff %1.2f\n', numTrials, mean(SLYoungSim), std(SLYoungSim), std(SLYoungSim)/mean(SLYoungSim) );
fprintf('\n');

YoungSIMdata = [TEYoungSim' PRYoungSim' PEYoungSim' SLYoungSim' catNumYoungSim' NPEYoungSim'];

save('SIMYoungData.mat','YoungSIMdata','catNumYoungSim','PEYoungSim','PRYoungSim','NPEYoungSim','SLYoungSim','TEYoungSim','-append');
        
clf; PlotSIMvsNP;

beep;