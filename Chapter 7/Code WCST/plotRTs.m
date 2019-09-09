% The function plots the RTs for correct and incorrect
% If there is just one argument, it divides in young and old
% otherwise the first argument is young and the other old

function plotRTs(WCST_indivStats, WCST_indivStats2)
 
if nargin == 1  % It's one stat file
    
 young_idx = [WCST_indivStats.Age] <= 60;
 old_idx = [WCST_indivStats.Age] > 60;
 
 mean_matrix = [nanmean([WCST_indivStats(young_idx).RTcorr]), nanmean([WCST_indivStats(young_idx).RTincorr]); nanmean([WCST_indivStats(old_idx).RTcorr]), nanmean([WCST_indivStats(old_idx).RTincorr])];
 error_matrix = [nanstd([WCST_indivStats(young_idx).RTcorr]), nanstd([WCST_indivStats(young_idx).RTincorr]); nanstd([WCST_indivStats(old_idx).RTcorr]), nanstd([WCST_indivStats(old_idx).RTincorr])];
 
 barwitherr(error_matrix,mean_matrix);
 set(gca,'XTickLabel',{'Young','Old'});
 legend('Correct','Incorrect')
 title('RT')
 
end

if nargin == 2  % It's two stat file
    
 mean_matrix = [nanmedian([WCST_indivStats.RTcorr]), nanmedian([WCST_indivStats.RTincorr]); nanmedian([WCST_indivStats2.RTcorr]), nanmedian([WCST_indivStats2.RTincorr])];
 error_matrix = [nanstd([WCST_indivStats.RTcorr]), nanstd([WCST_indivStats.RTincorr]); nanstd([WCST_indivStats2.RTcorr]), nanstd([WCST_indivStats2.RTincorr])];

 barwitherr(error_matrix/sqrt(25),(mean_matrix-420)/14.86*3.405);
 set(gca,'XTickLabel',{'Young','Old'});
 legend('Correct','Incorrect')
 title('RT')
 
 
end

end