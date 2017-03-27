%Uaktualniony punkt pracy
Ypp=37.68;
%wczytanie pobranej odpowiedzi skokowej
load('sprawozdanie/wykresy/skokZ_30.txt')
skok=(skokZ_30(11:310,2)-Ypp)/30;

for K=1:length(skok)
    if skok(K)<0
        skok(K)=0;
    end
end

%aproksymacja otrzymanej odpowiedzi skokowej
fminconaproksym;
factorZ=factors;
EZ=E;
%zapis do pliku i skrócenie
toPlotForLatex('skokZ',1:300,skok')
