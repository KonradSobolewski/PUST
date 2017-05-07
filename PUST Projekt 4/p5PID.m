function [E]=p5PID( K,Ti,Td,n,d,c,latex)
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
r0=zeros(1,n);
r1=r0;
r2=r0;
Un=r0;
mi=r0;
for i=1:n
    r0(i)=K(i)*(1+Tp/(2*Ti(i))+Td(i)/Tp) ;
    r1(i)=K(i)*(Tp/(2*Ti(i))-2*Td(i)/Tp-1);
    r2(i)=K(i)*Td(i)/Tp;
end

for k=7:kk
   %symulacja obiektu
   Y(k)= symulacja_obiektu3y(U(k-5),U(k-6),Y(k-1),Y(k-2));
   %uchyb regulacji
   e(k)=Yzad(k) - Y(k);
   
   for i=1:n
        Un(i)=r2(i)*e(k-2)+r1(i)*e(k-1)+r0(i)*e(k)+U(k-1);
   end
   if n==2
       mi(1)=1-1/(1+exp(-d*(Y(k)-c(1))));%0.5
       mi(2)=1/(1+exp(-d*(Y(k)-c(1))));
       %p5PID([0.1 0.11],[1 3],[0.4 0.8],2,10,0.5,false)
   elseif n==3
       mi(1)=1-1/(1+exp(-d*(Y(k)-c(1))));%-0.05
       mi(2)=1/(1+exp(-d*(Y(k)-c(1))))-1/(1+exp(-d*(Y(k)-c(2))));%1.4
       mi(3)=1/(1+exp(-d*(Y(k)-c(2))));
       %p5PID([0.21 0.08 0.11],[1 2 3],[0.01 0.5 0.7],3,10,[-0.05 1.4],false)
   elseif n==4
       mi(1)=1-1/(1+exp(-d*(Y(k)-c(1))));%-0.05
       mi(2)=1/(1+exp(-d*(Y(k)-c(1))))-1/(1+exp(-d*(Y(k)-c(2))));%0.5
       mi(2)=1/(1+exp(-d*(Y(k)-c(2))))-1/(1+exp(-d*(Y(k)-c(3))));%1.4
       mi(4)=1/(1+exp(-d*(Y(k)-c(3))));
       %p5PID([0.12 0.14 0.13 0.1],[1 3 5 3],[0.24 2.1 0.9 0.9],4,10,[-0.05 0.5 1.4],false)
   elseif n==5
       mi(1)=1-1/(1+exp(-d*(Y(k)-c(1))));%-0.05
       mi(2)=1/(1+exp(-d*(Y(k)-c(1))))-1/(1+exp(-d*(Y(k)-c(2))));%0.25
       mi(3)=1/(1+exp(-d*(Y(k)-c(2))))-1/(1+exp(-d*(Y(k)-c(3))));%0.5
       mi(4)=1/(1+exp(-d*(Y(k)-c(3))))-1/(1+exp(-d*(Y(k)-c(4))));%1.4
       mi(5)=1/(1+exp(-d*(Y(k)-c(4))));
       %p5PID([0.34 0.01 0.42 0.18 0.1],[1 1 5 2 3],[0.01 1.1 0.9 2.5 0.9],5,10,[-0.05 0.25 0.5 1.4],false)
   end
   
   U(k)=sum(Un*mi')/sum(mi);
   
   if U(k)>Umax
      	U(k)=Umax;
   elseif U(k)<Umin
        U(k)=Umin;
   end
    
    %zapis do pliku
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
    toPlotForLatex('p5pidY05',1:kk,Y);
    toPlotForLatex('p5pidU05',1:kk,U);
    toPlotForLatex('p5Yzad',1:kk,Yzad);
end

%obliczenie b³êdu
E=sum((e).^2);
end