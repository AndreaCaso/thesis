envNoise = 0.01;

o_ENV(3,100:150) = 0.7*ones(1,51);
o_ENV(3,150:200) = 0.7*ones(1,51);
o_ENV(3,200:250) = 0.7*ones(1,51);
o_ENV(3,500:600) = 0.7*ones(1,101);

o_ENV(2,150:200) = 0.7*ones(1,51);
o_ENV(2,200:250) = 0.7*ones(1,51);
o_ENV(2,250:350) = 0.7*ones(1,101);
o_ENV(2,550:600) = 0.7*ones(1,51);

o_ENV(1,300:350) = 0.7*ones(1,51);
o_ENV(1,350:400) = 0.7*ones(1,51);
o_ENV(1,400:450) = 0.7*ones(1,51);
o_ENV(1,400:450) = 0.7*ones(1,51);
o_ENV(1,575:600) = 0.7*ones(1,26);

o_ENV = o_ENV + envNoise*randn(size(o_ENV,1),size(o_ENV,2));