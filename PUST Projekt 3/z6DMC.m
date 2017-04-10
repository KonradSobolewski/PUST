function [ E ] = z6DMC(N,Nu,lambda,n,draw,latex)
N=round(N);
Nu=round(Nu);
load('z3Y1U1.txt');
load('z3Y1U2.txt');
load('z3Y2U1.txt');
load('z3Y2U2.txt');
s11=z3Y1U1(:,2);
s12=z3Y1U2(:,2);
s21=z3Y2U1(:,2);
s22=z3Y2U2(:,2);
D=200;
kk=510;
startk1=10;
startk2=260;
ny=2;
nu=2;
y=zeros(ny,kk);
yzad=zeros(ny,kk);
yzad(1,startk1:kk)=1;
yzad(2,startk2:kk)=1;
u=zeros(nu,kk);
du=zeros(nu,kk);
dUP=cell(D-1,1);
dUP(1:D-1)={zeros(2,1)};
M=cell(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)={[s11(i-j+1) s12(i-j+1); s21(i-j+1) s22(i-j+1)]};
      else
          M(i,j)={zeros(nu,ny)};
      end;
   end;
end
MP=cell(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)={[s11(i+j)-s11(j) s12(i+j)-s12(j); s21(i+j)-s21(j) s22(i+j)-s22(j)]};
      else
         MP(i,j)={[s11(D)-s11(j) s12(D)-s12(j); s21(D)-s21(j) s22(D)-s22(j)]};
      end;      
   end;
end;
K=(cell2mat(M)'*cell2mat(M)+diag(ones(1,Nu*nu)*lambda))^(-1)*cell2mat(M)';
ku=K(1:nu,:)*cell2mat(MP);
ke1=sum(K(1,1:2:(N*ny)));
ke2=sum(K(1,2:2:(N*ny)));
ke3=sum(K(2,1:2:(N*ny)));
ke4=sum(K(2,2:2:(N*ny)));
yzak=(2*rand(2,kk)-1)*n;
for k=10:kk
    y(1,k)=symulacja_obiektu3y1(u(1,k-5),u(1,k-6),u(2,k-2),u(2,k-3),y(1,k-1),y(1,k-2));
    y(2,k)=symulacja_obiektu3y2(u(1,k-6),u(1,k-7),u(2,k-4),u(2,k-5),y(2,k-1),y(2,k-2));
    du(:,k)=[ke1 ke2;ke3 ke4]*(yzad(:,k)-y(:,k)-yzak(:,k))-ku*cell2mat(dUP);
    for i=D-1:-1:2
      dUP(i)=dUP(i-1);
    end
   dUP(1)={du(:,k)};
   u(:,k)=u(:,k-1)+du(:,k);
end

E1=0;
E2=0;
for k=1:kk
    E1=E1+((yzad(1,k)-y(1,k))^2);
    E2=E2+((yzad(2,k)-y(2,k))^2);
end
E=E1+E2;

if(draw)
    subplot(3,2,1)
    plot(u(1,:));
    title({'Algorytm DMC ';['D = ', num2str(D), ', N = ', num2str(N),', Nu = ',num2str(Nu), ', lambda = ',num2str(lambda)];['E = ',num2str(E1)]; ' '});
    xlabel('k')
    ylabel('sterowanie u1')
    subplot(3,2,2)
    plot(u(2,:));
    title({'Algorytm DMC ';['D = ', num2str(D), ', N = ', num2str(N),', Nu = ',num2str(Nu), ', lambda = ',num2str(lambda)];['E = ',num2str(E2)]; ' '});
    xlabel('k')
    ylabel('sterowanie u2')
    subplot(3,2,3)
    plot(y(1,:));
    title({'E= ',num2str(E)})
    hold on;
    stairs(yzad(1,:),'r--')
    xlabel('k')
    ylabel('wyjœcie y1')
    legend('Y1(k)','Y1_z_a_d(k)','location','best');
    subplot(3,2,4)
    plot(y(2,:));
    title({'E= ',num2str(E)})
    hold on;
    stairs(yzad(2,:),'r--')
    xlabel('k')
    ylabel('wyjœcie y2')
    legend('Y2(k)','Y2_z_a_d(k)','location','best');
    subplot(325)
    plot(yzak(1,:))
    subplot(326)
    plot(yzak(2,:))
end
if(latex)
    toPlotForLatex(sprintf('z6dmcu1_%d_%d_%3.4f_%3.4f',N,Nu,lambda,E1),1:kk,u(1,:))
    toPlotForLatex(sprintf('z6dmcu2_%d_%d_%3.4f_%3.4f',N,Nu,lambda,E2),1:kk,u(2,:))
    toPlotForLatex(sprintf('z6dmcy1_%d_%d_%3.4f_%3.4f',N,Nu,lambda,E),1:kk,y(1,:))
    toPlotForLatex(sprintf('z6dmcy2_%d_%d_%3.4f_%3.4f',N,Nu,lambda,E),1:kk,y(2,:))
    toPlotForLatex(sprintf('z6dmcyzak1_%d_%d_%3.4f_%3.4f_%d',N,Nu,lambda,E,n),1:kk,yzak(1,:))
    toPlotForLatex(sprintf('z6dmcyzak2_%d_%d_%3.4f_%3.4f_%d',N,Nu,lambda,E,n),1:kk,yzak(2,:))
    toPlotForLatex(sprintf('z6dmcyzad1_%3.4f',yzad(1,kk)),1:kk,yzad(1,:))
    toPlotForLatex(sprintf('z6dmcyzad2_%3.4f',yzad(2,kk)),1:kk,yzad(2,:))
end
end