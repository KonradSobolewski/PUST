%funkcja dla dmc 2 - 2 
function [ E1,E2,E ] = z4DMC(N,Nu,lambda)%,latex)
addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM5 % initialise com port
N=round(N);
Nu=round(Nu);
%wczytanie odp skokowych
load('aprskoky1u1.txt');
load('aprskoky2u1.txt');
s11=aprskoky1u1(:,2);
s12=aprskoky2u1(:,2);
s21=aprskoky2u1(:,2);
s22=aprskoky1u1(:,2);
Upp=[36 41];
Ypp=[ 39.62  42.06 ];
Umin=[0 0];
Umax=[100 100];
D=300;
kk=1810;
%chwile kolejnych skoków wart zadanej
startk1=10;
startk2=310;
startk3=610;
startk4=910;
startk5=1210;
startk6=1510;
ny=2;
nu=2;
u=diag(Upp)*ones(nu,kk);
y=diag(Ypp)*ones(ny,kk);
yzad=y;
%kolejne skoki wart zadanej
yzad(1,startk1:kk)=Ypp(1)+3;
yzad(2,startk2:kk)=Ypp(2)+3;
yzad(1,startk3:kk)=Ypp(1)+1;
yzad(2,startk4:kk)=Ypp(2)+1;
yzad(1,startk5:kk)=Ypp(1)+2;
yzad(2,startk6:kk)=Ypp(2)+2;
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
u0=zeros(nu,kk);
y0=zeros(ny,kk);
yzad0=yzad-diag(Ypp)*ones(ny,kk);
umin0=Umin-Upp;
umax0=Umax-Upp;
K=(cell2mat(M)'*cell2mat(M)+diag(ones(1,Nu*nu)*lambda))^(-1)*cell2mat(M)';
ku=K(1:nu,:)*cell2mat(MP);
%parametry ke dla ka¿dego toru
ke1=sum(K(1,1:2:(N*ny)));
ke2=sum(K(1,2:2:(N*ny)));
ke3=sum(K(2,1:2:(N*ny)));
ke4=sum(K(2,2:2:(N*ny)));
for k=10:kk
    y(:,k) = readMeasurements ([1,3]) ; % read measurements
    %uchyb regulacji
    y0(:,k)=y(:,k)-Ypp';
    du(:,k)=[ke1 ke2;ke3 ke4]*(yzad0(:,k)-y0(:,k))-ku*cell2mat(dUP);
    for i=D-1:-1:2
      dUP(i)=dUP(i-1);
    end
    dUP(1)={du(:,k)};
    u0(:,k)=u0(:,k-1)+du(:,k);
    %ograniczenia
    if u0(2,k)<umin0(2)
        u0(2,k)=umin0(2);
    elseif u0(2,k)>umax0(2)
        u0(2,k)=umax0(2);
    end
    if u0(1,k)<umin0(1)
        u0(1,k)=umin0(1);
    elseif u0(1,k)>umax0(1)
        u0(1,k)=umax0(1);
    end
    u(:,k)=u0(:,k)+Upp';
    sendControls([1,2,5,6],[50,50,u(1,k),u(2,k)]);
    
    subplot(2,2,1)
    plot(u(1,:));
    title('u1');
    xlabel('k')
    ylabel('sterowanie u1')
    subplot(2,2,2)
    plot(u(2,:));
    title('u2');
    xlabel('k')
    ylabel('sterowanie u2')
    subplot(2,2,3)
    plot(y(1,:));
    title('y1')
    xlabel('k')
    ylabel('wyjœcie y1')
    subplot(2,2,4)
    plot(y(2,:));
    title('y2')
    xlabel('k')
    ylabel('wyjœcie y2')
    drawnow
    
    toPlotForLatex(sprintf('z4dmcu1_%d_%d_%3.4f',N,Nu,lambda),1:kk,u(1,:))
    toPlotForLatex(sprintf('z4dmcu2_%d_%d_%3.4f',N,Nu,lambda),1:kk,u(2,:))
    toPlotForLatex(sprintf('z4dmcy1_%d_%d_%3.4f',N,Nu,lambda),1:kk,y(1,:))
    toPlotForLatex(sprintf('z4dmcy2_%d_%d_%3.4f',N,Nu,lambda),1:kk,y(2,:))
    toPlotForLatex(sprintf('z4dmcyzad1_%3.4f',yzad(1,kk)),1:kk,yzad(1,:))
    toPlotForLatex(sprintf('z4dmcyzad2_%3.4f',yzad(2,kk)),1:kk,yzad(2,:))
    waitForNewIteration();
end

E1=0;
E2=0;
%oblicznie b³êdów
for k=1:kk
    E1=E1+((yzad(1,k)-y(1,k))^2);
    E2=E2+((yzad(2,k)-y(2,k))^2);
end
E=E1+E2;
end