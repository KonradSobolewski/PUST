load('skokZ_10.txt')
skok=(skokZ_10(11:310,2)-Ypp)/10;
for K=1:length(skok)
    if skok(K)<0
        skok(K)=0;
    end
end
fminconaproksym;
factorZ=factors;
EZ=E;
toPlotForLatex('skokZ',1:300,skok')

load('skokU_10.txt')
skok=(skokU_10(11:310,2)-Ypp)/10;
for K=1:length(skok)
    if skok(K)<0
        skok(K)=0;
    end
end
fminconaproksym;
factorU=factors;
EU=E;
toPlotForLatex('skokU',1:300,skok')