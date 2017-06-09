function [ E ] = zad3DMC(D,N,Nu,lambda,psi,draw,latex)
D=round(D);
N=round(N);
Nu=round(Nu);
load('sU1Y1.txt');
load('sU1Y2.txt');
load('sU1Y3.txt');
load('sU2Y1.txt');
load('sU2Y2.txt');
load('sU2Y3.txt');
load('sU3Y1.txt');
load('sU3Y2.txt');
load('sU3Y3.txt');
load('sU4Y1.txt');
load('sU4Y2.txt');
load('sU4Y3.txt');
s11=sU1Y1(1:D,2);
s12=sU2Y1(1:D,2);
s13=sU3Y1(1:D,2);
s14=sU4Y1(1:D,2);
s21=sU1Y2(1:D,2);
s22=sU2Y2(1:D,2);
s23=sU3Y2(1:D,2);
s24=sU4Y2(1:D,2);
s31=sU1Y3(1:D,2);
s32=sU2Y3(1:D,2);
s33=sU3Y3(1:D,2);
s34=sU4Y3(1:D,2);
kk=910;
ny=3;
nu=4;
y=zeros(ny,kk);
yzad=zeros(ny,kk);
yzad(1,10:kk)=1;
yzad(2,110:kk)=1;
yzad(3,210:kk)=1;
yzad(1,310:kk)=-1;
yzad(2,410:kk)=-1;
yzad(3,510:kk)=-1;
yzad(1,610:kk)=2;
yzad(2,710:kk)=2;
yzad(3,810:kk)=2;
u=zeros(nu,kk);
du=zeros(nu,kk);
dUP=zeros((D-1)*nu,1);
Y=zeros(N*ny,1);
Yzad=zeros(N*ny,1);
M=cell(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)={[s11(i-j+1) s12(i-j+1) s13(i-j+1) s14(i-j+1);...
             s21(i-j+1) s22(i-j+1) s23(i-j+1) s24(i-j+1);...
             s31(i-j+1) s32(i-j+1) s33(i-j+1) s34(i-j+1)]};
      else
          M(i,j)={zeros(ny,nu)};
      end;
   end;
end
M=cell2mat(M);
MP=cell(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)={[s11(i+j)-s11(j) s12(i+j)-s12(j) s13(i+j)-s13(j) s14(i+j)-s14(j);...
             s21(i+j)-s21(j) s22(i+j)-s22(j) s23(i+j)-s23(j) s24(i+j)-s24(j);...
             s31(i+j)-s31(j) s32(i+j)-s32(j) s33(i+j)-s33(j) s34(i+j)-s34(j)]};
      else
         MP(i,j)={[s11(D)-s11(j) s12(D)-s12(j) s13(D)-s13(j) s14(D)-s14(j);...
             s21(D)-s21(j) s22(D)-s22(j) s23(D)-s23(j) s24(D)-s24(j);...
             s31(D)-s31(j) s32(D)-s32(j) s33(D)-s33(j) s34(D)-s34(j)]};
      end;      
   end;
end;
MP=cell2mat(MP);
LAMBDA=cell(Nu,Nu);
for i=1:Nu
    for j=1:Nu
        if i==j
            LAMBDA(i,j)={diag(lambda)};
        else
            LAMBDA(i,j)={zeros(nu,nu)};
        end
    end
end
LAMBDA=cell2mat(LAMBDA);
PSI=cell(N,N);
for i=1:N
    for j=1:N
        if i==j
            PSI(i,j)={diag(psi)};
        else
            PSI(i,j)={zeros(ny,ny)};
        end
    end
end
PSI=cell2mat(PSI);
K=(M'*PSI*M+LAMBDA)^(-1)*M'*PSI;
K1=K(1:nu,:);
for k=10:kk
    [y(1,k),y(2,k),y(3,k)]=symulacja_obiektu3(u(1,k-1),u(1,k-2),u(1,k-3),u(1,k-4),...
        u(2,k-1),u(2,k-2),u(2,k-3),u(2,k-4),...
        u(3,k-1),u(3,k-2),u(3,k-3),u(3,k-4),...
        u(4,k-1),u(4,k-2),u(4,k-3),u(4,k-4),...
        y(1,k-1),y(1,k-2),y(1,k-3),y(1,k-4),...
        y(2,k-1),y(2,k-2),y(2,k-3),y(2,k-4),...
        y(3,k-1),y(3,k-2),y(3,k-3),y(3,k-4));
    Y(1:3:(N*ny))=y(1,k);
    Y(2:3:(N*ny))=y(2,k);
    Y(3:3:(N*ny))=y(3,k);
    Yzad(1:3:(N*ny))=yzad(1,k);
    Yzad(2:3:(N*ny))=yzad(2,k);
    Yzad(3:3:(N*ny))=yzad(3,k);
    du(:,k)=K1*(Yzad-Y-MP*dUP);
    for i=((D-1)*nu):-4:8
      dUP(i)=dUP(i-4);
      dUP(i-1)=dUP(i-5);
      dUP(i-2)=dUP(i-6);
      dUP(i-3)=dUP(i-7);
    end
   dUP(1:4)=du(:,k);
   u(:,k)=u(:,k-1)+du(:,k);
end

e=yzad-y;
E1=sum(e(1,:).^2);
E2=sum(e(2,:).^2);
E3=sum(e(3,:).^2);
E=E1+E2+E3;

if(draw)
    
    subplot(241)
    plot(u(1,:));
    title({'Algorytm DMC ';['lambda = ', num2str(lambda(1))]});
    xlabel('k')
    ylabel(sprintf('u1(k)'))
    
    subplot(242)
    plot(u(2,:));
    title({'Algorytm DMC ';['lambda = ', num2str(lambda(2))]});
    xlabel('k')
    ylabel(sprintf('u2(k)'))
    
    subplot(243)
    plot(u(3,:));
    title({'Algorytm DMC ';['lambda = ', num2str(lambda(3))]});
    xlabel('k')
    ylabel(sprintf('u3(k)'))
    
    subplot(244)
    plot(u(4,:));
    title({'Algorytm DMC ';['lambda = ', num2str(lambda(4))]});
    xlabel('k')
    ylabel(sprintf('u4(k)'))
    
    subplot(245)
    plot(y(1,:));
    title({['E= ',num2str(E)];['E1 = ',num2str(E1)];['psi = ', num2str(psi(1))]})
    hold on;
    stairs(yzad(1,:),'r--')
    legend('Y1(k)','Y_z_a_d_1(k)','location','best');
    xlabel('k')
    ylabel('Y1(k)')
    
    subplot(246)
    plot(y(2,:));
    title({['E= ',num2str(E)];['E2 = ',num2str(E2)];['psi = ', num2str(psi(2))]})
    hold on;
    stairs(yzad(2,:),'r--')
    legend('Y2(k)','Y_z_a_d_2(k)','location','best');
    xlabel('k')
    ylabel('Y2(k)')
    
    subplot(247)
    plot(y(3,:));
    title({['E= ',num2str(E)];['E3 = ',num2str(E3)];['psi = ', num2str(psi(3))]})
    hold on;
    stairs(yzad(3,:),'r--')
    legend('Y3(k)','Y_z_a_d_3(k)','location','best');
    xlabel('k')
    ylabel('Y3(k)')
    
end

if(latex)
    foldername=sprintf('dmc_%d_%d_%d/%3.4f_%3.4f_%3.4f_%3.4f_%3.4f_%3.4f_%3.4f',D,N,Nu,psi(1),psi(2),psi(3),lambda(1),lambda(2),lambda(3),lambda(4));
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