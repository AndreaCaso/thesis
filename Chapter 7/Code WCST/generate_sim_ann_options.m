% Simulated Annealing Options structure
% that will be passed to WCSTsimAnn
% simAnnOpt = generate_sim_ann_options('all'); % generate option for all part.

% simAnnOpt = generate_sim_ann_options('young'); % generate option for all part.

% simAnnOpt = generate_sim_ann_options('old'); % generate option for all part.

function simAnnOpt = generate_sim_ann_options(part_type)

load('WCSTstats.mat', 'WCSTclusters_stats');
load('WCSTstats.mat', 'WCSTclusters2_stats');

switch part_type
    
    case 'all'
    
     simAnnOpt.name = 'ALL';
     simAnnOpt.BIC = 18.40;
     simAnnOpt.max_trials = 5; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 100; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {1.1720,0.1135,9.7863,0.3742,0.1357,0.9346,0.3526,0.3268};
    
     % this are the fixed values for the subsequent simulation, not the SA.
     simAnnOpt.sim_values = {1.3378,0.0946,5.8365,0.3660,0.2367,1.2792,0.1287,0.3932};
  
     simAnnOpt.variability = 0.15;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
  
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
    
     simAnnOpt.CCmean = 5.4130;
     simAnnOpt.CCstd = 2.5121;
     simAnnOpt.TEmean = 18.7174;
     simAnnOpt.TEstd = 7.6478;
     simAnnOpt.PEmean = 11.8913; % PE
     simAnnOpt.PEstd = 5.4660;
     simAnnOpt.SLmean = 0.9348; %SL3 
     simAnnOpt.SLstd = 1.3614; %SL3 std
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this
   
    case 'young'
     
     simAnnOpt.name = 'Y';
     simAnnOpt.BIC = 33.79;
     simAnnOpt.max_trials = 5; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 50; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {1.3378,0.0946,5.8365,0.3660,0.2367,1.2792,0.1287,0.3932};
     % this are the fixed values for the subsequent simulation, not the SA.
     simAnnOpt.sim_values = {1.3378, 0.0946, 5.8365, 0.3660, 0.2367, 1.2792, 0.112945006717948 , 0.304190334284435};

     simAnnOpt.variability = 0.10;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
   
     simAnnOpt.rnd_prop(:,1:6) = 1; % Doesn't change all param except for the last ones
     
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
    
     simAnnOpt.CCmean = 6.2609;
     simAnnOpt.CCstd = 1.9079;
     simAnnOpt.TEmean = 16.7826;
     simAnnOpt.TEstd = 5.5863;
     simAnnOpt.PEmean = 11.0435; % PE
     simAnnOpt.PEstd = 4.2887;
     simAnnOpt.SLmean = 0.9950; %SL3 
     simAnnOpt.SLstd = 0.5217; %SL3 std
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this   
    case 'old' 
     
     simAnnOpt.name = 'O';
     simAnnOpt.BIC = 33.79;
     simAnnOpt.max_trials = 5; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 50; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {1.3378,0.0946,5.8365,0.3660,0.2367,1.2792,0.1287,0.3932};
     
     % this are the fixed values for the subsequent simulation, not the SA.
     simAnnOpt.sim_values = {1.3378, 0.0946, 5.8365, 0.3660, 0.2367, 1.2792, 0.102840555017980, 0.453114470366154 };
    
     simAnnOpt.variability = 0.10;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
   
     simAnnOpt.rnd_prop(:,1:6) = 1; % Doesn't change all param except for the last ones
     
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
    
     simAnnOpt.CCmean = 4.5652;
     simAnnOpt.CCstd = 2.8006;
     simAnnOpt.TEmean = 20.7826;
     simAnnOpt.TEstd = 6.4026;
     simAnnOpt.PEmean = 12.7826; % PE
     simAnnOpt.PEstd = 4.2887;
     simAnnOpt.SLmean = 1.3913; %SL3 
     simAnnOpt.SLstd = 1.5578; %SL3 std
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this   
   
    case 'group1of3' 
      
     simAnnOpt.name = '3G-1';
     simAnnOpt.BIC = 45.16;
     simAnnOpt.max_trials = 10; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 50; %how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {1.1720,0.0946,9.7863,0.3742,0.1357,0.9346,0.20,0.05};
   
     % this are the fixed values for the subsequent simulation, not the SA.
     simAnnOpt.sim_values = {0.9750,0.0946,9.7863,0.3742,0.1357,0.9346, 0.1385,0.0418};
   
     simAnnOpt.variability = 0.15;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
     simAnnOpt.rnd_prop(:,2:6) = 1;   % Doesn't change all param except for the last ones
       
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
    
     simAnnOpt.CCmean = [];
     simAnnOpt.CCstd = [];
     simAnnOpt.TEmean = trimmean(WCSTclusters_stats{1}.TE,10);
     simAnnOpt.TEstd = std(WCSTclusters_stats{1}.TE);
     simAnnOpt.PEmean = trimmean(WCSTclusters_stats{1}.PE,10); % PE
     simAnnOpt.PEstd = std(WCSTclusters_stats{1}.PE);
     simAnnOpt.SLmean = trimmean(WCSTclusters_stats{1}.SL3,10); %SL3 
     simAnnOpt.SLstd = std(WCSTclusters_stats{1}.SL3); %SL3 std
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this   
   
    case 'group2of3' 
       
     simAnnOpt.name = '3G-2';
     simAnnOpt.BIC = 45.16;
     simAnnOpt.max_trials = 10; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 50; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {1.1720,0.0946,9.7863,0.3742,0.1357,0.9346,0.4,0.5};
    
     % this are the fixed values for the subsequent simulation, not the SA.
     simAnnOpt.sim_values = {1.1071,0.0551,9.7863,0.3742,0.1357,0.9346,0.2713,0.9335};
   
     simAnnOpt.variability = 0.15;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
     simAnnOpt.rnd_prop(:,2:6) = 1; % Doesn't change all param except for the last ones
  
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
    
     simAnnOpt.CCmean = [];
     simAnnOpt.CCstd = [];
     simAnnOpt.TEmean = trimmean(WCSTclusters_stats{2}.TE,10);
     simAnnOpt.TEstd = std(WCSTclusters_stats{2}.TE);
     simAnnOpt.PEmean = trimmean(WCSTclusters_stats{2}.PE,10); % PE
     simAnnOpt.PEstd = std(WCSTclusters_stats{2}.PE);
     simAnnOpt.SLmean = trimmean(WCSTclusters_stats{2}.SL3,10); %SL3 
     simAnnOpt.SLstd = std(WCSTclusters_stats{2}.SL3); %SL3 std
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this   
   
  case 'group3of3' 
     
     simAnnOpt.name = '3G-3';
     simAnnOpt.BIC = 45.16;
     simAnnOpt.max_trials = 10; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 50; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {1.1720,0.0946,9.7863,0.3742,0.1357,0.9346,0.01,0.45};
     
     % this are the fixed values for the subsequent simulation, not the SA.
     simAnnOpt.sim_values = {0.7726,0.0627,9.7863,0.3742,0.1357,0.9346,0.0077,0.1479};
   
     simAnnOpt.variability = 0.15;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
     simAnnOpt.rnd_prop(:,2:6) = 1; % Doesn't change all param except for the last ones
  
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
     simAnnOpt.CCmean = [];
     simAnnOpt.CCstd = [];
     simAnnOpt.TEmean = trimmean(WCSTclusters_stats{3}.TE,10);
     simAnnOpt.TEstd = std(WCSTclusters_stats{3}.TE);
     simAnnOpt.PEmean = trimmean(WCSTclusters_stats{3}.PE,10); % PE
     simAnnOpt.PEstd = std(WCSTclusters_stats{3}.PE);
     simAnnOpt.SLmean = trimmean(WCSTclusters_stats{3}.SL3,10); %SL3 
     simAnnOpt.SLstd = std(WCSTclusters_stats{3}.SL3); %SL3 std
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this   
   
   case 'group1of2' 
     
     simAnnOpt.name = '2G.1-1';
     simAnnOpt.BIC = 30.27;
     simAnnOpt.max_trials = 10; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 50; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {1.3378,0.0946,5.8365,0.3660,0.2367,1.2792,0.0602,0.2367};
     
     % this are the fixed values for the subsequent simulation, not the SA.
     simAnnOpt.sim_values = {1.3378,0.0946,5.8365,0.3660,0.2367,1.2792,0.0181,0.4463};
   
     simAnnOpt.variability = 0.15;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
     simAnnOpt.rnd_prop(:,1:6) = 1; % Doesn't change all param except for the last ones
  
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
     simAnnOpt.CCmean = [];
     simAnnOpt.CCstd = [];
     simAnnOpt.TEmean = trimmean(WCSTclusters2_stats{1}.TE,10);
     simAnnOpt.TEstd = std(WCSTclusters2_stats{1}.TE);
     simAnnOpt.PEmean = trimmean(WCSTclusters2_stats{1}.PE,10); % PE
     simAnnOpt.PEstd = std(WCSTclusters2_stats{1}.PE);
     simAnnOpt.SLmean = trimmean(WCSTclusters2_stats{1}.SL3,10); %SL3 
     simAnnOpt.SLstd = std(WCSTclusters2_stats{1}.SL3); %SL3 std
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this   
   
   case 'group2of2' 
     
     simAnnOpt.name = '2G.1-2';
     simAnnOpt.BIC = 30.27;
     simAnnOpt.max_trials = 10; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 50; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {1.3378,0.0946,5.8365,0.3660,0.2367,1.2792,0.1287,0.3932};
     
     % this are the fixed values for the subsequent simulation, not the SA.
     simAnnOpt.sim_values = {0.7726,0.0627,9.7863,0.3742,0.1357,0.9346,0.1981,0.2912};
   
     simAnnOpt.variability = 0.15;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
     simAnnOpt.rnd_prop(:,1:6) = 1; % Doesn't change all param except for the last ones
  
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
     simAnnOpt.CCmean = [];
     simAnnOpt.CCstd = [];
     simAnnOpt.TEmean = trimmean(WCSTclusters2_stats{2}.TE,10);
     simAnnOpt.TEstd = std(WCSTclusters2_stats{2}.TE);
     simAnnOpt.PEmean = trimmean(WCSTclusters2_stats{2}.PE,10); % PE
     simAnnOpt.PEstd = std(WCSTclusters2_stats{2}.PE);
     simAnnOpt.SLmean = trimmean(WCSTclusters2_stats{2}.SL3,10); %SL3 
     simAnnOpt.SLstd = std(WCSTclusters2_stats{2}.SL3); %SL3 std
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this   
   
    case 'group1of2_2' 
     
     simAnnOpt.name = '2G.2-1';
     simAnnOpt.BIC = 37.35;
     simAnnOpt.max_trials = 10; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 50; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {1.2529,0.0946,5.8365,0.3660,0.2367,1.2792,0.0566,0.1741};
     
     % this are the fixed values for the subsequent simulation, not the SA.
     simAnnOpt.sim_values = {0.8422,0.0946,5.8365,0.3660,0.2367,1.2792,0.0494,0.1828};
   
     simAnnOpt.variability = 0.15;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
     simAnnOpt.rnd_prop(:,2:6) = 1; % Doesn't change all param except for the last ones
  
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
     simAnnOpt.CCmean = [];
     simAnnOpt.CCstd = [];
     simAnnOpt.TEmean = trimmean(WCSTclusters2_stats{1}.TE,10);
     simAnnOpt.TEstd = std(WCSTclusters2_stats{1}.TE);
     simAnnOpt.PEmean = trimmean(WCSTclusters2_stats{1}.PE,10); % PE
     simAnnOpt.PEstd = std(WCSTclusters2_stats{1}.PE);
     simAnnOpt.SLmean = trimmean(WCSTclusters2_stats{1}.SL3,10); %SL3 
     simAnnOpt.SLstd = std(WCSTclusters2_stats{1}.SL3); %SL3 std
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this   
   
   case 'group2of2_2' 
       
     simAnnOpt.name = '2G.2-2';
     simAnnOpt.BIC = 37.35;
     simAnnOpt.max_trials = 10; % how many trials with the same set of parameters?
     simAnnOpt.max_steps = 50; % how many steps of the SA process
     simAnnOpt.param_names = {'extPFC','reward.discount_TDV','satfnc.alpha_sma','weights.w_STIM_PRES','weights.w_STIM_BASE','weights.w_RULE_PRES','epsilon.eps_str','epsilon.eps_pfc'};
     simAnnOpt.init_values = {1.3378,0.0946,5.8365,0.3660,0.2367,1.2792,0.1287,0.3932};
     
     % this are the fixed values for the subsequent simulation, not the SA.
     simAnnOpt.sim_values = {0.9326,0.0627,9.7863,0.3742,0.1357,0.9346,0.2011,0.2037};
   
     simAnnOpt.variability = 0.15;
     simAnnOpt.rnd_prop = 1 + unifrnd(-simAnnOpt.variability, +simAnnOpt.variability, simAnnOpt.max_steps, length(simAnnOpt.param_names));
     simAnnOpt.rnd_prop(:,2:6) = 1; % Doesn't change all param except for the last ones
  
     simAnnOpt.start_temperature = 100;
     simAnnOpt.temperature = simAnnOpt.start_temperature*(1.5).^(-[0:simAnnOpt.max_steps+1]);
     simAnnOpt.CCmean = [];
     simAnnOpt.CCstd = [];
     simAnnOpt.TEmean = trimmean(WCSTclusters2_stats{2}.TE,10);
     simAnnOpt.TEstd = std(WCSTclusters2_stats{2}.TE);
     simAnnOpt.PEmean = trimmean(WCSTclusters2_stats{2}.PE,10); % PE
     simAnnOpt.PEstd = std(WCSTclusters2_stats{2}.PE);
     simAnnOpt.SLmean = trimmean(WCSTclusters2_stats{2}.SL3,10); %SL3 
     simAnnOpt.SLstd = std(WCSTclusters2_stats{2}.SL3); %SL3 std
     
     simAnnOpt.stop_if_discrepancy = 0.05; % threshold: stops the SA if discrepancy (cost) is less than this   
   
       
end