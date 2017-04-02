%Uaktualniony punkt pracy
Ypp=[ ];
%wczytanie pobranej odpowiedzi skokowej
skokl=load('z2Y15141');
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

skokl=load('z2Y25141');
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

skokl=load('z2Y13656');
skok=(skokl(11:310,2)-Ypp(1))/15;

for K=1:length(skok)
    if skok(K)<0
        skok(K)=0;
    end
end

%aproksymacja otrzymanej odpowiedzi skokowej
fminconaproksym;
factor3=factors;
E3=E;
%zapis do pliku i skrócenie
toPlotForLatex('z3y1u2',1:300,skok')

skokl=load('z2Y23656');
skok=(skokl(11:310,2)-Ypp(2))/15;

for K=1:length(skok)
    if skok(K)<0
        skok(K)=0;
    end
end

%aproksymacja otrzymanej odpowiedzi skokowej
fminconaproksym;
factor4=factors;
E4=E;
%zapis do pliku i skrócenie
toPlotForLatex('z3y2u2',1:300,skok')