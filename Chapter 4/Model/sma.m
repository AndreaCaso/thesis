for ss = [1 2 3 4]
    
w_SMA(ss,tt) = Wsma(ss,:)*o_SMA(:,tt-1) + Wparent(ss,:)*o_PFC(:,tt-1) + satlin(o_SMA(ss,tt-1) - engThr)*heaviside(o_SMA(ss,tt-1) - engThr); ; 

u_SMA(ss,tt) = w_SMA(ss,tt) + o_EXT_SMA(ss,tt) + o_THAL_SMA(ss,tt); 
a_SMA(ss,tt) = (decay_constant)*a_SMA(ss,tt-1) + (1-decay_constant)*u_SMA(ss,tt-1); 
o_SMA(ss,tt) = sigmf(a_SMA(ss,tt), [alpha_sma beta_sma(ss)]);

end