N=50;
Nu=1;
lambda=0.1;
draw=true;
latex=true;
load('aprskok15.txt');
s = aprskok15(:,2);
%E = DMC(N,Nu,lambda,draw,latex,s)

x0 = [N,Nu,lambda];
lb = [0 0 0 ];
ub = [1000 1000 1000 ];


[factors,E]= fmincon(@(x)(DMC(x(1),x(2),x(3),false,false,s)),x0,[],[],[],[],lb,ub)

%aproksym_error(factors(1),factors(2),factors(3),factors(4),true)