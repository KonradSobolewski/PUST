function [E]=zad4DMC(Nu,lambda)
%algorytm DMC z opcjonalnym uwzględnieniem parametrów
addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM5 % initialise com port
load('aprskok15.txt')
D=300;
N=300;
s=aprskok15(:,2);
Upp=36;
Ypp=36.12;
Umin=0;
Umax=100;

%inicjalizacja stałych
kk=1210;
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
Yzad(startk:210)=Ypp+4;
Yzad(210:410)=Ypp+2;
Yzad(410:610)=Ypp+9;
Yzad(610:810)=Ypp+6;
Yzad(810:1010)=Ypp+7;
Yzad(1010:1210)=Ypp+1;
u=U-Upp;
y=U-Ypp;
yzad = Yzad-Ypp;
umax = Umax - Upp;
umin = Umin - Upp;

deltaup=zeros(1,D-1);


for k=2:kk
   %symulacja obiektu
   Y(k)= readMeasurements(1);
   y(k) = Y(k) - Ypp;
   %uchyb regulacji
   e(k)=yzad(k) - y(k);
   
   % Prawo regulacji
   deltauk=ke*e(k)-ku*deltaup';
   
   for n=D-1:-1:2
      deltaup(n)=deltaup(n-1);
   end
   deltaup(1)=deltauk;
   u(k)=u(k-1)+deltaup(1);
   
   if u(k)>umax
      	u(k)=umax;
   elseif u(k)<umin
        u(k)=umin;
   end
   U(k)=u(k)+Upp;
   
    sendNonlinearControls(U(k)) ;
    disp(k)
    disp(Y(k))
    plot(Y)
    drawnow
    %zapis do pliku
    toPlotForLatex(sprintf('lab4dmcY_%d_%3.4f',Nu,lambda),1:kk,Y);
    toPlotForLatex(sprintf('lab4dmcU_%d_%3.4f',Nu,lambda),1:kk,U);
    toPlotForLatex('lab4Yzad',1:kk,Yzad);
   
    waitForNewIteration (); % wait for new iteration
end

%obliczenie błędu
E=sum(e.^2);
end