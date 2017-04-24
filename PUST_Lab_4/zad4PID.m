function [E]=zad4PID( K,Ti,Td)

%algorytm DMC z opcjonalnym uwzglêdnieniem parametrów
addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM5 % initialise com port
Upp=36;
Ypp=36.12;
Umin=0;
Umax=100;
Tp=1;

%inicjalizacja sta³ych
kk=1210;
startk=10;

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

r0=K*(1+Tp/(2*Ti)+Td/Tp) ;
r1=K*(Tp/(2*Ti)-2*Td/Tp-1);
r2=K*Td/Tp;

for k=3:kk
   %symulacja obiektu
   Y(k)= readMeasurements(1);
   y(k) = Y(k) - Ypp;
   %uchyb regulacji
   e(k)=yzad(k) - y(k);
   
  
   u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
   
   if u(k)>umax
      	u(k)=umax;
   elseif u(k)<umin
        u(k)=umin;
   end
   U(k)=u(k)+Upp;
   
    sendNonlinearControls(U(k)) ;
    
    plot(Y)
    drawnow
    %zapis do pliku
    toPlotForLatex(sprintf('lab4pidY_%3.4f_%3.4f_%3.4f',K,Ti,Td),1:kk,Y);
    toPlotForLatex(sprintf('lab4pidU_%3.4f_%3.4f_%3.4f',K,Ti,Td),1:kk,U);
    toPlotForLatex('lab4Yzad',1:kk,Yzad);
   disp(k)
   disp(Y(k))
    waitForNewIteration (); % wait for new iteration
end

%obliczenie b³êdu
E=sum(e);
end