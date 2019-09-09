clear;
load('GenAlgClusterData.mat');

%% Clustering data from simulations with different parameters
% Create the YoungSIMclusterSET

[~,index] = sortrows([genome1.totalFit].'); genome1 = genome1(index(end:-1:1)); clear index; 
YoungSIMclusterSET{1} = genome1(15).dependent;

[~,index] = sortrows([genome2.totalFit].'); genome2 = genome2(index(end:-1:1)); clear index; 
YoungSIMclusterSET{2} = genome2(9).dependent;

[~,index] = sortrows([genome3.totalFit].'); genome3 = genome3(index(end:-1:1)); clear index; 
YoungSIMclusterSET{3} = genome3(6).dependent;

[~,index] = sortrows([genome4.totalFit].'); genome4 = genome4(index(end:-1:1)); clear index; 
YoungSIMclusterSET{4} = genome4(1).dependent;

[~,index] = sortrows([genome5.totalFit].'); genome5 = genome5(index(end:-1:1)); clear index;
YoungSIMclusterSET{5} = genome5(7).dependent;

%% Plotting data from different parameters
figure; %subplot(2,1,1)
hold on;
cols = {[0 0 1],[1 0.8 0],[0.91 0.41 0.17],[1 0 0],[0 1 0]};
for cc = 1:5

%% Bootstrapping to match the same number of elements of the NP data
%YoungSIMclusterSETboot{cc} = bootstrp(length(YoungNPdataSET{cc}),@mean,YoungSIMclusterSET{cc})    
sc3 = scatter3(YoungSIMclusterSET{cc}(:,1),YoungSIMclusterSET{cc}(:,2),YoungSIMclusterSET{cc}(:,3),30,'filled');
grid on;
set(sc3, 'CData', cols{cc});
%(sc3, 'MarkerEdgeColor', 'k');

end
xlabel('TE');
ylabel('PE');
zlabel('SL');
xlim([5 35]);
ylim([0 40])
zlim([0 2]);

%% Aggregate all the data
% Outliers are considered those values less than 0.5 times the
% minimum value and greater than 1.5 times the maximum value
% of in the correspondent 
outlier_coeff = 1.9;

for cc = 1:5
   
    YoungSIMclusterSETmean{cc} = mean(YoungSIMclusterSET{cc});
    YoungSIMclusterSETmedian{cc} = median(YoungSIMclusterSET{cc});
    YoungSIMclusterSETstd{cc} = std(YoungSIMclusterSET{cc});
    YoungSIMclusterSETiqr{cc} = iqr(YoungSIMclusterSET{cc});
    exclude_indx = zeros(1,size(YoungNPdataSET{cc},1));
 
 for indx = 1:size(YoungSIMclusterSET{cc},1)
     if any(YoungSIMclusterSET{cc}(indx,:) < (2-outlier_coeff)*min(YoungNPdataSET{cc}))
         exclude_indx(indx) = indx;
     end
     if any(YoungSIMclusterSET{cc}(indx,:) > (outlier_coeff)*max(YoungNPdataSET{cc} ))
         exclude_indx(indx) = indx;
     end
 end
 exclude_indx = exclude_indx(exclude_indx~=0);

 YoungSIMclusterSET{cc}(exclude_indx,:) = [];
 fprintf('Set %1.0f size: %1.0f\n',cc,size(YoungSIMclusterSET{cc},1));
 
end

YoungSIMclusterFULL = [YoungSIMclusterSET{1}; YoungSIMclusterSET{2}; YoungSIMclusterSET{3}; YoungSIMclusterSET{4}; YoungSIMclusterSET{5}];
YoungNPdataFULL = [YoungNPdataSET{1}; YoungNPdataSET{2}; YoungNPdataSET{3}; YoungNPdataSET{4}; YoungNPdataSET{5}];

btstrp_num = 1000;

%% Bootstrap individual groups (SIM)
for cc = 1:5
    YoungSIMclusterSETbtstrp{cc} =  bootstrp(btstrp_num/5,@mean,YoungSIMclusterSET{cc});
    YoungNPdataSETbtstrp{cc} = bootstrp(btstrp_num/5,@mean,YoungNPdataSET{cc});
end

YoungSIMclusterFULLbtstrp = [YoungSIMclusterSETbtstrp{1}; YoungSIMclusterSETbtstrp{2}; YoungSIMclusterSETbtstrp{3}; YoungSIMclusterSETbtstrp{4}; YoungSIMclusterSETbtstrp{5}];
YoungNPdataFULLbtstrp = [YoungNPdataSETbtstrp{1}; YoungNPdataSETbtstrp{2}; YoungNPdataSETbtstrp{3}; YoungNPdataSETbtstrp{4}; YoungNPdataSETbtstrp{5}];

corrplot(YoungNPdataFULLbtstrp,'type','Pearson','testR','on','alpha',0.01,'varNames',{'TE','PE','SL'});
title('Bootstrapped Neuropsychological Data Across Groups');
corrplot(bootstrp(btstrp_num,@mean,YoungNPdataFULL),'type','Pearson','testR','on','alpha',0.01,'varNames',{'TE','PE','SL'});

corrplot(YoungSIMclusterFULLbtstrp,'type','Pearson','testR','on','alpha',0.01,'varNames',{'TE','PE','SL'});
corrplot(bootstrp(btstrp_num,@mean,YoungSIMclusterFULL),'type','Pearson','testR','on','alpha',0.01,'varNames',{'TE','PE','SL'});

for cc = 1:5
    
    fprintf('Group %1.0f\n',cc);
    fprintf('Elements: %1.0f\n',size(YoungSIMclusterSET{cc},1));
    fprintf('TE: M = %1.2f, SD = %1.2f\n',mean(YoungSIMclusterSET{cc}(:,1)),std(YoungSIMclusterSET{cc}(:,1)));
    fprintf('PE: M = %1.2f, SD = %1.2f\n',mean(YoungSIMclusterSET{cc}(:,2)),std(YoungSIMclusterSET{cc}(:,2)));
    fprintf('SL: M = %1.2f, SD = %1.2f\n',mean(YoungSIMclusterSET{cc}(:,3)),std(YoungSIMclusterSET{cc}(:,3)));
    fprintf('\n');
    
end