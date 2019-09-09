for ss = [1 2 3 4]
    
u_THAL_SMA(ss,tt) = ((o_GPi_SMA(ss,tt))); 
a_THAL_SMA(ss,tt) = (decay_constant)*a_THAL_SMA(ss,tt - 1) + (1 - decay_constant)*u_THAL_SMA(ss,tt - 1); 
o_THAL_SMA(ss,tt) = - W_THAL*sigmf(a_THAL_SMA(ss,tt), [alpha_thal beta_thal]);

end
