function [ E ] = zad4PID( K,Ti,Td,draw,latex )

Tp=0.5;
Upp=0.8;
Ypp=5;
kk=250;
startk=15;

r0=K*(1+Tp/(2*Ti)+Td/Tp) ;
r1=K*(Tp/(2*Ti)-2*Td/Tp-1);
r2=K*Td/Tp;
Umin=0.6;
Umax=1;
dUmax=0.05;

U=Upp*ones(1,kk);
Y=Ypp*ones(1,kk);
e=zeros(1,kk);
U(1:11)=Upp; Y(1:11)=Ypp;
Yzad(1:startk)=Ypp; 
Yzad(startk:kk)=5.2;

u=U-Upp;
y=Y-Ypp;
yzad = Yzad-Ypp;
umax = Umax - Upp;
umin = Umin - Upp;

for k=12:kk; %glówna petla symulacyjna
    %symulacja obiektu
    Y(k)= symulacja_obiektu11Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
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


