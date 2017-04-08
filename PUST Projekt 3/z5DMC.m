%przygotowanie parametrów optymalizacji
x0 = [10 10 1];
lb = [1 1 0.00000001];
ub = [200000 200000 20000];

%aproksymacja odpowiedzi skokowej
[factors,E]= fmincon(@(x)(z4DMC(x(1),x(2),x(3),false,false)),x0,[],[],[],[],lb,ub); 
z4DMC(factors(1),factors(2),factors(3),true,false)