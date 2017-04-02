function [ E1,E2,E ] = z4PID( K1,Ti1,Td1,K2,Ti2,Td2,draw,latex )

Tp=0.5;
kk=510;
startk=10;

r0=[K1*(1+Tp/(2*Ti1)+Td1/Tp);K2*(1+Tp/(2*Ti2)+Td2/Tp)];
r1=[K1*(Tp/(2*Ti1)-2*Td1/Tp-1);K2*(Tp/(2*Ti2)-2*Td2/Tp-1)];
r2=[K1*Td1/Tp;K2*Td2/Tp];
U=zeros(2,kk);
Y=zeros(2,kk);
e=zeros(2,kk);
Yzad=Y;
Yzad(1,startk:kk)=1;
Yzad(2,260:kk)=1;
for k=startk:kk; %glówna petla symulacyjna
    %symulacja obiektu
    Y(1,k)=symulacja_obiektu3y1(U(1,k-5),U(1,k-6),U(2,k-2),U(2,k-3),Y(1,k-1),Y(1,k-2));
    Y(2,k)=symulacja_obiektu3y2(U(1,k-6),U(1,k-7),U(2,k-4),U(2,k-5),Y(2,k-1),Y(2,k-2));
    %uchyb regulacji
    e(:,k)=Yzad(:,k)-Y(:,k);
    %sygnaá steruj¹cy regulatora PID
    U(1,k)=r2(1)*e(1,k-2)+r1(1)*e(1,k-1)+r0(1)*e(1,k)+U(1,k-1);
    U(2,k)=r2(2)*e(2,k-2)+r1(2)*e(2,k-1)+r0(2)*e(2,k)+U(2,k-1);
end;
E1=0;
E2=0;
for k=1:kk
    E1=E1+((Yzad(1,k)-Y(1,k))^2);
    E2=E2+((Yzad(2,k)-Y(2,k))^2);
end
E=E1+E2;
if(draw)
    
    subplot(221)
    plot(U(1,:));
    title({'Algorytm PID ';['K = ', num2str(K1), ', Ti = ', num2str(Ti1),', Td = ',num2str(Td1)];['E = ',num2str(E)]; ' '});
    xlabel('k')
    ylabel('U1(k)')
    hold on;
    subplot(222)
    plot(U(2,:));
    title({'Algorytm PID ';['K = ', num2str(K2), ', Ti = ', num2str(Ti2),', Td = ',num2str(Td2)];['E = ',num2str(E)]; ' '});
    xlabel('k')
    ylabel('U2(k)')
    hold on;
    subplot(223)
    plot(Y(1,:));
    hold on;
    stairs(Yzad(1,:),'--')
    legend('Y1(k)','Y_z_a_d_1(k)','location','best');
    xlabel('k')
    ylabel('Y1(k)')
    hold on;
    subplot(224)
    plot(Y(2,:));
    hold on;
    stairs(Yzad(2,:),'--')
    legend('Y2(k)','Y_z_a_d_2(k)','location','best');
    xlabel('k')
    ylabel('Y2(k)')
    hold on;
    
end

if(latex)
    toPlotForLatex(sprintf('z4pidu1_%3.4f_%3.4f_%3.4f',K1,Ti1,Td1),1:kk,U(1,:))
    toPlotForLatex(sprintf('z4pidu2_%3.4f_%3.4f_%3.4f',K2,Ti2,Td2),1:kk,U(2,:))
    toPlotForLatex(sprintf('z4pidy1_%3.4f_%3.4f_%3.4f',K1,Ti1,Td1),1:kk,Y(1,:))
    toPlotForLatex(sprintf('z4pidy2_%3.4f_%3.4f_%3.4f',K2,Ti2,Td2),1:kk,Y(2,:))
    toPlotForLatex(sprintf('z4pidyzad1_%3.4f',Yzad(1,kk)),1:kk,Yzad(1,:))
    toPlotForLatex(sprintf('z4pidyzad2_%3.4f',Yzad(2,kk)),1:kk,Yzad(2,:))
end

end