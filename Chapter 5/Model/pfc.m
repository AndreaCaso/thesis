for ss = [1 2 3]
    
%this component is due to the value of the activation (self)
%and the other schemas, according to the matri Wpfc
%self-energised when it reaches a threshold of engThr

w_PFC(ss,tt) = Wpfc(ss,:)*o_PFC(:,tt-1) + satlin(w_PFC(ss,tt-1) - engThr)*heaviside(w_PFC(ss,tt-1) - engThr); 

u_PFC(ss,tt) = w_PFC(ss,tt) + o_EXT_PFC(ss,tt) + o_THAL_PFC(ss,tt); 
a_PFC(ss,tt) = (decay_constant)*a_PFC(ss,tt-1) + (1-decay_constant)*u_PFC(ss,tt-1); 
o_PFC(ss,tt) = sigmf(a_PFC(ss,tt), [alpha_pfc beta_pfc(ss)]);

end