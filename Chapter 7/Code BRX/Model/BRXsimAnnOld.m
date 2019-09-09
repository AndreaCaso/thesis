 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs a simulated annealing process
% to find the best fit for the model
% Input parameters:
%
% simAnnVarsOld = BRXsimAnnOld(100,10)

function [simAnnVarsOld] = BRXsimAnnOld(start_temperature, maxSteps)

%% Print initial time
fprintf('Simulated Annealing BRX\n');
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'));
iter = 1;
discrepancy{1} = [0 0];
delta_discrepancy{1} = 0;
variability = 0.10;
max_trials = 5;
tp = 1;

initialiseBRX;

simAnnVarsOld(1).eps_pfc = epsilon.eps_pfc;
simAnnVarsOld(1).eps_str = epsilon.eps_str; 

temperature = start_temperature*(1.5).^(-[1:maxSteps+1]);

while iter < maxSteps
     
 fprintf('Iteration %1.0f', iter);
 
 % Random vector: paramter multiplier
 rnd_prop = 1 + unifrnd(-variability, +variability, 1, 25);
 p = unifrnd(0,1); 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for trial_num = 1:max_trials
  initialiseBRX_SA;
  runBRX;        % Run Brixton Task Simulation
  performances_TE(trial_num) = performances.TE;
  performances_PRU(trial_num) = performances.PRU;
  performances_PRE(trial_num) = performances.PRE;
  performances_PRSRE(trial_num) = performances.PRSRE;
  fprintf('.');
 end
 
 performances_mean.TE = trimmean(performances_TE,10);
 performances_mean.PRU = trimmean(performances_PRU,10);
 performances_mean.PRE = trimmean(performances_PRE,10);
 performances_mean.PRSRE = trimmean(performances_PRSRE,10);
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Calculate discrepancy with target measures
 
 discrepancy{iter}(1) = discrepancy_with_penaliser('lin',performances_mean.PRU, 3.6957,3.6957,3.6957);
 discrepancy{iter}(2) = discrepancy_with_penaliser('lin',performances_mean.PRE,0.1739,0.1739,0.1739);    
 discrepancy{iter}(3) = discrepancy_with_penaliser('lin',performances_mean.PRSRE,1.3913,1.3913,1.3913);  
 discrepancy{iter}(4) = discrepancy_with_penaliser('lin',performances_mean.TE,14.1739,14.1739,14.1739); 
 
 % Computes discrepancy
 if iter > 1
  delta_discrepancy{iter} = norm(discrepancy{iter}) - norm(discrepancy{iter-1});
 else
  delta_discrepancy{iter} = norm(discrepancy{iter}) - 0;
 end 

  % Register outcome
 %simAnnVarsYoung(iter).P1 = performances_mean.P1;
 %simAnnVarsYoung(iter).P3 = performances_mean.P3;
 simAnnVarsOld(iter).TE = performances_mean.TE;
 simAnnVarsOld(iter).PRU = performances_mean.PRU;
 simAnnVarsOld(iter).PRE = performances_mean.PRE;
 simAnnVarsOld(iter).PRSRE = performances_mean.PRSRE;
 
 % Register parameter values
 simAnnVarsOld(iter).eps_str = epsilon.eps_str;
 simAnnVarsOld(iter).eps_pfc = epsilon.eps_pfc;

 % Register discrepancies
 simAnnVarsOld(iter).discrepancy = discrepancy{iter};
 simAnnVarsOld(iter).discrepancy_norm = norm(discrepancy{iter});
 simAnnVarsOld(iter).delta_discrepancy = delta_discrepancy{iter};
 
 % Simulated annealing 
 if delta_discrepancy{iter} < 0 || (iter == 1)  % if there's an improvement
   epsilon.eps_str = rnd_prop(1)*simAnnVarsOld(iter).eps_str;
   epsilon.eps_pfc = rnd_prop(2)*simAnnVarsOld(iter).eps_pfc;
 else    % if there is no improvement
  if p < exp(- delta_discrepancy{iter}/temperature(tp))  
   fprintf('Annealing...');
   epsilon.eps_str = rnd_prop(1)*simAnnVarsOld(iter).eps_str;
   epsilon.eps_pfc = rnd_prop(2)*simAnnVarsOld(iter).eps_pfc;
  else
   epsilon.eps_str = rnd_prop(1)*simAnnVarsOld(iter-1).eps_str;
   epsilon.eps_pfc = rnd_prop(2)*simAnnVarsOld(iter-1).eps_pfc;
  end
  tp = tp + 1;
 end
 
 fprintf('completed. ');
 fprintf('Discrepancy norm: %2.2f\n', norm(discrepancy{iter}));
 
 % Interrupt if discrepancy is small enough
 % and if there's a lock (defined as three times d > 10) in a row
 if iter >= 5 && all([norm(discrepancy{iter-2}),norm(discrepancy{iter-1}),norm(discrepancy{iter})] > [10 10 10]);
    variability = 1.1*variability;
 end
 if norm(discrepancy{iter}) < 0.05
  fprintf('...interrupted.');
  beep 
  break;
 end
 
 iter = iter + 1; 
   
end

%% Print results and save

 fprintf('\nSimulated Annealing BRX completed\n');
 fprintf('Ending time: %s\n', datestr(now,'HH:MM'));
 
end


