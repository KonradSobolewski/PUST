LB=[0,0,0,1e-10,1e-10,1e-10,0,0,0];
UB=[Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf];
K=[1,1,1];
Ti=[Inf,Inf,Inf];
Td=[0,0,0];
x0=[K,Ti,Td];
x=fmincon(@(x)(zad3PID([x(1) x(2) x(3)],[x(4) x(5) x(6)],[x(7) x(8) x(9)],[2 1 4],false,false)),x0,[],[],[],[],LB,UB);
zad3PID([x(1) x(2) x(3)],[x(4) x(5) x(6)],[x(7) x(8) x(9)],[2 4 1],true,false)