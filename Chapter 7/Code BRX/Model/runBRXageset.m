function BRX_SIM_indivStats = runBRXageset(simAnnOpt,part_num)
     for count_part = 1:part_num 
       
       initialiseBRX;    
       
      % Assign variables from the option structure passed to the function
       for param_c = 1:length(simAnnOpt.param_names)
        eval(strcat( simAnnOpt.param_names{param_c}, '=', num2str(simAnnOpt.sim_values{param_c}) ,';'));
       end
      
      runBRX; 
     
      BRX_SIM_indivStats(count_part).TE = sum(performances.TE);
      BRX_SIM_indivStats(count_part).PRU = sum(performances.PRU);
      BRX_SIM_indivStats(count_part).PRE = sum(performances.PRE);
      BRX_SIM_indivStats(count_part).PRSRE = sum(performances.PRSRE);
      
      BRX_SIM_indivStats(count_part).RTall = nanmedian(performances.RT);
      BRX_SIM_indivStats(count_part).RTcorr = nanmedian(performances.RTcorr);
      BRX_SIM_indivStats(count_part).RTincorr = nanmedian(performances.RTincorr);
      
     end
      
end