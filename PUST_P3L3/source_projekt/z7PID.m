function [ E ] = z7PID( K1,Ti1,Td1,K2,Ti2,Td2,var,n,draw,latex )

Tp=0.5;
kk=860;
startk=10;
%wybór wariantu
if var~=1 && var~=2
    error('Wybierz wariant 1 lub 2.')
end
%obliczanie parametrów regulatora
r0=[K1*(1+Tp/(2*Ti1)+Td1/Tp);K2*(1+Tp/(2*Ti2)+Td2/Tp)];
r1=[K1*(Tp/(2*Ti1)-2*Td1/Tp-1);K2*(Tp/(2*Ti2)-2*Td2/Tp-1)];
r2=[K1*Td1/Tp;K2*Td2/Tp];
%inicjalizacja wektorów
u=zeros(2,kk);
y=zeros(2,kk);
e=zeros(2,kk);
yzad=y;
yzad(1,startk:kk)=1;
yzad(2,startk:kk)=1;
%zak³ócenia
yzak=y;
yzak(1,260:kk)=n;
yzak(2,410:kk)=n;
yzak(1,560:kk)=2*n;
yzak(2,710:kk)=2*n;
for k=startk:kk; %glówna petla symulacyjna
    %symulacja obiektu
    y(1,k)=symulacja_obiektu3y1(u(1,k-5),u(1,k-6),u(2,k-2),u(2,k-3),y(1,k-1),y(1,k-2))+yzak(1,k);
    y(2,k)=symulacja_obiektu3y2(u(1,k-6),u(1,k-7),u(2,k-4),u(2,k-5),y(2,k-1),y(2,k-2))+yzak(2,k);
    %uchyb regulacji
    e(:,k)=yzad(:,k)-y(:,k);
    %sygna³ steruj¹cy regulatora PID
    if var==1
        u(1,k)=r2(1)*e(1,k-2)+r1(1)*e(1,k-1)+r0(1)*e(1,k)+u(1,k-1);
        u(2,k)=r2(2)*e(2,k-2)+r1(2)*e(2,k-1)+r0(2)*e(2,k)+u(2,k-1);
    else
        u(1,k)=r2(1)*e(2,k-2)+r1(1)*e(2,k-1)+r0(1)*e(2,k)+u(1,k-1);
        u(2,k)=r2(2)*e(1,k-2)+r1(2)*e(1,k-1)+r0(2)*e(1,k)+u(2,k-1);
    end;
end;
%obliczanie b³êdów
E1=0;
E2=0;
for k=1:kk
    E1=E1+((yzad(1,k)-y(1,k))^2);
    E2=E2+((yzad(2,k)-y(2,k))^2);
end
E=E1+E2;
%rysowanie wykresów
if(draw)
    
    subplot(321)
    plot(u(1,:));
    title({'Algorytm PID ';['K = ', num2str(K1), ', Ti = ', num2str(Ti1),', Td = ',num2str(Td1)];['E = ',num2str(E1)]; ' '});
    xlabel('k')
    ylabel('U1(k)')
    hold on;
    subplot(322)
    plot(u(2,:));
    title({'Algorytm PID ';['K = ', num2str(K2), ', Ti = ', num2str(Ti2),', Td = ',num2str(Td2)];['E = ',num2str(E2)]; ' '});
    xlabel('k')
    ylabel('U2(k)')
    hold on;
    subplot(323)
    plot(y(1,:));
    title({'E= ',num2str(E)})
    hold on;
    stairs(yzad(1,:),'r--')
    legend('Y1(k)','Y_z_a_d_1(k)','location','best');
    xlabel('k')
    ylabel('Y1(k)')
    hold on;
    subplot(324)
    plot(y(2,:));
    title({'E= ',num2str(E)})
    hold on;
    stairs(yzad(2,:),'r--')
    legend('Y2(k)','Y_z_a_d_2(k)','location','best');
    xlabel('k')
    ylabel('Y2(k)')
    hold on;
    subplot(325)
    plot(yzak(1,:))
    subplot(326)
    plot(yzak(2,:))
    
end
%eksport dla latexa
if(latex)
    toPlotForLatex(sprintf('z7pidu1_%d_%3.4f_%3.4f_%3.4f_%3.4f_%3.4f_%d',var,K1,Ti1,Td1,E1,E,n),1:kk,u(1,:))
    toPlotForLatex(sprintf('z7pidu2_%d_%3.4f_%3.4f_%3.4f_%3.4f_%3.4f_%d',var,K2,Ti2,Td2,E2,E,n),1:kk,u(2,:))
    toPlotForLatex(sprintf('z7pidy1_%d_%3.4f_%3.4f_%3.4f_%3.4f_%d',var,K1,Ti1,Td1,E,n),1:kk,y(1,:))
    toPlotForLatex(sprintf('z7pidy2_%d_%3.4f_%3.4f_%3.4f_%3.4f_%d',var,K2,Ti2,Td2,E,n),1:kk,y(2,:))
    toPlotForLatex(sprintf('z7idyzak1_%d_%3.4f_%3.4f_%3.4f_%3.4f_%d',var,K1,Ti1,Td1,E,n),1:kk,yzak(1,:))
    toPlotForLatex(sprintf('z7pidyzak2_%d_%3.4f_%3.4f_%3.4f_%3.4f_%d',var,K2,Ti2,Td2,E,n),1:kk,yzak(2,:))
    toPlotForLatex(sprintf('z7pidyzad1_%3.4f',yzad(1,kk)),1:kk,yzad(1,:))
    toPlotForLatex(sprintf('z7pidyzad2_%3.4f',yzad(2,kk)),1:kk,yzad(2,:))
end

end