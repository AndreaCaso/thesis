for ss = 1:num_rules
    
pfc.u_THAL_PFC(ss,tt) = ((pfc.o_GPi_PFC(ss,tt))); 
pfc.a_THAL_PFC(ss,tt) = (decay_constant)*pfc.a_THAL_PFC(ss,tt - 1) + (1 - decay_constant)*pfc.u_THAL_PFC(ss,tt - 1); 
pfc.o_THAL_PFC(ss,tt) = -sigmf(pfc.a_THAL_PFC(ss,tt), [satfnc.alpha_thal satfnc.beta_thal]);

end
