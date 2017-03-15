%wczytanie odpowiedzi skokowej z pliku .txt
load('skokY_15.txt')
skok=(skokY_15(11:350,2)-36.5)/15;
for K=1:length(skok)
    if skok(K)<0
    skok(K)=0;
    end
end

toPlotForLatex('skok15',1:340,skok')

%przygotowanie parametrów optymalizacji
x0 = [11, 10, 1, 10];
lb = [0 0 0 0];
ub = [1000 1000 10 30];

%aproksymacja odpowiedzi skokowej
[factors,E]= fmincon(@(x)(aproksym_error(x(1),x(2),x(3),x(4),false,skok)),x0,[],[],[],[],lb,ub); 
aproksym_error(factors(1),factors(2),factors(3),factors(4),true,skok)

%aproksymacja obiektu
%[factors,E]= fmincon(@(x)(aproksym_fun2(x(1),x(2),x(3),x(4),false,skokY_15(11:350,2))),x0,[],[],[],[],lb,ub);
%aproksym_fun2(factors(1),factors(2),factors(3),factors(4),true,skokY_15(11:350,2))