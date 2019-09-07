for ss = randperm(schemaNum)
    
u_SMA(ss,tt) = o_ENV(ss,tt) + o_THAL(ss,tt-1); 
a_SMA(ss,tt) = (decay_constant)*a_SMA(ss,tt-1) + (1-decay_constant)*u_SMA(ss,tt-1); 
o_SMA(ss,tt) = sigmf(a_SMA(ss,tt), [alpha_sma beta_sma(ss)]);

end