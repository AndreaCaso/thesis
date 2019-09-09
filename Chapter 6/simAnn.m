 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs a simulated annealing process
% to find the best fit for the model
% Input parameters:
%
% simAnnVars = simAnn(100,10)

function simAnnVars = simAnn(start_temperature, maxSteps)

%% Print initial time
fprintf('Simulated Annealing BRX\n');
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'));
iter = 1;
discrepancy{1} = [0 0];
delta_discrepancy{1} = 0;
variability = 0.10;
max_trials = 10;
tp = 1;

initialiseBRX;

x_name = {'extPFC','discount_TDV','alpha_sma','w_STIM_PRES','w_STIM_BASE','w_RULE_PRES'};
x_value = cell(1,maxSteps);

simAnnVars(1).extPFC = extPFC;
simAnnVars(1).discount_TDV = reward.discount_TDV; 
%simAnnVars(1).alpha_sma = 10;
simAnnVars(1).w_STIM_PRES  = weights.w_STIM_PRES;
simAnnVars(1).w_STIM_BASE = weights.w_STIM_BASE;
simAnnVars(1).w_RULE_PRES = weights.w_RULE_PRES;
     
temperature = start_temperature*(1.5).^(-[1:maxSteps+1]);

while iter < maxSteps
     
 fprintf('Iteration %1.0f', iter);
 
 
 % Random vector: paramter multiplier
 rnd_prop = 1 + unifrnd(-variability, +variability, 1, 25);
 p = unifrnd(0,1); 
 
 % Candidate vector
 epsilon.eps_str = 0.5;
 epsilon.eps_pfc = 0.25;
 
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
 
 discrepancy{iter}(1) = discrepancy_with_penaliser('lin',performances_mean.PRU, 2.7205,3.9130,5.1055);
 discrepancy{iter}(2) = discrepancy_with_penaliser('lin',performances_mean.PRE,-6.6921,0.2391,7.1704);    
 discrepancy{iter}(3) = discrepancy_with_penaliser('lin',performances_mean.PRSRE,-0.0912,1.2708,2.7433);  
 discrepancy{iter}(4) = discrepancy_with_penaliser('lin',performances_mean.TE,3.8208,11.9348,20.0488); 
 
 % Computes discrepancy
 if iter > 1
  delta_discrepancy{iter} = norm(discrepancy{iter}) - norm(discrepancy{iter-1});
 else
  delta_discrepancy{iter} = norm(discrepancy{iter}) - 0;
 end 

  % Register outcome
 %simAnnVars(iter).P1 = performances_mean.P1;
 %simAnnVars(iter).P3 = performances_mean.P3;
 simAnnVars(iter).TE = performances_mean.TE;
 simAnnVars(iter).PRU = performances_mean.PRU;
 simAnnVars(iter).PRE = performances_mean.PRE;
 simAnnVars(iter).PRSRE = performances_mean.PRSRE;
 
 % Register parameter values
 simAnnVars(iter).extPFC = extPFC;
 simAnnVars(iter).discount_TDV = reward.discount_TDV; 
 %simAnnVars(iter).alpha_sma = satfnc.alpha_sma;
 
 simAnnVars(iter).w_STIM_PRES = weights.w_STIM_PRES;
 simAnnVars(iter).w_STIM_BASE = weights.w_STIM_BASE;   
 simAnnVars(iter).w_RULE_PRES = weights.w_RULE_PRES;

 % Register discrepancies
 simAnnVars(iter).discrepancy = discrepancy{iter};
 simAnnVars(iter).discrepancy_norm = norm(discrepancy{iter});
 simAnnVars(iter).delta_discrepancy = delta_discrepancy{iter};
 
 % Simulated annealing 
 if delta_discrepancy{iter} < 0  % if there's an improvement
  extPFC = rnd_prop(5)*simAnnVars(iter).extPFC;
  reward.discount_TDV = rnd_prop(1)*simAnnVars(iter).discount_TDV; 
  %satfnc.alpha_sma = rnd_prop(4)*simAnnVars(iter).alpha_sma;
  weights.w_STIM_PRES = rnd_prop(2)*simAnnVars(iter).w_STIM_PRES;
  weights.w_STIM_BASE = rnd_prop(3)*simAnnVars(iter).w_STIM_BASE;
  weights.w_RULE_PRES = rnd_prop(4)*simAnnVars(iter).w_RULE_PRES;
 else    % if there is no improvement
  if p < exp(- delta_discrepancy{iter}/temperature(tp)) && (iter > 1) 
   fprintf('Annealing...');
   extPFC = rnd_prop(5)*simAnnVars(iter-1).extPFC; 
   reward.discount_TDV = rnd_prop(1)*simAnnVars(iter-1).discount_TDV; 
   %satfnc.alpha_sma = simAnnVars(iter).alpha_sma;
   weights.w_STIM_PRES = rnd_prop(2)*simAnnVars(iter-1).w_STIM_PRES;
   weights.w_STIM_BASE = rnd_prop(3)*simAnnVars(iter-1).w_STIM_BASE;
   weights.w_RULE_PRES = rnd_prop(4)*simAnnVars(iter-1).w_RULE_PRES;
  else
   extPFC = rnd_prop(5)*simAnnVars(iter).extPFC;
   reward.discount_TDV = rnd_prop(1)*simAnnVars(iter).discount_TDV; 
   %satfnc.alpha_sma = rnd_prop(4)*simAnnVars(iter).alpha_sma;
   weights.w_STIM_PRES = rnd_prop(2)*simAnnVars(iter).w_STIM_PRES;
   weights.w_STIM_BASE = rnd_prop(3)*simAnnVars(iter).w_STIM_BASE;
   weights.w_RULE_PRES = rnd_prop(4)*simAnnVars(iter).w_RULE_PRES;
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


