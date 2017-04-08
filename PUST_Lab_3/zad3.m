%Uaktualniony punkt pracy
Ypp=[39.62 ; 42.06 ];
%wczytanie pobranej odpowiedzi skokowej
skokl=load('Wykresy/z2Y151.000041.0000.txt');
skok=(skokl(11:310,2)-Ypp(1))/15;

for K=1:length(skok)
    if skok(K)<0
        skok(K)=0;
    end
end

%aproksymacja otrzymanej odpowiedzi skokowej
fminconaproksym;
factor1=factors;
E1=E;
%zapis do pliku i skrócenie
toPlotForLatex('z3y1u1',1:300,skok')

skokl=load('Wykresy/z2Y251.000041.0000.txt');
skok=(skokl(11:310,2)-Ypp(2))/15;

for K=1:length(skok)
    if skok(K)<0
        skok(K)=0;
    end
end

%aproksymacja otrzymanej odpowiedzi skokowej
fminconaproksym;
factor2=factors;
E2=E;
%zapis do pliku i skrócenie
toPlotForLatex('z3y2u1',1:300,skok')

