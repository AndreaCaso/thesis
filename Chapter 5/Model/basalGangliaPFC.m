for ss = [1 2 3]
    %% STRIATUM D1
    u_ST1_PFC(ss,tt) = o_PFC(ss,tt);
    a_ST1_PFC(ss,tt) = (decay_constant)*a_ST1_PFC(ss,tt-1) + (1-decay_constant)*u_ST1_PFC(ss,tt); 
    o_ST1_PFC(ss,tt) = sigmf(a_ST1_PFC(ss,tt), [alpha_str_pfc(ss) beta_str_pfc(ss)]);
    
end
for ss = [1 2 3]
    %% STRIATUM D2
    u_ST2_PFC(ss,tt) = o_PFC(ss,tt);
    a_ST2_PFC(ss,tt) = (decay_constant)*a_ST2_PFC(ss,tt-1) + (1-decay_constant)*u_ST2_PFC(ss,tt); 
    o_ST2_PFC(ss,tt) = sigmf(a_ST2_PFC(ss,tt), [alpha_str_pfc(ss) beta_str_pfc(ss)]);
  
end
for ss = [1 2 3] 
    %% STN
    u_STN_PFC(ss,tt) = o_PFC(ss,tt).* W_STN + o_GPe_PFC(ss,tt-1) .* W_GPe_STN;
    a_STN_PFC(ss,tt) = (decay_constant)*a_STN_PFC(ss,tt-1) + (1-decay_constant)*u_STN_PFC(ss,tt); 
    o_STN_PFC(ss,tt) = sigmf(a_STN_PFC(ss,tt), [alpha_stn beta_stn_pfc(ss)]);
  
end
for ss = [1 2 3]
    %% GPe 
    u_GPe_PFC(ss,tt)  = (sum(o_STN_PFC(:,tt)) .* W_STN_GPe) + (o_ST2_PFC(ss,tt) .* W_ST2_GPe);
    a_GPe_PFC(ss,tt) = (decay_constant)*a_GPe_PFC(ss,tt-1) + (1-decay_constant)*u_GPe_PFC(ss,tt); 
    o_GPe_PFC(ss,tt) = sigmf(a_GPe_PFC(ss,tt), [alpha_gpe beta_gpe_pfc(ss)]);
  
end
for ss = [1 2 3]
    %% GPi
    u_GPi_PFC(ss,tt) = (sum(o_STN_PFC(:,tt)) .* W_STN_GPi) + (o_GPe_PFC(ss,tt-1) .* W_GPe_GPi) + (o_ST1_PFC(ss,tt-1) .* W_ST1_GPi);
    a_GPi_PFC(ss,tt) = (decay_constant)*a_GPi_PFC(ss,tt-1) + (1-decay_constant)*u_GPi_PFC(ss,tt); 
    o_GPi_PFC(ss,tt) = sigmf(a_GPi_PFC(ss,tt), [alpha_gpi beta_gpi_pfc(ss)]);

end
%% Output
    