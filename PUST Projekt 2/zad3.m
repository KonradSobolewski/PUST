function [ s,sz ] = zad3(Latex,plot)
% wyznacza odpowiedzo skokowe i normalizuje 
kk=200;
Tp=0.5;
dU=1;
dZ=1;
startk=15;
%-------------------------------U----------------------------------------
U(1:kk)=0;
Y(1:kk)=0;
Z(1:kk)=0;
U(startk:kk)=dU;
for k=startk:kk 
    Y(k)=symulacja_obiektu7y(U(k-4),U(k-5),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
end
s=Y(startk+1:kk);
if(plot)
    figure(1)
    plot(s);
    title('Znormalizowana odp. skokowa dla toru u')
    xlabel('s')
    ylabel('k')
end
if(Latex)
    toPlotForLatex('z3s',1:kk-startk,s)
end
%------------------------------Z----------------------------------------
U(1:kk)=0;
Y(1:kk)=0;
Z(1:kk)=0;
Z(startk:kk)=dZ;
for k=startk:kk 
    Y(k)=symulacja_obiektu7y(U(k-4),U(k-5),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
end

sz=Y(startk+1:kk);
if(plot)
    figure(2)
    plot(sz);
    title('Znormalizowana odp. skokowa dla toru z')
    xlabel('sz')
    ylabel('k')
end
if(Latex)
    toPlotForLatex('z3sz',1:kk-startk,sz)
end
end