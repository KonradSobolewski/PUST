Ypp=37.68;
load('skokZ_30.txt')
skok=(skokZ_30(11:310,2)-Ypp)/30;
for K=1:length(skok)
    if skok(K)<0
        skok(K)=0;
    end
end
fminconaproksym;
factorZ=factors;
EZ=E;
toPlotForLatex('skokZ',1:300,skok')
