%przygotowanie parametrów optymalizacji
x0 = [1.0875 12 0.5 1.8 9 0.5];
lb = [0 0.0001 0 0 0.0001 0];
ub = [100 1000 10 100 1000 10];

%aproksymacja odpowiedzi skokowej
[factors,E]= fmincon(@(x)(z4PID(x(1),x(2),x(3),x(4),x(5),x(6),1,false,false)),x0,[],[],[],[],lb,ub); 
z4PID(factors(1),factors(2),factors(3),factors(4),factors(5),factors(6),1,true,false)