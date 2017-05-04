function [E]=p3DMC(N,Nu,lambda,latex)
%algorytm DMC z opcjonalnym uwzglêdnieniem parametrów
close all
N=round(N);
Nu=round(Nu);
load('p2/z2_y21.txt')
D=100;
s=z2_y21(16:115,2).*10;
Upp=0;
Ypp=0;
Umin=-1;
Umax=1;

%inicjalizacja sta³ych
kk=1410;
startk=10;
                            %DMC
%----------------------------------------------------------------
M=zeros(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)=s(i-j+1);
      end;
   end;
end;

MP=zeros(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)=s(i+j)-s(j);
      else
         MP(i,j)=s(D)-s(j);
      end;      
   end;
end;

% Obliczanie parametrów regulatora

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M';
ku=K(1,:)*MP;
ke=sum(K(1,:));

U(1:kk)=Upp;
Y(1:kk)=Ypp;

e=zeros(1,kk);
Yzad(1:startk)=Ypp; 
Yzad(startk:210)=Ypp+5;
Yzad(210:410)=Ypp+2;
Yzad(410:610)=Ypp+4;
Yzad(610:810)=Ypp-0.15;
Yzad(810:1010)=Ypp-0.05;
Yzad(1010:1210)=Ypp-0.1;
Yzad(1210:1410)=Ypp+1;

deltaup=zeros(1,D-1);


for k=7:kk
   %symulacja obiektu
   Y(k)= symulacja_obiektu3y(U(k-5),U(k-6),Y(k-1),Y(k-2));
   %uchyb regulacji
   e(k)=Yzad(k) - Y(k);
   
   % Prawo regulacji
   deltauk=ke*e(k)-ku*deltaup';
   
   for n=D-1:-1:2
      deltaup(n)=deltaup(n-1);
   end
   deltaup(1)=deltauk;
   U(k)=U(k-1)+deltaup(1);
   
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
    toPlotForLatex(sprintf('p4dmcY_%d_%d_%3.4f',N,Nu,lambda),1:kk,Y);
    toPlotForLatex(sprintf('p4dmcU_%d_%d_%3.4f',N,Nu,lambda),1:kk,U);
    toPlotForLatex('lab4Yzad',1:kk,Yzad);
end

%obliczenie b³êdu
E=sum((e).^2);
end