%przygotowanie parametrów optymalizacji
x0 = [3.27 5 0.8 3.415 4 0.2];
lb = [0 0.0000001 0 0 0.0000001 0];
ub = [10000 10000 10000 10000 10000 10000];

%aproksymacja odpowiedzi skokowej
[factors,E]= fmincon(@(x)(z4PID(x(1),x(2),x(3),x(4),x(5),x(6),2,false,false)),x0,[],[],[],[],lb,ub); 
z4PID(factors(1),factors(2),factors(3),factors(4),factors(5),factors(6),2,true,true)