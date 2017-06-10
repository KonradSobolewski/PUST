LB=[0,0,0,1e-10,1e-10,1e-10,0,0,0];
UB=[Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf];
K=[6.6821 3.0328 0.7699];
Ti=[1 7 5];
Td=[1e-9 1e-9 1];
var=[3 2 1];
x0=[K,Ti,Td];
x=fmincon(@(x)(zad3PID([x(1) x(2) x(3)],[x(4) x(5) x(6)],[x(7) x(8) x(9)],var,false,false)),x0,[],[],[],[],LB,UB);
zad3PID([x(1) x(2) x(3)],[x(4) x(5) x(6)],[x(7) x(8) x(9)],var,true,true)