
dbstop if error;
warning off;
%% Initialise variables

loopNum = 1; 

%initialise;
acc_SMA = zeros(1,schemaNum);
time = 0; RTs = []; Accuracy = []; out_win_sma = [];
% initialise winning channel
fed_channel = randi([1, schemaNum],1,5000); % select next random winning channel

threshold = 9;

%beta_str = 0.5*ones(1,schemaNum);
%beta_sma = 0.5*ones(1,schemaNum);

trial_num = 1;

environment;

for tt = 2:timeSteps-1
for loop = 1:loopNum
       
       % feed a random channel (fed_channel) 
       % 
       
       % o_ENV(fed_channel(trial_num),tt) = satlin(o_ENV(fed_channel(trial_num),tt) + 0.1);
       beta_sma = 0.5*ones(1,schemaNum);
       beta_sma(fed_channel(trial_num)) = 0.40;
       
       sma; 
       basalGanglia;   
       thalamus;
       
       % integrate and calculate which schema is active first.
       for ch = 1:schemaNum
        acc_SMA(ch) = acc_SMA(ch) + o_SMA(ch,tt); 
        time = time + 1;
       end
       if any(acc_SMA > threshold)  %select the schema that exceed the threshold 
           RTs = [RTs time]; % append RT
           max_idx = find(acc_SMA == max(acc_SMA));
           Accuracy = [Accuracy (max_idx == fed_channel(trial_num))];
           
           %out_win_sma = [out_win_sma mean(o_SMA(winning_channel, (tt-20)*(tt>20)+1:tt ))];
           acc_SMA = zeros(1,schemaNum); % reset channels
           time = 0;    % reset timer
           trial_num = trial_num + 1;  % increase trial counter
       end    
end
end

[fit_vector,negLL] = exgauss_fit(RTs);

% Output
%%{
exgauss_plot('pdf', RTs, fit_vector)

fprintf('%2.0f trials computed\n', length(RTs));
fprintf('Mean RTs: %3.2f \n', mean(RTs));
fprintf('Median RTs: %3.2f \n', median(RTs));
fprintf('Skewness (third moment) RTs: %2.2f \n', skewness(RTs));
fprintf('Skewness (median) RTs: %2.2f \n', 3*(mean(RTs)-median(RTs))/std(RTs));
fprintf('Accuracy: %1.3f \n', mean(Accuracy));

%}
