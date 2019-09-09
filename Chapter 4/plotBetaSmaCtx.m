%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function plots the curves beta_str and beta_ctx against all the dependent variables
% Usage example:
% plotBetaSmaCtx(parameterSTR,parameterCTX,{'TE','PE','SL','NPE'},dependent_vars.TE,dependent_vars.PE,dependent_vars.SL,dependent_vars.NPE);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plotBetaSmaCtx(paramSTR, paramCTX, y_labels, varargin)

warning('off');
%% parameters must be AxBxC matrices
subplot_num = length(varargin);
pl = [0 0 0]; epl = pl;
clr={'r';'b';'k';'m';'y'};

%% register labels for the legend
for ss = 1:length(paramCTX)
  leg_labels{ss} = ['\beta_{ctx} = ', num2str(paramCTX(ss))];
end
%% plots
figure;
for ss = 1:subplot_num
    subplot(ceil(subplot_num/2),floor(subplot_num/2),ss);
    mean_across_runs = mean(varargin{ss},3); % matrix
    std_across_runs = std(varargin{ss},0,3); % matrix
    alignm = linspace(-1,+1,length(paramSTR))'; % used to slightly misalign the data to make it more readable
    alignm = repmat(alignm,1,length(paramSTR));
    alignm= 0.01*alignm; 
    for ii = 1:size(varargin{ss},1)
        hold on;
        
        pl(ii) = plot(paramSTR + alignm(ii,:), mean_across_runs(ii,:),'s-');
        
        epl(ii) = errorbar(paramSTR + alignm(ii,:), mean_across_runs(ii,:),std_across_runs(ii,:)/sqrt(size(varargin{ss},3)));
        
        set(pl(ii),'Color',char(clr(ii))); 
        set(epl(ii),'Color',char(clr(ii))); 
    end 
    
    %legend(pl,['\beta_{ctx} = ', num2str(paramCTX(1))],['\beta_{ctx} = ', num2str(paramCTX(2))],['\beta_{ctx} = ', num2str(paramCTX(3))]);
   % legend(pl,leg_labels);
    
    %xlabel('\beta_{str}');
    ylabel(char(y_labels(ss)));
    %xlim([0.2 0.8]);
    hold off
    %ylabel([]);
end


end