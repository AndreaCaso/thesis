% Plot 5CHANNEL BG - plot hard and soft switching in function
% of beta_str and alpha_str
clear;
beta_str_v = 0.0:0.01:1.50;
alpha_str_v = [5 7 9];
sel_ba = [];

for aa = 1:length(alpha_str_v)
for bb = 1:length(beta_str_v)
 
 load('Extension 1 Variables.mat');
 alpha_str = alpha_str_v(aa);
 beta_str = beta_str_v(bb);
 threshold = 0.5;
 CHNoise = 1e-3;
 f_sampl = 1/0.1;
 warning('OFF')
 sim('ExtensionSimulation1var_5.slx',[])

 %% Calculate selectivity 1 - #selected channels / #active channels in
 selectivity = [];
 ch_thr = 0.00;
 for tt = 1:400
    
     active_channels_in = length(find(CH_IN.Data(tt,:)>(1+ch_thr)*threshold)); % 
     selected_channels = length(find(CH_OUT.Data(tt,:)<(1-ch_thr)*threshold));
     
     selectivity(tt) = 1 - abs(selected_channels/active_channels_in);
     selectivity_s(tt) = nanmax((CH_IN.Data(tt,:)./(1 - CH_OUT.Data(tt,:))));
    
 end

 idx = isfinite(selectivity) & ~isnan(selectivity);
 sel_ba(bb,aa) = nanmean(selectivity(idx));
 
 idx = isfinite(selectivity_s) & ~isnan(selectivity_s);
 sel_ba_s(bb,aa) = nanmean(selectivity_s(idx));
 
 disp(beta_str)
end
end

sel_ba = sel_ba/max(max(sel_ba)); %normalised
sel_ba_s = sel_ba_s/max(max(sel_ba_s)); %normalised

figure;
hold on;
for nn = 1:length(alpha_str_v)
 plot(beta_str_v,sel_ba(:,nn));
end
ylim([-0.1 1.1]);
xlabel('\beta_{str}');
ylabel('Selectivity');
xticks(linspace(beta_str_v(1),beta_str_v(end),7));
legend({['\alpha_{str} = ',num2str(alpha_str_v(1))],['\alpha_{str} = ',num2str(alpha_str_v(2))],['\alpha_{str} = ',num2str(alpha_str_v(3))]})


figure;
hold on;
for nn = 1:length(alpha_str_v)
 plot(beta_str_v,sel_ba_s(:,nn));
end
ylim([-0.1 1.1]);
xlabel('\beta_{str}');
ylabel('Selectivity (soft)');
xticks(linspace(beta_str_v(1),beta_str_v(end),7));
legend({['\alpha_{str} = ',num2str(alpha_str_v(1))],['\alpha_{str} = ',num2str(alpha_str_v(2))],['\alpha_{str} = ',num2str(alpha_str_v(3))]})

