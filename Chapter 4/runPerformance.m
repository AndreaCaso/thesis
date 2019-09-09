%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following script alters the value of beta_str 
% and beta_sma (equally for all the schemas) and record
% the value of the dependent variables in a structure 'performance'
% with fields beta_str, beta_sma, TE, PR, PE, SL, CC, NPE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc; 
%load('SIMYoungData.mat','performance');
performance = struct;

numTrials = 25; %set the total number of trials
beta_str_V = [0.3:0.05:0.7];
beta_sma_V = [0.1:0.05:0.9];

nnn = length(performance) + 1;
if nnn == 2
    nnn = 1;
end

%% Print initial time

fprintf('Simulating WSCT\n');
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'))

for str_c = beta_str_V
 for sma_c = beta_sma_V
  for runTrial = 1:numTrials

   fprintf('%1.0f of %1.0f',runTrial, numTrials);

   %% Run and register variables
   initialise;
   
   beta_sma = sma_c*(ones(1,4)); % 0.5
   beta_pfc = sma_c*(ones(1,3)); % 0.5
   
   beta_str_pfc = str_c*(ones(1,3));  %0.5 NORMAL DA
   beta_str_sma = str_c*(ones(1,4));  %0.5 NORMAL DA
 
   runWCST;
   performance(nnn).beta_str = str_c;
   performance(nnn).beta_sma = sma_c;
   performance(nnn).CC(runTrial) = catNum;
   performance(nnn).TE(runTrial) = TEerrors;
   performance(nnn).PE(runTrial) = sum(PEerrors);
   performance(nnn).PR(runTrial) = sum(PRerrors);
   performance(nnn).NPE(runTrial) = sum(NPEerrors);
   performance(nnn).SL(runTrial) = sum(SL5errors);

   save('SIMYoungData.mat','performance','-append');
   fprintf('.');
  end
   fprintf('completed\n');
   nnn = nnn + 1;
 end
 fprintf(' - ');
end

