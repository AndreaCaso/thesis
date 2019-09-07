% Simulated Annealing Options structure
% that will be passed to BRXsimAnn
% simAnnOpt = brx_sim_ann_options('all'); % generate option for all part.

% simAnnOpt = brx_sim_ann_options('young'); % generate option for all part.

% simAnnOpt = brx_sim_ann_options('old'); % generate option for all part.

function simAnnOpt = brx_sim_ann_options(part_type)

switch part_type
    case 'all'
     simAnnOpt.max_trials = 5; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 100; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {0.9,0.1,10,0.45,0.30,0.85,0.50,0.25};
      
     simAnnOpt.sim_values = {0.7549,0.0702,6.5253,0.4876,0.2196,0.7835,0.5985,0.2784};
     
     simAnnOpt.variability = 0.10;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
      
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
    
     simAnnOpt.TEmean = 11.5111;
     simAnnOpt.TEstd = 6.1551;
     
     simAnnOpt.PREmean = 0.1778; 
     simAnnOpt.PREstd = 0.7959;
     
     simAnnOpt.PRUmean = 3.9556;  
     simAnnOpt.PRUstd =  1.1271; 
     
     simAnnOpt.PRSREmean = 1.3556; 
     simAnnOpt.PRSREstd = 1.4160;
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this
   
    case 'young'
     simAnnOpt.max_trials = 5; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 100; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     
     init_eps_str = 0.200; %0.59850;
     init_eps_pfc = 0.500; %0.2784;
     
     simAnnOpt.init_values = {0.7549, 0.0702, 6.5253, 0.4876, 0.2196, 0.7835, init_eps_str , init_eps_pfc};
     simAnnOpt.sim_values = {0.7549, 0.0702, 6.5253, 0.4876, 0.2196, 0.7835, 0.7038 , 0.1985};
 
     simAnnOpt.sim_values = {0.7549,0.0702,6.5253,0.4876,0.2196,0.7835,0.7038,0.1985};
     
     simAnnOpt.variability = 0.10; % 
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
   
     simAnnOpt.rnd_prop(:,1:6) = 1; % Doesn't change all param except for the last ones
     
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
     
     simAnnOpt.TEmean = 9.8261;
     simAnnOpt.TEstd = 4.7441;
     
     simAnnOpt.PREmean = 0.3043; 
     simAnnOpt.PREstd = 0.9165;
     
     simAnnOpt.PRUmean = 4.1739;  
     simAnnOpt.PRUstd =  1.3748; 
     
     simAnnOpt.PRSREmean = 1.3043; 
     simAnnOpt.PRSREstd = 1.0360;
     
     simAnnOpt.stop_if_discrepancy = 0.001; % threshold: stops the SA if discrepancy (cost) is less than this   
   
    case 'old' 
     simAnnOpt.max_trials = 5; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 100; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     
     init_eps_str = 0.200; %0.59850;
     init_eps_pfc = 0.500; %0.2784;
     
     simAnnOpt.init_values = {0.7549, 0.0702, 6.5253, 0.4876, 0.2196, 0.7835, init_eps_str, init_eps_pfc};
     
     simAnnOpt.sim_values = {0.7549, 0.0702, 6.5253, 0.4876, 0.2196, 0.7835, 0.4782 , 0.2550};

     simAnnOpt.variability = 0.10;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
   
     simAnnOpt.rnd_prop(:,1:6) = 1; % Doesn't change all param except for the last ones
     
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
    
     simAnnOpt.TEmean = 13.3636;
     simAnnOpt.TEstd = 7.0320;
     
     simAnnOpt.PREmean = 0.1739; 
     simAnnOpt.PREstd = 0.6370;
     
     simAnnOpt.PRUmean = 3.8095;  
     simAnnOpt.PRUstd =  0.6944; 
     
     simAnnOpt.PRSREmean = 1.0952; 
     simAnnOpt.PRSREstd = 1.1140;
     
     simAnnOpt.stop_if_discrepancy = 0.001; % threshold: stops the SA if discrepancy (cost) is less than this   
   
end
end