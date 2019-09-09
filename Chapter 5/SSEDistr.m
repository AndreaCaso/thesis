
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SSEDistr outputs cells with the SSE statistics given
% by the sum(Oi-Ei)^2 after bootstrapping over the values
% type: cell = SSEDistr(int,int,vector,vector)
%
% Example usage:
% SS_E = SSEDistr(50, 1, YoungNPdataSET{1}(:,1),YoungSIMclusterSET{1}(:,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function SS_E = SSEDistr(bstrp_num, group_num, varargin)
    
    noise = 0.0001*randn(1,bstrp_num*5);
    rng('shuffle');
    groups = (nargin - 2)/2;
    SS_E = cell(1,groups);
   
    for nn = 1:groups
       for ss = 1:bstrp_num
         bstrpO = varargin{nn}(randi([1 size(varargin{nn},1)],1,size(varargin{nn},1)),:);
         bstrpE = varargin{nn+group_num}(randi([1 size(varargin{nn+group_num},1)],1,size(varargin{nn+group_num},1)),:);
        
         propO = histcounts(bstrpO,0:35);
         propO = propO/sum(propO);
         propE = histcounts(bstrpE,0:35);
         propE = propE/sum(propE);
         
         SS_E{nn}(ss) = sum((propE - propO + noise(ss*nn)).^2);
        
        end
    end
    
end