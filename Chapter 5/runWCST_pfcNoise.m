%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the simulation for the WCST 
% changing the pfcNoise parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
% Results are stored in a structure dependent_vars
% with a field for every dependent variable
% Instances are recorded in a AxBxC matrix
% where A is the variation in parameterCTX (beta_sma and beta_pfc)
% B is the variation in parameterSTR   

parameterPfcNoise = 0.00:0.02:0.20;
parameterEnvNoise = 0.00;
noisePfcLength = length(parameterPfcNoise);
noiseEnvLength = length(parameterEnvNoise);
runNum = 25; 

TE = zeros(noiseEnvLength,noisePfcLength,runNum);
CC = zeros(noiseEnvLength,noisePfcLength,runNum);
SL = zeros(noiseEnvLength,noisePfcLength,runNum);
TFC = zeros(noiseEnvLength,noisePfcLength,runNum);
PR = zeros(noiseEnvLength,noisePfcLength,runNum);
PE = zeros(noiseEnvLength,noisePfcLength,runNum);
NPE = zeros(noiseEnvLength,noisePfcLength,runNum);

total_iterations = runNum*noiseEnvLength*noisePfcLength;
iteration_counter = 1;

fprintf('Start time: ');
disp(datestr(now, 'HH:MM:SS'));

fprintf('Total iterations: %1.0f\n\n', total_iterations);
   
for run_counter = 1:runNum
    
 for noise_pfc_counter = 1:noisePfcLength
    
 for noise_env_counter = 1:noiseEnvLength
    
    initialise;
    clear pfcNoise; %redundant
    clear envNoise; %redundant
    
    pfcNoise = parameterPfcNoise(noise_pfc_counter);
    envNoise = parameterEnvNoise(noise_env_counter);
    fprintf('Trial (%1.0f, %1.0f, %1.0f) - Run %1.0f of %1.0f\n', noise_env_counter, noise_pfc_counter, run_counter, iteration_counter, total_iterations)
    
    runWCST; 
    
    TE(noise_env_counter,noise_pfc_counter,run_counter) = TEerrors;
    SL(noise_env_counter,noise_pfc_counter,run_counter) = sum(SL5errors);
    CC(noise_env_counter,noise_pfc_counter,run_counter) = catNum;
    TFC(noise_env_counter,noise_pfc_counter,run_counter) = TFC;
    PR(noise_env_counter,noise_pfc_counter,run_counter) = sum(PRerrors);
    PE(noise_env_counter,noise_pfc_counter,run_counter) = sum(PEerrors);
    NPE(noise_env_counter,noise_pfc_counter,run_counter) = NPEerrors;
 
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

save('WCST_noise.mat', 'dependent_vars','parameterPfcNoise','parameterEnvNoise','-append');

end

fprintf('End time: ');
disp(datestr(now, 'HH:MM:SS'));
clear;