for ss = [1 2 3]
    
u_THAL_PFC(ss,tt) = ((o_GPi_PFC(ss,tt))); 
a_THAL_PFC(ss,tt) = (decay_constant)*a_THAL_PFC(ss,tt - 1) + (1 - decay_constant)*u_THAL_PFC(ss,tt - 1); 
o_THAL_PFC(ss,tt) = - W_THAL*sigmf(a_THAL_PFC(ss,tt), [alpha_thal beta_thal]);

end
