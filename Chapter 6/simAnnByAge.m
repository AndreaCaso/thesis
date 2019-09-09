 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs a simulated annealing process
% to find the best fit for the model
% for young and old. All the other parameters are fixed,
% only epsilon_str and epsiln_pfc change
% Input parameters
%
% simAnnVarsAge = simAnnByAge(100,10)

function simAnnVarsAge = simAnnByAge(start_temperature, maxSteps)

%% Print initial time
fprintf('Simulated Annealing BRX\n');
fprintf('Beginning time: %s\n', datestr(now,'HH:MM'));
iter = 2;
discrepancy{1} = [0 0];
delta_discrepancy{1} = 0;
variability = 0.10;

simAnnVarsAge(1).eps_str = 0.5;
simAnnVarsAge(1).eps_pfc = 0.25; 

temperature = linspace(start_temperature,0,maxSteps);

while iter < maxSteps
     
 fprintf('Iteration %1.0f', iter-1);
 
 % Initialise
 initialiseBRX;
 % Random vector: paramter multiplier
 rnd_prop = 1 + unifrnd(-variability, +variability, 1, 25);
 p = unifrnd(0,1); 
  
 if delta_discrepancy{iter-1} <= 0  % if there's an improvement
  epsilon.eps_str = rnd_prop(1)*simAnnVarsAge(iter-1).eps_str;
  epsilon.eps_pfc = rnd_prop(2)*simAnnVarsAge(iter-1).eps_pfc; 
 else    % if there is no improvement
  if p < exp(- delta_discrepancy{iter-1}/temperature(iter-1))
   fprintf('...Annealing');
   epsilon.eps_str = simAnnVarsAge(iter-1).eps_str; 
   epsilon.eps_pfc = simAnnVarsAge(iter-1).eps_pfc; 
  else
   epsilon.eps_str = rnd_prop(1)*simAnnVarsAge(iter-1).eps_str;
   epsilon.eps_pfc = rnd_prop(2)*simAnnVarsAge(iter-1).eps_pfc; 
  end
 end 
 
 % Candidate vector
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 runBRX;        % Run Brixton Task Simulation
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Update parameter storage: outcome
 simAnnVarsAge(iter).P1 = performances.P1;
 simAnnVarsAge(iter).P3 = performances.P3;
 simAnnVarsAge(iter).PRU = performances.PRU;
 simAnnVarsAge(iter).PRE = performances.PRE;
 simAnnVarsAge(iter).PRSRE = performances.PRSRE;
 
 % Calculate discrepancy with target measures
 % measures has been trimmed by 10%
 
 discrepancy{iter}(1) = (performances.TE - 9.8261);
 discrepancy{iter}(2) = (performances.PRU - 4.1739);
 discrepancy{iter}(3) = (performances.PRE - 0.3043);
 discrepancy{iter}(4) = (performances.PRSRE - 1.3043);
 
 %discrepancy{iter}(1) = discrepancy_with_penaliser(performances.P1,4.7802,6.5714,8.3626);
 %discrepancy{iter}(2) = discrepancy_with_penaliser(performances.P3,0.6212,4.2979,7.9746);
 %discrepancy{iter}(3) = discrepancy_with_penaliser(performances.PRU,3.1073,3.8444,4.5816);
 %discrepancy{iter}(4) = discrepancy_with_penaliser(performances.PRE,0,0.3061,1.1021);    
 %discrepancy{iter}(5) = discrepancy_with_penaliser(performances.PRSRE,0.2041,1.2708,2.3375);  
   
 % Computes discrepancy
 delta_discrepancy{iter} = norm(discrepancy{iter}) - norm(discrepancy{iter-1});
  
 % Register parameter values
 simAnnVarsAge(iter).eps_str = epsilon.eps_str;
 simAnnVarsAge(iter).eps_pfc = epsilon.eps_pfc; 

 % Register discrepancies
 simAnnVarsAge(iter).discrepancy = discrepancy{iter};
 simAnnVarsAge(iter).discrepancy_norm = norm(discrepancy{iter});
 simAnnVarsAge(iter).delta_discrepancy = delta_discrepancy{iter};
 
 % Interrupt if discrepancy is small enough
 % and if there's a lock (defined as three times d > 10) in a row
 if iter >= 5
   discrepancy_lock = all([norm(discrepancy{iter-2}),norm(discrepancy{iter-1}),norm(discrepancy{iter})] > [20 20 20]);
 else
   discrepancy_lock = 0;
 end
 if norm(discrepancy{iter}) < 0.5 || discrepancy_lock
  fprintf('...interrupted.');
  beep 
  break;
 end
 
 fprintf('...completed. ');
 fprintf('Discrepancy norm: %2.2f\n', norm(discrepancy{iter}));
 
 iter = iter + 1; 
   
end

%% Print results and save

 fprintf('\nSimulated Annealing BRX completed\n');
 fprintf('Ending time: %s\n', datestr(now,'HH:MM'));
 
end


