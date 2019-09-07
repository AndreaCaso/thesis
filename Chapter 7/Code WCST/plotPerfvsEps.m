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
              mean_param = mean(PerfvsEps(nn).untimed.all);
              se_param = std(PerfvsEps(nn).untimed.all)/sqrt(length(PerfvsEps));
              
              mean_mu(nn) = mean_param(1); se_mu(nn) = se_param(1);
              mean_sigma(nn) = mean_param(2); se_sigma(nn) = se_param(2);
              mean_tau(nn) = mean_param(3); se_tau(nn) = se_param(3);
              
              mean_TE(nn) = mean(PerfvsEps(nn).TE);
              mean_PE(nn) = mean(PerfvsEps(nn).PE);
              mean_SL3(nn) = mean(PerfvsEps(nn).SL3);
              mean_RTmedian(nn) = mean(PerfvsEps(nn).RTmedian);
              
              se_TE(nn) = std(PerfvsEps(nn).TE)/sqrt(length(PerfvsEps));
              se_PE(nn) = std(PerfvsEps(nn).PE)/sqrt(length(PerfvsEps));
              se_SL3(nn) = std(PerfvsEps(nn).SL3)/sqrt(length(PerfvsEps));
              se_RTmedian(nn) = std(PerfvsEps(nn).RTmedian)/sqrt(length(PerfvsEps));
    end
    
            figure; hold on;
            subplot(3,1,1)
            %plot(x_axis,mean_mu/max(mean_mu),'s-');
            errorbar(x_axis,(mean_mu),se_mu,'bs-');
            %ylim([-2 2])
            %refline([0 0]);
            ylabel('\mu (norm)')
            xlabel(eps_xlabel);
            subplot(3,1,2)
            %plot(x_axis,normalize(mean_sigma),'s-');
            errorbar(x_axis,(mean_sigma),se_sigma,'bs-');
            %ylim([-2 2])
            %refline([0 0]);
            ylabel('\sigma (norm)');
            xlabel(eps_xlabel);
            subplot(3,1,3)
            %plot(x_axis,normalize(mean_tau),'bs-');
            errorbar(x_axis,(mean_tau),se_tau,'bs-');
            %ylim([-4 4]);
            %refline([0 0]);
            ylabel('\tau (norm)');
            xlabel(eps_xlabel);
            
            figure; hold on;
            subplot(4,1,1)
            %plot(x_axis,mean_TE,'bs-');
            errorbar(x_axis,mean_TE,se_TE,'bs-');
            xlabel('\epsilon_{pfc}');
            ylabel('TE');
            %ylim([5,40]);
            subplot(4,1,2)
            %plot(x_axis,mean_PE,'s-');
            errorbar(x_axis,mean_PE,se_PE,'bs-');
            xlabel(eps_xlabel);
            %ylim([5,40]);
            ylabel('PE');
            subplot(4,1,3)
            %plot(x_axis,mean_SL3,'s-');
            errorbar(x_axis,mean_SL3,se_SL3,'bs-');
            %ylim([0,2]);
            xlabel(eps_xlabel);
            ylabel('SL3')
            subplot(4,1,4)
            %plot(x_axis,mean_RTmedian,'s-');
            errorbar(x_axis,mean_RTmedian,se_RTmedian,'bs-');
            xlabel(eps_xlabel);
            ylabel('median RT')
          
end 