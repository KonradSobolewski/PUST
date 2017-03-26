%przygotowanie parametrów optymalizacji
x0 = [11, 10, 1, 10];
lb = [0 0 0 0];
ub = [1000 1000 10 30];

%aproksymacja odpowiedzi skokowej
[factors,E]= fmincon(@(x)(aproksym_error(x(1),x(2),x(3),x(4),false,skok)),x0,[],[],[],[],lb,ub); 
aproksym_error(factors(1),factors(2),factors(3),factors(4),true,skok)