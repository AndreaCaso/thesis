%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the simulation for the WCST 
% changing the self-excitation parameter for Wsma and Wpfc
% runWCST_Wsmapfc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
% Results are stored in a structure dependent_vars
% with a field for every dependent variable
% Instances are recorded in a AxBxC matrix
% where A is the variation in parameterCTX (beta_sma and beta_pfc)
% B is the variation in parameterSTR   

parameterWsma = [0.00 0.05 0.1 0.15 0.20];
parameterWpfc = [0.00 0.05 0.1 0.15 0.20];
WsmaNum = length(parameterWsma);
WpfcNum = length(parameterWpfc);
runNum = 25;

TE = zeros(WsmaNum,WpfcNum,runNum);
CC = zeros(WsmaNum,WpfcNum,runNum);
SL = zeros(WsmaNum,WpfcNum,runNum);
TFC = zeros(WsmaNum,WpfcNum,runNum);
PR = zeros(WsmaNum,WpfcNum,runNum);
PE = zeros(WsmaNum,WpfcNum,runNum);
NPE = zeros(WsmaNum,WpfcNum,runNum);

total_iterations = runNum*WsmaNum*WpfcNum;
iteration_counter = 1;

fprintf('Start time: ');
disp(datestr(now, 'HH:MM:SS'));

fprintf('Total iterations: %1.0f\n\n', total_iterations);
   
for run_counter = 1:runNum
    
for Wsma_counter = 1:WsmaNum
    
for Wpfc_counter = 1:WpfcNum
    
    initialise;
    clear Wsma; %redundant
    clear Wpfc; %redundant
    
    Wsma = +0.00*ones(4,4); %0 ZERO !
    Wpfc = +0.00*ones(3,3); %0 ZERO !  

    Wsma = Wsma + diag(parameterWsma(Wsma_counter)*ones(1,size(Wsma,2))); %overwrite
    Wpfc = Wpfc + diag(parameterWpfc(Wpfc_counter)*ones(1,size(Wpfc,2)));  %overwrite
    
    fprintf('Trial (%1.0f, %1.0f, %1.0f) - Run %1.0f of %1.0f\n', Wsma_counter, Wpfc_counter, run_counter, iteration_counter, total_iterations)
    runWCST; 
    
    TE(Wsma_counter,Wpfc_counter,run_counter) = TEerrors;
    SL(Wsma_counter,Wpfc_counter,run_counter) = sum(SL5errors);
    CC(Wsma_counter,Wpfc_counter,run_counter) = catNum;
    TFC(Wsma_counter,Wpfc_counter,run_counter) = TFC;
    PR(Wsma_counter,Wpfc_counter,run_counter) = sum(PRerrors);
    PE(Wsma_counter,Wpfc_counter,run_counter) = sum(PEerrors);
    NPE(Wsma_counter,Wpfc_counter,run_counter) = NPEerrors;
 
    dependent_vars.TE = TE;
    dependent_vars.SL = SL;
    dependent_vars.CC = CC;
    dependent_vars.TFC = TFC;
    dependent_vars.PR = PR;
    dependent_vars.PE = PE;
    dependent_vars.NPE = NPE;
   
    iteration_counter = iteration_counter + 1;
end 
    
end

save('WCST_Wsmapfc.mat', 'dependent_vars','parameterWsma','parameterWpfc','-append');

end

save('WCST_Wsmapfc.mat', 'dependent_vars','parameterWsma','parameterWpfc','-append');

clear;

load('WCSTstrANDctx.mat');
