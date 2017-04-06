clear all
close all
load('z3Y1U1.txt');
load('z3Y1U2.txt');
load('z3Y2U1.txt');
load('z3Y2U2.txt');
s11=z3Y1U1(:,2);
s12=z3Y1U2(:,2);
s21=z3Y2U1(:,2);
s22=z3Y2U2(:,2);
D=100;
N=D;
Nu=D;
lambda=1;
kk=100;
ny=2;
nu=2;
y=zeros(ny,kk);
yzad=zeros(ny,kk);
yzad(1,10:kk)=1;
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
         MP(i,j)={[s11(D)-s11(j), s12(D)-s12(j); s21(D)-s21(j), s22(D)-s22(j)]};
      end;      
   end;
end;
K=(cell2mat(M)'*cell2mat(M)-diag(ones(1,Nu*nu)*lambda))^(-1)*cell2mat(M)';
ku=K(nu,:)*cell2mat(MP);
ke1=sum(K(1,1:2:N*ny));
ke2=sum(K(1,2:2:N*ny));
ke3=sum(K(2,1:2:N*ny));
ke4=sum(K(2,2:2:N*ny));
for k=10:kk
    y(1,k)=symulacja_obiektu3y1(u(1,k-5),u(1,k-6),u(2,k-2),u(2,k-3),y(1,k-1),y(1,k-2));
    y(2,k)=symulacja_obiektu3y2(u(1,k-6),u(1,k-7),u(2,k-4),u(2,k-5),y(2,k-1),y(2,k-2));
    du(:,k)=[ke1 ke2;ke3 ke4]*(yzad(:,k)-y(:,k))-ku*cell2mat(dUP);
    for n=D-1:-1:2
      dUP(n)=dUP(n-1);
    end
   dUP(1)={du(:,k)};
   u(:,k)=u(:,k-1)+du(:,k);
end
subplot(2,2,1)
plot(u(1,:))
subplot(2,2,2)
plot(u(2,:))
subplot(2,2,3)
plot(y(1,:))
hold on
plot(yzad(1,:))
subplot(2,2,4)
plot(y(2,:))
hold on
plot(yzad(2,:))