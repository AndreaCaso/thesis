%{ 
for cc = 1:5
 SS_E(cc).TE = SSEDistr(200000, 1, YoungNPdataSET{cc}(:,1),YoungSIMclusterSET{cc}(:,1));
 SS_E(cc).PE = SSEDistr(200000, 1, YoungNPdataSET{cc}(:,2),YoungSIMclusterSET{cc}(:,2));
 SS_E(cc).SL = SSEDistr(200000, 1, YoungNPdataSET{cc}(:,3),YoungSIMclusterSET{cc}(:,3));
end

save('SS_E.mat','SS_E');
%}

load('SS_E.mat') %Load results from Sum of Squared Error distribution in order to
                 %draw histograms

obsStat = zeros(5,3);
for gg = 1:5
  for ee = 1:3
 
   propO = histcounts(YoungNPdataSET{gg}(:,ee),0:35);
   propO = propO/sum(propO);
   propE = histcounts(YoungSIMclusterSET{gg}(:,ee),0:35);
   propE = propE/sum(propE);
   
   obsStat(gg,ee) = sum((propE - propO).^2);
   obsStat(gg,ee) = round(obsStat(gg,ee),2);
   
 end
end
 
 for gg = 1:5
 for ee = 1:3
  pp = ee + 3*(gg-1);
  subplot(5,3,pp);
  switch ee
   case 1
    histogram(cell2mat(SS_E(gg).TE));
    p_value = round(mean(cell2mat(SS_E(gg).TE) > obsStat(gg,ee)),3);
    xlabel(['P(SS_{E}>',num2str(obsStat(gg,ee)),')=',num2str(p_value)]);
    title(['TE (',num2str(gg),')']);
   case 2
    histogram(cell2mat(SS_E(gg).PE));
    p_value = round(mean(cell2mat(SS_E(gg).PE) > obsStat(gg,ee)),3);
    xlabel(['P(SS_{E}>',num2str(obsStat(gg,ee)),')=',num2str(p_value)]);
    title(['PE (',num2str(gg),')']);
   case 3       
    histogram(cell2mat(SS_E(gg).SL));
    p_value = round(mean(cell2mat(SS_E(gg).SL) > obsStat(gg,ee)),3);
    xlabel(['P(SS_{E}>',num2str(obsStat(gg,ee)),')=',num2str(p_value)]);
    title(['SL (' ,num2str(gg),')']);
  end
 end
end

