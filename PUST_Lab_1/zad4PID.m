function [ E ] = zad4PID( K,Ti,Td,draw,latex )
 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM14 % initialise com port

Tp=1;
Upp=36;
Ypp=36.5;
kk=615;
startk=15;

r0=K*(1+Tp/(2*Ti)+Td/Tp) ;
r1=K*(Tp/(2*Ti)-2*Td/Tp-1);
r2=K*Td/Tp;
Umin=0;
Umax=100;
dUmax=Inf;


U=Upp*ones(1,kk);
Y=Ypp*ones(1,kk);
e=zeros(1,kk);
U(1:11)=Upp; Y(1:11)=Ypp;
Yzad(1:startk)=Ypp; 
Yzad(startk:kk-300)=40;
Yzad(300+startk:kk)=38;

u=U-Upp;
y=Y-Ypp;
yzad = Yzad-Ypp;
umax = Umax - Upp;
umin = Umin - Upp;


alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);
a1 = -alfa1 - alfa2;
a2 = alfa1*alfa2;
b1 = (K/(T1-T2))*(T1*(1-alfa1)-T2*(1-alfa2));
b2 = (K/(T1-T2))*(alfa1*T2*(1-alfa2)-(alfa2*T1*(1-alfa1)));

for k=12:kk; %glówna petla symulacyjna
    %symulacja obiektu
    %Y(k)= readMeasurements(1);
    Y(k) = b1*u(k-Td-1) + b2*u(k-Td-2) - a1*y(k-1) - a2*y(k-2);
    y(k)=Y(k)-Ypp;
    %uchyb regulacji
    e(k)=yzad(k)-y(k);
    %sygnaá steruj¹cy regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
    if u(k)-u(k-1)>dUmax
        u(k)=u(k-1)+dUmax;
    elseif u(k)-u(k-1)< -dUmax
        u(k)=u(k-1)-dUmax;
    end
    
    if u(k)>umax
      	u(k)=umax;
    elseif u(k)<umin
        u(k)=umin;
    end
    U(k)=u(k)+Upp;
    sendControls ([ 1, 2, 3, 4, 5, 6],[ 50, 0, 0, 0, U(k), 0]) ;

    waitForNewIteration (); 
    plot(Y)
    drawnow
    display(k)
    display(Y(k))
end;
E=0;
for k=1:kk
    E=E+((Yzad(k)-Y(k))^2);
end
if(draw)
    
    subplot(211)
    plot(U);
    title({'Algorytm PID ';['K = ', num2str(K), ', Ti = ', num2str(Ti),', Td = ',num2str(Td)];['E = ',num2str(E)]; ' '});
    xlabel('k')
    ylabel('sterowanie u')
    legend('U(k)','location','best');
    hold on;
    subplot(212)
    plot(Y);
    hold on;
    stairs(Yzad,'--')
    legend('Y(k)','Y_z_a_d(k)','location','best');
    xlabel('k')
    ylabel('wyjœcie y')
    hold on;
    
end

if(latex)
    toPlotForLatex(sprintf('pidu_%3.4f_%3.4f_%3.4f',K,Ti,Td),1:kk,U)
    toPlotForLatex(sprintf('pidy_%3.4f_%3.4f_%3.4f',K,Ti,Td),1:kk,Y)
    toPlotForLatex(sprintf('pidyzad_%3.4f',Yzad(kk)),1:kk,Yzad)
end

end


