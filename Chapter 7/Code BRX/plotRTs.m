% The function plots the RTs
% If there is just one argument, it divides in young and old
% otherwise the first argument is young and the other old

function plotRTs(BRX_indivStats, BRX_indivStats2)
 
if nargin == 1  % It's one stat file
    
 young_idx = [BRX_indivStats.Age] <= 60;
 old_idx = [BRX_indivStats.Age] > 60;
 
 mean_matrix = [nanmean([BRX_indivStats(young_idx).RTcorr]), nanmean([BRX_indivStats(young_idx).RTincorr]); nanmean([BRX_indivStats(old_idx).RTcorr]), nanmean([BRX_indivStats(old_idx).RTincorr])];
 error_matrix = [nanstd([BRX_indivStats(young_idx).RTcorr]), nanstd([BRX_indivStats(young_idx).RTincorr]); nanstd([BRX_indivStats(old_idx).RTcorr]), nanstd([BRX_indivStats(old_idx).RTincorr])];
 
 barwitherr(error_matrix,mean_matrix);
 set(gca,'XTickLabel',{'Young','Old'});
 legend('Correct','Incorrect')
 title('RT')
 
  RT_anova_data(:,1) = [[BRX_indivStats(young_idx).RTcorr]'; [BRX_indivStats(old_idx).RTcorr]'];
  RT_anova_data(:,2) = [[BRX_indivStats(young_idx).RTincorr]'; [BRX_indivStats(old_idx).RTincorr]'];
  RT_anova_groups = [zeros(sum(young_idx==1),1); ones(sum(old_idx==1),1) ];
  
  tbl = simple_mixed_anova(RT_anova_data,RT_anova_groups,{'Age_Group'},{'Feedback'});
  disp(tbl); 
  
end

if nargin == 2  % It's one stat file
    
 mean_matrix = [trimmean([BRX_indivStats.RTcorr],10), trimmean([BRX_indivStats.RTincorr],10); trimmean([BRX_indivStats2.RTcorr],10), trimmean([BRX_indivStats2.RTincorr],10) ];
 error_matrix = [nanstd([BRX_indivStats.RTcorr]), nanstd([BRX_indivStats.RTincorr]); nanstd([BRX_indivStats2.RTcorr]), nanstd([BRX_indivStats2.RTincorr])];
 scale_factor = 1/10;
 error_matrix = error_matrix./sqrt(numel(BRX_indivStats));
 barwitherr(error_matrix*scale_factor,(mean_matrix-350)*scale_factor);
 set(gca,'XTickLabel',{'Young','Old'});
 legend('Correct','Incorrect');
 title('RT');
 
 RT_anova_data(:,1) = [[BRX_indivStats.RTcorr]'; [BRX_indivStats2.RTcorr]'];
 RT_anova_data(:,2) = [[BRX_indivStats.RTincorr]'; [BRX_indivStats2.RTincorr]'];
 RT_anova_groups = [zeros(length(BRX_indivStats),1); ones(length(BRX_indivStats),1) ];
 tbl = simple_mixed_anova(RT_anova_data,RT_anova_groups,{'Age_Group'},{'Feedback'});
 disp(tbl); 
 
end

end