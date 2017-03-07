clear all;
% wyznacza odpowiedŸ skokow¹ i normalizuje 
dU=-0.2;
Tp=0.5;
Upp=0.8;
Ypp=5;
Umin=0.6;
Umax=1;
kk=250;
startk=15;

U(1:kk)=Upp;
Y(1:kk)=Ypp;
U(startk:kk)=Upp+dU;
if Upp+dU>Umax
   du=Umax;
elseif Upp-dU<Umin
    dU=Umin;
end
for k=startk:kk 
    Y(k)=symulacja_obiektu11Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
end
S=(Y-Ypp)/dU;
plot(S(startk+1:kk));
title('Znormalizowana odp. skokowa')
xlabel('s')
ylabel('k')
toPlotForLatex('z3',1:kk-startk,S(startk+1:kk))