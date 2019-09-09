function isUn = isUnambigous(featureTrialInput,trial,nn)
% checks that the last nn trials of
% the vector input are unambigous
isUn = 0;
  
if sum(~cellfun(@isempty, featureTrialInput)) > nn   
                
                lastNNFeatTrials = cellstr(featureTrialInput(trial-nn:trial-1));
                for ii = 1:nn
                
                    lastNNFeatTrialsLength(ii) = length(lastNNFeatTrials{ii});
                
                end
                if any(lastNNFeatTrialsLength == 1) % unumbigous responses
                    
                    isUn = 1;
                
                end
end
            
end