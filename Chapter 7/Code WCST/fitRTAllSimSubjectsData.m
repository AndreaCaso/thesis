% Use allfitdata to fit data with each participants RT
% distributions and then save the parameters them in a structure
% usage example: 
% [RTfit] = fitRTAllSubjectsData(WCST_indivStats);
% 

function [RTSimfit] = fitRTAllSimSubjectsData(subj_sim_wcst)

    untimed_matrix = []; timed_matrix = [];
    for subj_num = 1:length(subj_sim_wcst)
        
        [Xfit,~,~,~] = exgauss_fit(subj_sim_wcst(subj_num).RT);
        RTSimfit(subj_num).untimed.all.mu = Xfit(1);
        RTSimfit(subj_num).untimed.all.sigma = Xfit(2);
        RTSimfit(subj_num).untimed.all.tau = Xfit(3);
        
        %{ 
        [Xfit,~,~,~] = exgauss_fit(subj_sim_wcst(subj_num));
        RTSimfit(subj_num).untimed.corr.mu = Xfit(1);
        RTSimfit(subj_num).untimed.corr.sigma = Xfit(2);
        RTSimfit(subj_num).untimed.corr.tau = Xfit(3);
        
        [Xfit,~,~,~] = exgauss_fit(subj_sim_wcst(subj_num));
        RTSimfit(subj_num).untimed.incorr.mu = Xfit(1);
        RTSimfit(subj_num).untimed.incorr.sigma = Xfit(2);
        RTSimfit(subj_num).untimed.incorr.tau = Xfit(3);
        %}
        
        
    end
    
end