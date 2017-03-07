clear all;
x0 = [0.775, 12, 3];
lb = [0, 0, 0];
[nastawy,min_error] = fmincon(@(x)(zad4PID(x(1),x(2),x(3),false,false)),x0,[],[],[],[],lb)

E = zad4PID(nastawy(1),nastawy(2),nastawy(3),true,true)