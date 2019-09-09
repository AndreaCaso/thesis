% Run several subjects 

function performance = runChannels(subjects)
    bg_mod = [0.0:0.25:1.5];
    nn = 1;
    initialise;
    performance =  struct();
 for subj_num = 1:subjects
    for bg_num = 1:length(bg_mod)
     
         bg_modf = bg_mod(bg_num);
         runP;
         % fit gaussian
     
        param_fit = exgauss_fit(RTs);
        performance(bg_num).mu(subj_num) = param_fit(1);
        performance(bg_num).sigma(subj_num) = param_fit(2);
        performance(bg_num).tau(subj_num) = param_fit(3);
     
        performance(bg_num).nlogL(subj_num) = exgauss_neg_lnl(RTs,param_fit);
        performance(bg_num).chi(subj_num) = exgauss_chi_square(RTs,param_fit);
     
        performance(bg_num).MeanAcc(subj_num) = mean(Acc); % Mean Accuracy
        performance(bg_num).medianRT(subj_num) = median(RTs); % Median RT
        performance(bg_num).bg_mod(subj_num) = bg_modf;
        performance(bg_num).win_out(subj_num) = mean(out_win_sma);
     
        fprintf('%1.0f of %1.0f \n',subj_num,subjects);
      
    end
 end

end