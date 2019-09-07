% It plots the plot for mu, sigma, tau for different epsilon
% usage: 
% plotPerfvsEps(PerfvsEpsPfc,'pfc')
% plotPerfvsEps(PerfvsEpsStr,'str')

function plotPerfvsEps(PerfvsEps,eps_type)
    
    switch eps_type
        case 'pfc'
            x_axis  = [PerfvsEps.eps_pfc];
            eps_xlabel = '\epsilon_{pfc}';
        case 'str'
            x_axis = [PerfvsEps.eps_str];
            eps_xlabel = '\epsilon_{str}';
    end
            
    for nn = 1:length(PerfvsEps) 
        
              mean_TE(nn) = mean(PerfvsEps(nn).TE);
              mean_PRE(nn) = mean(PerfvsEps(nn).PRE);
              mean_PRU(nn) = mean(PerfvsEps(nn).PRU);
              mean_PRSRE(nn) = mean(PerfvsEps(nn).PRSRE);
              
              mean_RT(nn) = nanmean(PerfvsEps(nn).RT);
              mean_RTcorr(nn) = nanmean(PerfvsEps(nn).RTcorr);
              mean_RTincorr(nn) = nanmean(PerfvsEps(nn).RTincorr);
              
              se_TE(nn) = std(PerfvsEps(nn).TE)/sqrt(length(PerfvsEps));
              se_PRE(nn) = std(PerfvsEps(nn).PRE)/sqrt(length(PerfvsEps));
              se_PRU(nn) = std(PerfvsEps(nn).PRU)/sqrt(length(PerfvsEps));
              se_PRSRE(nn) = std(PerfvsEps(nn).PRSRE)/sqrt(length(PerfvsEps));
              
              se_RT(nn) = std(PerfvsEps(nn).RT)/sqrt(length(PerfvsEps));
              se_RTcorr(nn) = std(PerfvsEps(nn).RTcorr)/sqrt(length(PerfvsEps));
              se_RTincorr(nn) = std(PerfvsEps(nn).RTincorr)/sqrt(length(PerfvsEps));
              
    end
    
            figure; hold on;
            subplot(4,1,1)
            errorbar(x_axis,mean_TE,se_TE,'bs-');
            ylabel('TE');
    
            subplot(4,1,2)
            errorbar(x_axis,mean_PRE,se_PRE,'bs-');
            ylabel('PRE');
            
            subplot(4,1,3)
            errorbar(x_axis,mean_PRU,se_PRU,'bs-');
            ylabel('PRU');
            
            subplot(4,1,4)
            errorbar(x_axis,mean_PRSRE,se_PRSRE,'bs-');
            ylabel('PRSRE');
            
            figure;
            subplot(4,1,1)
            errorbar(x_axis,mean_RT,se_RT,'bs-');
            ylabel('RT');
            
            subplot(4,1,2)
            errorbar(x_axis,mean_RTcorr,se_RTcorr,'bs-');
            ylabel('RT (correct)');
            
            subplot(4,1,3)
            errorbar(x_axis,mean_RTincorr,se_RTincorr,'bs-');
            ylabel('RT (incorrect)');
            
            subplot(4,1,4)
            errorbar(x_axis,mean_RTincorr-mean_RTcorr,se_RTincorr,'bs-');
            ylabel('RT (incorrect-correct)');
            
          
end 