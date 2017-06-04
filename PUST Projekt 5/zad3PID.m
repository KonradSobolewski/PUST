function [ E ] = zad3PID( K,Ti,Td,var,draw,latex )
Tp=0.5;
kk=910;
r0=zeros(1,3);
r1=zeros(1,3);
r2=zeros(1,3);
for i=1:3
    r0(i)=K(i)*(1+Tp/(2*Ti(i))+Td(i)/Tp);
    r1(i)=K(i)*(Tp/(2*Ti(i))-2*Td(i)/Tp-1);
    r2(i)=K(i)*Td(i)/Tp;
end
u=zeros(4,kk);
y=zeros(3,kk);
e=zeros(3,kk);
yzad=y;
yzad(1,10:kk)=1;
yzad(2,110:kk)=1;
yzad(3,210:kk)=1;
yzad(1,310:kk)=-1;
yzad(2,410:kk)=-1;
yzad(3,510:kk)=-1;
yzad(1,610:kk)=2;
yzad(2,710:kk)=2;
yzad(3,810:kk)=2;
for k=5:kk; %glówna petla symulacyjna
    %symulacja obiektu
    [y(1,k),y(2,k),y(3,k)]=symulacja_obiektu3(u(1,k-1),u(1,k-2),u(1,k-3),u(1,k-4),...
        u(2,k-1),u(2,k-2),u(2,k-3),u(2,k-4),...
        u(3,k-1),u(3,k-2),u(3,k-3),u(3,k-4),...
        u(4,k-1),u(4,k-2),u(4,k-3),u(4,k-4),...
        y(1,k-1),y(1,k-2),y(1,k-3),y(1,k-4),...
        y(2,k-1),y(2,k-2),y(2,k-3),y(2,k-4),...
        y(3,k-1),y(3,k-2),y(3,k-3),y(3,k-4));
    %uchyb regulacji
    e(:,k)=yzad(:,k)-y(:,k);
    %sygna³y steruj¹ce regulatora PID
    u(var(1),k)=r2(1)*e(1,k-2)+r1(1)*e(1,k-1)+r0(1)*e(1,k)+u(var(1),k-1);
    u(var(2),k)=r2(2)*e(2,k-2)+r1(2)*e(2,k-1)+r0(2)*e(2,k)+u(var(2),k-1);
    u(var(3),k)=r2(3)*e(3,k-2)+r1(3)*e(3,k-1)+r0(3)*e(3,k)+u(var(3),k-1);
end;
E1=sum(e(1,:).^2);
E2=sum(e(2,:).^2);
E3=sum(e(3,:).^2);
E=E1+E2+E3;
if(draw)
    
    subplot(231)
    plot(u(var(1),:));
    title({'Algorytm PID ';['K = ', num2str(K(1)), ', Ti = ', num2str(Ti(1)),', Td = ',num2str(Td(1))]});
    xlabel('k')
    ylabel(sprintf('u%d(k)',var(1)))
    
    subplot(232)
    plot(u(var(2),:));
    title({'Algorytm PID ';['K = ', num2str(K(2)), ', Ti = ', num2str(Ti(2)),', Td = ',num2str(Td(2))]});
    xlabel('k')
    ylabel(sprintf('u%d(k)',var(2)))
    
    subplot(233)
    plot(u(var(3),:));
    title({'Algorytm PID ';['K = ', num2str(K(3)), ', Ti = ', num2str(Ti(3)),', Td = ',num2str(Td(3))]});
    xlabel('k')
    ylabel(sprintf('u%d(k)',var(3)))
    
    subplot(234)
    plot(y(1,:));
    title({['E= ',num2str(E)];['E1 = ',num2str(E1)]})
    hold on;
    stairs(yzad(1,:),'r--')
    legend('Y1(k)','Y_z_a_d_1(k)','location','best');
    xlabel('k')
    ylabel('Y1(k)')
    
    subplot(235)
    plot(y(2,:));
    title({['E= ',num2str(E)];['E2 = ',num2str(E2)]})
    hold on;
    stairs(yzad(2,:),'r--')
    legend('Y2(k)','Y_z_a_d_2(k)','location','best');
    xlabel('k')
    ylabel('Y2(k)')
    
    subplot(236)
    plot(y(3,:));
    title({['E= ',num2str(E)];['E3 = ',num2str(E3)]})
    hold on;
    stairs(yzad(3,:),'r--')
    legend('Y3(k)','Y_z_a_d_3(k)','location','best');
    xlabel('k')
    ylabel('Y3(k)')
    
end
if(latex)
    foldername=sprintf('pid_%d_%d_%d/%3.4f_%3.4f_%3.4f_%3.4f_%3.4f_%3.4f_%3.4f_%3.4f_%3.4f',var(1),var(2),var(3),K(1),K(2),K(3),Ti(1),Ti(2),Ti(3),Td(1),Td(2),Td(3));
    mkdir(foldername);
    toPlotForLatex([foldername '/u1'],1:kk,u(1,:))
    toPlotForLatex([foldername '/u2'],1:kk,u(2,:))
    toPlotForLatex([foldername '/u3'],1:kk,u(3,:))
    toPlotForLatex([foldername '/u4'],1:kk,u(4,:))
    toPlotForLatex([foldername '/y1'],1:kk,y(1,:))
    toPlotForLatex([foldername '/y2'],1:kk,y(2,:))
    toPlotForLatex([foldername '/y3'],1:kk,y(3,:))
    toPlotForLatex([foldername '/yzad1'],1:kk,yzad(1,:))
    toPlotForLatex([foldername '/yzad2'],1:kk,yzad(2,:))
    toPlotForLatex([foldername '/yzad3'],1:kk,yzad(3,:))
    fileID=fopen([foldername '/E.txt'],'w');
    fprintf(fileID,'%1.4f\n',E1);
    fprintf(fileID,'%1.4f\n',E2);
    fprintf(fileID,'%1.4f\n',E3);
    fprintf(fileID,'%1.4f\n',E);
    fclose(fileID);
end

end