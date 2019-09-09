for ss = randperm(schemaNum)
    
u_THAL(ss,tt) = ((o_GPi(ss,tt))); 
a_THAL(ss,tt) = (decay_constant)*a_THAL(ss,tt - 1) + (1 - decay_constant)*u_THAL(ss,tt - 1); 
o_THAL(ss,tt) = - sigmf(a_THAL(ss,tt), [alpha_thal beta_thal(ss)]);

end
