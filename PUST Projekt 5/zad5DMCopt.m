LB=[0,0,0,0,0,0,0];
UB=[Inf,Inf,Inf,Inf,Inf,Inf,Inf];
psi=[2.7 40 7];
lambda=[20 1 0 0];
x0=[lambda psi];
x=fmincon(@(x)(zad3DMC(200,200,200,[x(1) x(2) x(3) x(4)],[x(5) x(6) x(7)],false,false)),x0,[],[],[],[],LB,UB);
zad3DMC(200,200,200,[x(1) x(2) x(3) x(4)],[x(5) x(6) x(7)],true,true)