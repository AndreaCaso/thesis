%%%%%%%%%%%%%%%%%%%%%
% This script plot the performance from the structure performance
% Usage example:
% 
% PlotPerformanceContour(cat(1,performance.beta_str),cat(1,performance.beta_sma),{'\beta_{str}','\beta_{sma}'},{'TE','PE','SL','NPE'},cat(1,performance.TE),cat(1,performance.PE),cat(1,performance.SL),cat(1,performance.NPE))
%
%%%%%%%%%%%%%%%%%%%%
function PlotPerformanceContour(performanceX,performanceY,xy_LABEL,z_LABELS,varargin)

meshDens = 0.1;
%%%% Contour first

x_str = performanceX;
y_sma = performanceY;
[xq,yq] = meshgrid(min(x_str):meshDens:max(x_str),min(y_sma):meshDens:max(y_sma));

for nn = 1:nargin-4
 z_VAR{nn} = mean(varargin{nn},2);
end 

for nn = 1:nargin-4
 subplot(ceil((nargin-4)/2),floor((nargin-4))/2,nn);
 vq = griddata(x_str,y_sma,z_VAR{nn},xq,yq);
 contourf(xq,yq,vq);
 xlabel(xy_LABEL{1});
 ylabel(xy_LABEL{2});
 title(z_LABELS{nn});
end

end