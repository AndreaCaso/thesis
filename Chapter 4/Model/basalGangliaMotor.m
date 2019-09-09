for ss = [1 2 3 4]
    %% STRIATUM D1
    u_ST1_SMA(ss,tt) = o_SMA(ss,tt);
    a_ST1_SMA(ss,tt) = (decay_constant)*a_ST1_SMA(ss,tt-1) + (1-decay_constant)*u_ST1_SMA(ss,tt); 
    o_ST1_SMA(ss,tt) = sigmf(a_ST1_SMA(ss,tt), [alpha_str_sma(ss) beta_str_sma(ss)]);
    
end
for ss = [1 2 3 4]
    %% STRIATUM D2
    u_ST2_SMA(ss,tt) = o_SMA(ss,tt);
    a_ST2_SMA(ss,tt) = (decay_constant)*a_ST2_SMA(ss,tt-1) + (1-decay_constant)*u_ST2_SMA(ss,tt); 
    o_ST2_SMA(ss,tt) = sigmf(a_ST2_SMA(ss,tt), [alpha_str_sma(ss) beta_str_sma(ss)]);
 
end 
for ss = [1 2 3 4]
    %% STN
    u_STN_SMA(ss,tt) = o_SMA(ss,tt).* W_STN + o_GPe_SMA(ss,tt-1) .* W_GPe_STN;
    a_STN_SMA(ss,tt) = (decay_constant)*a_STN_SMA(ss,tt-1) + (1-decay_constant)*u_STN_SMA(ss,tt); 
    o_STN_SMA(ss,tt) = sigmf(a_STN_SMA(ss,tt), [alpha_stn beta_stn_sma(ss)]);
  
end
for ss = [1 2 3 4]
    %% GPe 
    u_GPe_SMA(ss,tt)  = (sum(o_STN_SMA(:,tt)) .* W_STN_GPe) + (o_ST2_SMA(ss,tt) .* W_ST2_GPe);
    a_GPe_SMA(ss,tt) = (decay_constant)*a_GPe_SMA(ss,tt-1) + (1-decay_constant)*u_GPe_SMA(ss,tt); 
    o_GPe_SMA(ss,tt) = sigmf(a_GPe_SMA(ss,tt), [alpha_gpe beta_gpe_sma(ss)]);
  
end
for ss = [1 2 3 4]
    %% GPi
    u_GPi_SMA(ss,tt) = (sum(o_STN_SMA(:,tt)) .* W_STN_GPi) + (o_GPe_SMA(ss,tt-1) .* W_GPe_GPi) + (o_ST1_SMA(ss,tt-1) .* W_ST1_GPi);
    a_GPi_SMA(ss,tt) = (decay_constant)*a_GPi_SMA(ss,tt-1) + (1-decay_constant)*u_GPi_SMA(ss,tt); 
    o_GPi_SMA(ss,tt) = sigmf(a_GPi_SMA(ss,tt), [alpha_gpi beta_gpi_sma(ss)]);

end
%% Output
    