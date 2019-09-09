%% Runs interactions between changes in beta_str and beta_sma

clear; clc;
% Results are stored in a structure dependent_vars
% with a field for every dependent variable
% Instances are recorded in a AxBxC matrix
% where A is the variation in parameterCTX (beta_sma and beta_pfc)
% B is the variation in parameterSTR   

parameterCTX = [0.2 0.3 0.5 0.6];
parameterSTR = [0.2 0.3 0.4 0.5 0.6 0.7 0.8];
CtxNum = length(parameterCTX);
StrNum = length(parameterSTR);
runNum = 25;

TE = zeros(CtxNum,StrNum,runNum);
CC = zeros(CtxNum,StrNum,runNum);
SL = zeros(CtxNum,StrNum,runNum);
TFC = zeros(CtxNum,StrNum,runNum);
PR = zeros(CtxNum,StrNum,runNum);
PE = zeros(CtxNum,StrNum,runNum);
NPE = zeros(CtxNum,StrNum,runNum);

total_iterations = runNum*CtxNum*StrNum;
iteration_counter = 1;

fprintf('Start time: ');
disp(datestr(now, 'HH:MM:SS'));

fprintf('Total iterations: %1.0f\n\n', total_iterations);
   
for run_counter = 1:runNum
    
for ctx_counter = 1:CtxNum
    
for str_counter = 1:StrNum
    
    initialise;
    clear beta_sma; %redundant
    clear beta_pfc; %redundant
    clear beta_str_sma; %redundant
    clear beta_str_pfc; %redundant
    
    beta_pfc = parameterCTX(ctx_counter)*(ones(1,3)); %overwrite
    beta_sma = parameterCTX(ctx_counter)*(ones(1,4)); %overwrite
    
    beta_str_pfc = parameterSTR(str_counter)*(ones(1,3)); %overwrite
    beta_str_sma = parameterSTR(str_counter)*(ones(1,4)); %overwrite
    
    fprintf('Trial (%1.0f, %1.0f, %1.0f) - Run %1.0f of %1.0f\n', ctx_counter, str_counter, run_counter, iteration_counter, total_iterations)
    runWCST; 
    
    TE(ctx_counter,str_counter,run_counter) = TEerrors;
    SL(ctx_counter,str_counter,run_counter) = sum(SL5errors);
    CC(ctx_counter,str_counter,run_counter) = catNum;
    TFC(ctx_counter,str_counter,run_counter) = TFC;
    PR(ctx_counter,str_counter,run_counter) = sum(PRerrors);
    PE(ctx_counter,str_counter,run_counter) = sum(PEerrors);
    NPE(ctx_counter,str_counter,run_counter) = NPEerrors;
 
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

save('WCSTstrANDctx.mat', 'dependent_vars','parameterCTX','parameterSTR','-append');

end

save('WCSTstrANDctx.mat', 'dependent_vars','parameterCTX','parameterSTR','-append');

clear;

load('WCSTstrANDctx.mat');


