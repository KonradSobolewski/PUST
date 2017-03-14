load('skokY_5.txt')
skok=(skokY_5(11:350,2)-36.5)/5;
for K=1:length(skok)
    if skok(K)<0
    skok(K)=0;
    end
end
zad3
factor5=factors;
E5=E;
toPlotForLatex('skok5',1:340,skok')