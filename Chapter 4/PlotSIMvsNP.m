%% Against neuropsychological data 

%clear; 
load('SIMYoungData.mat');
load('NPYoungData.mat');
%figure;

%% Plot Category Number
subplot(3,2,1);
hold on;

bar_data_mean = [mean(catNumYoungSim'),mean(catNumYoungNP')];
bar_data_std = [std(catNumYoungSim'),std(catNumYoungNP')];
bar([1,2],bar_data_mean,0.5); 
errorbar([1,2],bar_data_mean,bar_data_std/sqrt( size(catNumYoungSim,2) ));
set(gca,'XTick', [1 2]);
set(gca,'XTickLabel',{'Sim', 'Data'});
xlabel('CC');
ylim([-0.0 6]);

z_value = (nanmean(catNumYoungSim') - nanmean(catNumYoungNP'))/( (nanstd(catNumYoungNP')) );
[~,p_value,~,t_stats] = ttest2(catNumYoungSim',catNumYoungNP');
t_value = num2str(round(t_stats.tstat, 2, 'decimal'));
p_value = num2str(round(p_value, 2, 'decimal'));
z_value = num2str(abs(round(z_value, 2, 'decimal')));

title(['Z value = ', z_value],'FontSize',9);

%% Plot Set Loss 
subplot(3,2,2)
hold on;

bar_data_mean = [mean(SLYoungSim'),mean(SLYoungNP')];
bar_data_std = [std(SLYoungSim'),std(SLYoungNP')];
bar([1,2],bar_data_mean,0.5);
errorbar([1,2],bar_data_mean,bar_data_std/sqrt( size(catNumYoungSim,2) ));
set(gca,'XTick', [1 2]);
set(gca,'XTickLabel',{'Sim', 'Data'});
xlabel('SL');
ylim([-0.3 1])

z_value = (nanmean(SLYoungSim') - nanmean(SLYoungNP'))/( (nanstd(SLYoungNP')) );
[~,p_value,~,t_stats] = ttest2(SLYoungSim',SLYoungNP');
t_value = num2str(round(t_stats.tstat, 2, 'decimal'));
p_value = num2str(round(p_value, 2, 'decimal'));
z_value = num2str(abs(round(z_value, 2, 'decimal')));

title(['Z value = ', z_value],'FontSize',9);

%% Plot Perseverative Response
subplot(3,2,3)
hold on;

bar_data_mean = [mean(PRYoungSim'),mean(PRYoungNP')];
bar_data_std = [std(PRYoungSim'),std(PRYoungNP')];
bar([1,2],bar_data_mean,0.5);
errorbar([1,2],bar_data_mean,bar_data_std/sqrt( size(PRYoungSim,2) ));
set(gca,'XTick', [1 2]);
set(gca,'XTickLabel',{'Sim', 'Data'});
xlabel('PR');
ylim([-0.05 65])

z_value = (nanmean(PRYoungSim') - nanmean(PRYoungNP'))/( (nanstd(PRYoungNP')) );
[~,p_value,~,t_stats] = ttest2(PRYoungSim',PRYoungNP');
t_value = num2str(round(t_stats.tstat, 2, 'decimal'));
p_value = num2str(round(p_value, 2, 'decimal'));
z_value = num2str(abs(round(z_value, 2, 'decimal')));

title(['Z value = ', z_value],'FontSize',9);

%% Plot Perseverative Errors
subplot(3,2,4)
hold on;

bar_data_mean = [mean(PEYoungSim'),mean(PEYoungNP')];
bar_data_std = [std(PEYoungSim'),std(PEYoungNP')];
bar([1,2],bar_data_mean,0.5);
errorbar([1,2],bar_data_mean,bar_data_std/sqrt( size(PEYoungSim,2) ));
set(gca,'XTick', [1 2]);
set(gca,'XTickLabel',{'Sim', 'Data'});
xlabel('PE');
ylim([-0.05 20])

z_value = (nanmean(PEYoungSim') - nanmean(PEYoungNP'))/( (nanstd(PEYoungNP')));
[~,p_value,~,t_stats] = ttest2(PEYoungSim,PEYoungNP');
t_value = num2str(round(t_stats.tstat, 2, 'decimal'));
p_value = num2str(round(p_value, 2, 'decimal'));
z_value = num2str(abs(round(z_value, 2, 'decimal')));

title(['Z value = ', z_value],'FontSize',9);

%% Plot Total Errors
subplot(3,2,5)
hold on;

bar_data_mean = [nanmean(TEYoungSim'),nanmean(TEYoungNP')];
bar_data_std = [nanstd(TEYoungSim'),nanstd(TEYoungNP')];
bar([1,2],bar_data_mean,0.5);
errorbar([1,2],bar_data_mean,bar_data_std/sqrt( size(TEYoungSim,2) ));
set(gca,'XTick', [1 2]);
set(gca,'XTickLabel',{'Sim', 'Data'});
xlabel('TE');
ylim([0 20]);

z_value = (nanmean(TEYoungSim') - nanmean(TEYoungNP'))/( (nanstd(TEYoungNP')) );
[~,p_value,~,t_stats] = ttest2(TEYoungSim,TEYoungNP');
t_value = num2str(round(t_stats.tstat, 2, 'decimal'));
p_value = num2str(round(p_value, 2, 'decimal'));
z_value = num2str(abs(round(z_value, 2, 'decimal')));

title(['Z value = ', z_value],'FontSize',9);

%% Plot Non-Perseverative Errors
subplot(3,2,6)
hold on;
%NPEYoungSim(NPEYoungSim > 32) = NaN;  % outliers out
%NPEYoungNP(NPEYoungNP > 32) = NaN;    % outliers out

bar_data_mean = [nanmean(NPEYoungSim'),nanmean(NPEYoungNP')];
bar_data_std = [nanstd(NPEYoungSim'),nanstd(NPEYoungNP')];
bar([1,2],bar_data_mean,0.5);
errorbar([1,2],bar_data_mean,bar_data_std/sqrt( size(NPEYoungSim,2) ));
set(gca,'XTick', [1 2]);
set(gca,'XTickLabel',{'Sim', 'Data'});
xlabel('NPE');
ylim([-0.05 10])

z_value = (nanmean(NPEYoungSim') - nanmean(NPEYoungNP'))/( (nanstd(NPEYoungNP')) );
[~,p_value,~,t_stats] = ttest2(NPEYoungSim,NPEYoungNP');
t_value = num2str(round(t_stats.tstat, 2, 'decimal'));
p_value = num2str(round(p_value, 2, 'decimal'));
z_value = num2str(abs(round(z_value, 2, 'decimal')));

title(['Z value = ', z_value],'FontSize',9);
