for ss = randperm(schemaNum)
    %% STRIATUM D1
    u_ST1(ss,tt) = o_SMA(ss,tt);
    a_ST1(ss,tt) = (decay_constant)*a_ST1(ss,tt-1) + (1-decay_constant)*u_ST1(ss,tt); 
    o_ST1(ss,tt) = sigmf(a_ST1(ss,tt), [alpha_str beta_str(ss)]);
    
end
for ss = randperm(schemaNum)
    %% STRIATUM D2
    u_ST2(ss,tt) = o_SMA(ss,tt);
    a_ST2(ss,tt) = (decay_constant)*a_ST2(ss,tt-1) + (1-decay_constant)*u_ST2(ss,tt); 
    o_ST2(ss,tt) = sigmf(a_ST2(ss,tt), [alpha_str beta_str(ss)]);
 
end
for ss = randperm(schemaNum)
    %% STN
    u_STN(ss,tt) = o_SMA(ss,tt).* W_STN + o_GPe(ss,tt-1) .* W_GPe_STN;
    a_STN(ss,tt) = (decay_constant)*a_STN(ss,tt-1) + (1-decay_constant)*u_STN(ss,tt); 
    o_STN(ss,tt) = sigmf(a_STN(ss,tt), [alpha_stn beta_stn(ss)]);
  
end
for ss = randperm(schemaNum)
    %% GPe 
    u_GPe(ss,tt)  = (sum(o_STN(:,tt)) .* W_STN_GPe) + (o_ST2(ss,tt) .* W_ST2_GPe);
    a_GPe(ss,tt) = (decay_constant)*a_GPe(ss,tt-1) + (1-decay_constant)*u_GPe(ss,tt); 
    o_GPe(ss,tt) = sigmf(a_GPe(ss,tt), [alpha_gpe beta_gpe(ss)]);
  
end
for ss = randperm(schemaNum)
    %% GPi
    u_GPi(ss,tt) = (sum(o_STN(:,tt)) .* W_STN_GPi) + (o_GPe(ss,tt-1) .* W_GPe_GPi) + (o_ST1(ss,tt-1) .* W_ST1_GPi);
    a_GPi(ss,tt) = (decay_constant)*a_GPi(ss,tt-1) + (1-decay_constant)*u_GPi(ss,tt); 
    o_GPi(ss,tt) = sigmf(a_GPi(ss,tt), [alpha_gpi beta_gpi(ss)]);

end
%% Output
    