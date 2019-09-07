function WCST_SIM_indivStats = runWCSTageset(simAnnOpt,part_num)

    for count_part = 1:part_num 
       initialiseWCST;    
       
      % Assign variables from the option structure passed to the function
       for param_c = 1:length(simAnnOpt.param_names)
        eval(strcat( simAnnOpt.param_names{param_c}, '=', num2str(simAnnOpt.sim_values{param_c}) ,';'));
       end
      
      runWCST; 
      
      % performance
      WCST_SIM_indivStats(count_part).TE = sum(performances.TE);
      WCST_SIM_indivStats(count_part).PE = sum(performances.PE);
      WCST_SIM_indivStats(count_part).SL3 = sum(performances.SL3);
      
      % individual RT
      WCST_SIM_indivStats(count_part).RTall = [[performances.RTcorr], [performances.RTincorr]];
      WCST_SIM_indivStats(count_part).RTcorr = ((performances.RTcorr));
      WCST_SIM_indivStats(count_part).RTincorr = ((performances.RTincorr));
      
      % median RTd
      WCST_SIM_indivStats(count_part).RTall_m = median([(performances.RTcorr), (performances.RTincorr)]);
      WCST_SIM_indivStats(count_part).RTcorr_m = median((performances.RTcorr));
      WCST_SIM_indivStats(count_part).RTincorr_m = median((performances.RTincorr));
      
     end
      
end