clear;
x0 = [30, 1, 15];
lb = [1 1 0.1];
ub = [80 80 80];
nVars = 3;

[nastawy,E]= fmincon(@(x)(zad4DMC(x(1),x(2),x(3),false,false)),x0,[],[],[],[],lb,ub);
zad4DMC(nastawy(1),nastawy(2),nastawy(3),true,true)
