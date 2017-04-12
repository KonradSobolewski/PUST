function [ E1,E2,E ] = z4PID( K1,Ti1,Td1,K2,Ti2,Td2,latex )
 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM3 % initialise com port
Tp=1;
% kk=910;
kk=1810;
startk1=10;
startk2=310;
startk3=610;
startk4=910;
startk5=1210;
startk6=1510;
Upp=[36 41];
Ypp=[ 39.62  42.06 ];
Umin=[0 0];
Umax=[100 100];

r0=[K1*(1+Tp/(2*Ti1)+Td1/Tp);K2*(1+Tp/(2*Ti2)+Td2/Tp)];
r1=[K1*(Tp/(2*Ti1)-2*Td1/Tp-1);K2*(Tp/(2*Ti2)-2*Td2/Tp-1)];
r2=[K1*Td1/Tp;K2*Td2/Tp];
U=diag(Upp)*ones(2,kk);
Y = diag(Ypp)*ones(2,kk);
e=zeros(2,kk);
Yzad=Y;
Yzad(1,startk1:kk)=Ypp(1)+3;
Yzad(2,startk2:kk)=Ypp(2)+3;
Yzad(1,startk3:kk)=Ypp(1)+1;
Yzad(2,startk4:kk)=Ypp(2)+1;
Yzad(1,startk5:kk)=Ypp(1)+2;
Yzad(2,startk6:kk)=Ypp(2)+2;

% Yzad(1,startk2:kk)=Ypp(1)+1;
% Yzad(1,startk3:kk)=Ypp(1)+2;

u=zeros(2,kk);
y=zeros(2,kk);
umin=Umin-Upp;
umax=Umax-Upp;
yzad=Yzad-diag(Ypp)*ones(2,kk);
for k=startk1:kk; %glówna petla symulacyjna
    %symulacja obiektu
    Y(:,k) = readMeasurements ([1,3]) ; % read measurements
    %uchyb regulacji
    y(:,k)=Y(:,k)-Ypp';
    e(:,k)=yzad(:,k)-y(:,k);
    %sygnaá steruj¹cy regulatora PID
    u(1,k)=r2(1)*e(1,k-2)+r1(1)*e(1,k-1)+r0(1)*e(1,k)+u(1,k-1);
    u(2,k)=r2(2)*e(2,k-2)+r1(2)*e(2,k-1)+r0(2)*e(2,k)+u(2,k-1);
    if u(1,k)<umin(1)
        u(1,k)=umin(1);
    elseif u(1,k)>umax(1)
        u(1,k)=umax(1);
    end
    if u(2,k)<umin(2)
        u(2,k)=umin(2);
    elseif u(2,k)>umax(2)
        u(2,k)=umax(2);
    end
    U(:,k)=u(:,k)+Upp';
    sendControls([1,2,5,6],[50,50,U(1,k),U(2,k)]);
    
    subplot(221)
    plot(U(1,:));
    title({'Algorytm PID ';['K = ', num2str(K1), ', Ti = ', num2str(Ti1),', Td = ',num2str(Td1)]; ' '});
    xlabel('k')
    ylabel('U1(k)')
    subplot(222)
    plot(U(2,:));
    title({'Algorytm PID ';['K = ', num2str(K2), ', Ti = ', num2str(Ti2),', Td = ',num2str(Td2)]; ' '});
    xlabel('k')
    ylabel('U2(k)')
    subplot(223)
    plot(Y(1,:));
%     hold on;
%     stairs(Yzad(1,:),'--')
%     legend('Y1(k)','Y_z_a_d_1(k)','location','best');
    xlabel('k')
    ylabel('Y1(k)')
    subplot(224)
    plot(Y(2,:));
%     hold on;
%     stairs(Yzad(2,:),'--')
%     legend('Y2(k)','Y_z_a_d_2(k)','location','best');
    xlabel('k')
    ylabel('Y2(k)')
    drawnow
    
    toPlotForLatex(sprintf('z4pidu1_%3.4f_%3.4f_%3.4f',K1,Ti1,Td1),1:kk,U(1,:))
    toPlotForLatex(sprintf('z4pidu2_%3.4f_%3.4f_%3.4f',K2,Ti2,Td2),1:kk,U(2,:))
    toPlotForLatex(sprintf('z4pidy1_%3.4f_%3.4f_%3.4f',K1,Ti1,Td1),1:kk,Y(1,:))
    toPlotForLatex(sprintf('z4pidy2_%3.4f_%3.4f_%3.4f',K2,Ti2,Td2),1:kk,Y(2,:))
    toPlotForLatex(sprintf('z4pidyzad1_%3.4f',Yzad(1,kk)),1:kk,Yzad(1,:))
    toPlotForLatex(sprintf('z4pidyzad2_%3.4f',Yzad(2,kk)),1:kk,Yzad(2,:))
    waitForNewIteration (); % wait for new iteration
end;
E1=0;
E2=0;
for k=1:kk
    E1=E1+((Yzad(1,k)-Y(1,k))^2);
    E2=E2+((Yzad(2,k)-Y(2,k))^2);
end
E=E1+E2;

if(latex)
    toPlotForLatex(sprintf('z4pidu1_%3.4f_%3.4f_%3.4f',K1,Ti1,Td1),1:kk,U(1,:))
    toPlotForLatex(sprintf('z4pidu2_%3.4f_%3.4f_%3.4f',K2,Ti2,Td2),1:kk,U(2,:))
    toPlotForLatex(sprintf('z4pidy1_%3.4f_%3.4f_%3.4f',K1,Ti1,Td1),1:kk,Y(1,:))
    toPlotForLatex(sprintf('z4pidy2_%3.4f_%3.4f_%3.4f',K2,Ti2,Td2),1:kk,Y(2,:))
    toPlotForLatex(sprintf('z4pidyzad1_%3.4f',Yzad(1,kk)),1:kk,Yzad(1,:))
    toPlotForLatex(sprintf('z4pidyzad2_%3.4f',Yzad(2,kk)),1:kk,Yzad(2,:))
end

end