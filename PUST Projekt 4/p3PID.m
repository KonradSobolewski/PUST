function [E]=p3PID( K,Ti,Td,latex)
close all
%algorytm DMC z opcjonalnym uwzglêdnieniem parametrów
Upp=0;
Ypp=0;
Umin=-1;
Umax=1;
Tp=0.5;

%inicjalizacja sta³ych
kk=1410;
startk=10;

U(1:kk)=Upp;
Y(1:kk)=Ypp;
%<-0.15,5.5>
e=zeros(1,kk);
Yzad(1:startk)=Ypp; 
Yzad(startk:210)=Ypp+5;
Yzad(210:410)=Ypp+2;
Yzad(410:610)=Ypp+4;
Yzad(610:810)=Ypp-0.15;
Yzad(810:1010)=Ypp-0.05;
Yzad(1010:1210)=Ypp-0.1;
Yzad(1210:1410)=Ypp+1;

r0=K*(1+Tp/(2*Ti)+Td/Tp) ;
r1=K*(Tp/(2*Ti)-2*Td/Tp-1);
r2=K*Td/Tp;

for k=7:kk
   %symulacja obiektu
   Y(k)= symulacja_obiektu3y(U(k-5),U(k-6),Y(k-1),Y(k-2));
   %uchyb regulacji
   e(k)=Yzad(k) - Y(k);
   
  
   U(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+U(k-1);
   
   if U(k)>Umax
      	U(k)=Umax;
   elseif U(k)<Umin
        U(k)=Umin;
   end
    
end
figure
plot(Y)
title('y')
hold on
plot(Yzad,'r-')
% figure
% plot(U)
% title('u')
if latex==true
    toPlotForLatex(sprintf('p4pidY_%3.4f_%3.4f_%3.4f',K,Ti,Td),1:kk,Y);
    toPlotForLatex(sprintf('p4pidU_%3.4f_%3.4f_%3.4f',K,Ti,Td),1:kk,U);
    toPlotForLatex('p4Yzad',1:kk,Yzad);
end

%obliczenie b³êdu
E=sum((e).^2);
end