% Calculates BICs for one model with more groups
% k is a scalar with the number of parameter in the model
% varargin are cell arrays with models to compare,
% the first one is the simulated value, the second is the experimental
% example usage:

% BIC = WCSTcalculateBIC(8,{WCST_indivStats,WCST_SIM_ALL_indivStats});
% BIC = WCSTcalculateBIC(2,{WCST_indivStats([WCST_indivStats.Age]>=60),WCST_SIM_OLD_indivStats},{WCST_indivStats([WCST_indivStats.Age]<60),WCST_SIM_YOUNG_indivStats});
% BIC = WCSTcalculateBIC(2,{WCSTclusters2_stats{1},WCST_SIM_G1of2_indivStats},{WCSTclusters2_stats{2},WCST_SIM_G2of2_indivStats});
% BIC = WCSTcalculateBIC(3,{WCSTclusters2_stats{1},WCST_SIM_G1of2_2_indivStats},{WCSTclusters2_stats{2},WCST_SIM_G2of2_2_indivStats});
% BIC = WCSTcalculateBIC(3,{WCSTclusters_stats{1},WCST_SIM_G1of3_indivStats},{WCSTclusters_stats{2},WCST_SIM_G2of3_indivStats},{WCSTclusters_stats{3},WCST_SIM_G3of3_indivStats});
%\

function BICmax = WCSTcalculateBIC(k, varargin)

trial_total = 20000;
m = 3; % DVs
n = 3; % DVs x groups
BIC = nan(1,trial_total);
BICmax = nan(1,trial_total);

for trial_num = 1:trial_total

SS_TE = 0; % Initialise sum of squares
SS_PE = 0;
SS_SL3 = 0;

for group_num = 1:nargin-1
    
 % model/experimental
 sample_group{group_num}{1}.TE = datasample([varargin{group_num}{1}.TE],length([varargin{group_num}{1}.TE]));
 sample_group{group_num}{1}.PE = datasample([varargin{group_num}{1}.PE],length([varargin{group_num}{1}.PE]));
 sample_group{group_num}{1}.SL3 = datasample([varargin{group_num}{1}.SL3],length([varargin{group_num}{1}.SL3]));
 
 % experimental/model
 sample_group{group_num}{2}.TE = datasample([varargin{group_num}{2}.TE],length([varargin{group_num}{2}.TE]));
 sample_group{group_num}{2}.PE = datasample([varargin{group_num}{2}.PE],length([varargin{group_num}{2}.PE]));
 sample_group{group_num}{2}.SL3 = datasample([varargin{group_num}{2}.SL3],length([varargin{group_num}{2}.SL3]));

end

for group_num = 1:nargin-1
   
   SS_TEg(group_num) = (( median(([sample_group{group_num}{1}.TE])) - median(([sample_group{group_num}{2}.TE])) )).^2;
   SS_PEg(group_num) = (( median(([sample_group{group_num}{1}.PE])) - median(([sample_group{group_num}{2}.PE])) )).^2;
   SS_SL3g(group_num) = (( median(([sample_group{group_num}{1}.SL3])) - median(([sample_group{group_num}{2}.SL3])) )).^2;
   
   SS_TE = SS_TE + SS_TEg(group_num);
   SS_PE = SS_PE + SS_PEg(group_num);
   SS_SL3 = SS_SL3 + SS_SL3g(group_num);
   
end

   SS_TEmax = nanmax(SS_TEg);
   SS_PEmax = nanmax(SS_PEg);
   SS_SL3max = nanmax(SS_SL3g);
   
 SS_E(trial_num) = SS_TE + SS_PE + SS_SL3;
 SS_Emax(trial_num) = SS_TEmax + SS_PEmax + SS_SL3max;
 
 BIC(trial_num) = n + n*log(2*pi) + n*log(SS_E(trial_num)/n) + (k+1)*log(n);
 
 % Calculated not taking into account the number of groups, by looking for
 % the minimum value across all groups
 
 BICmax(trial_num) = m + m*log(2*pi) + m*log(SS_Emax(trial_num)/m) + (k+1)*log(m);
 
end

 fprintf('SSe = %1.2f , n = %1.0f, k = %1.0f, BIC = %2.2f, SE = %2.2f  \n', nanmean(SS_E), n, k, nanmean(BIC), nanstd(BIC)/sqrt(length(BIC)));
 fprintf('SSe(max) = %1.2f , m = %1.0f, k = %1.0f, BIC(max) = %2.2f, SE = %2.2f  \n', nanmean(SS_Emax), m, k, nanmean(BICmax), nanstd(BICmax)/sqrt(length(BICmax)));
 
end