load('zad3skok15.mat')
load('skokY_15.txt')
x0 = [11, 10, 1, 10];
lb = [0 0 0 0];
ub = [1000 1000 10 30];

%[factors,E]= ga(@(x)(aproksym_error(x(1),x(2),x(3),x(4),false,skok)),4,[],[],[],[],lb,ub,[],[4]);
[factors,E]= fmincon(@(x)(aproksym_fun2(x(1),x(2),x(3),x(4),false,skok)),x0,[],[],[],[],lb,ub);
%[factors,E]= fmincon(@(x)(aproksym_fun2(x(1),x(2),x(3),x(4),false,skokY_15(11:350,2))),x0,[],[],[],[],lb,ub);

 aproksym_fun2(factors(1),factors(2),factors(3),factors(4),true,skok)
%aproksym_fun2(factors(1),factors(2),factors(3),factors(4),true,skokY_15(11:350,2))