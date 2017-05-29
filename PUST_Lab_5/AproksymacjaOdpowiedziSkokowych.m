%Uaktualniony punkt pracy
Ypp=[3800 ; 4000 ];
%wczytanie pobranej odpowiedzi skokowej
load('skokowa/skokU1Y1.txt');
load('skokowa/skokU1Y2.txt');
% skok=(skokU1Y1(15:114,2)-Ypp(1))/1500;
skok=(skokU1Y2(15:122,2)-Ypp(2))/1500;
skok(109:170)=0.0913;

for K=1:length(skok)
    if skok(K)<0
        skok(K)=0;
    end
end

%przygotowanie parametrów optymalizacji
x0 = [11, 10, 1, 1];
lb = [0 0 0 0];
ub = [1000 1000 1000 5];

%aproksymacja odpowiedzi skokowej
[factors,E]= fmincon(@(x)(aproksym_error(x(1),x(2),x(3),x(4),false,skok)),x0,[],[],[],[],lb,ub);
% [factors,E]=ga(@(x)(aproksym_error(x(1),x(2),x(3),x(4),false,skok)),4,[],[],[],[],lb,ub);
aproksym_error(factors(1),factors(2),factors(3),factors(4),true,skok)
%zapis do pliku i skrócenie
% toPlotForLatex('y1u1',1:100,skok')
toPlotForLatex('y2u1',1:100,skok(1:100)')