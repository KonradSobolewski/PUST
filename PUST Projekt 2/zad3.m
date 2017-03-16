function [ s,sz ] = zad3(Latex)
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
S=Y;
figure(1)
plot(S(startk+1:kk));
s=S(startk+1:kk);
title('Znormalizowana odp. skokowa Y(u)')
xlabel('s')
ylabel('k')
if(Latex)
    toPlotForLatex('z3s',1:kk-startk,S(startk+1:kk))
end
%------------------------------Z----------------------------------------
U(1:kk)=0;
Y(1:kk)=0;
Z(1:kk)=0;
Z(startk:kk)=dZ;
for k=startk:kk 
    Y(k)=symulacja_obiektu7y(U(k-4),U(k-5),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
end

SZ=Y;
figure(2)
plot(SZ(startk+1:kk));
sz=SZ(startk+1:kk);
title('Znormalizowana odp. skokowa Y(z)')
xlabel('sz')
ylabel('k')
if(Latex)
    toPlotForLatex('z3sz',1:kk-startk,SZ(startk+1:kk))
end
end