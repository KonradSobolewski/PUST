addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM14 % initialise com port

D=100;
DZ=D;
N=D;
Nu=D;
lambda=D;
s=D;
sz=D;
zak=1;
Upp=0.8;
Ypp=5;
Umin=0;
Umax=100;

%inicjalizacja stałych
kk=310;
startk=10;
                            %DMC
%----------------------------------------------------------------
M=zeros(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)=s(i-j+1);
      end;
   end;
end;

MP=zeros(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)=s(i+j)-s(j);
      else
         MP(i,j)=s(D)-s(j);
      end;      
   end;
end;

MZP=zeros(N,DZ);
for i=1:N
    MZP(i,1) = sz(i);
   for j=2:DZ
      if i+j-1<=DZ
         MZP(i,j)=sz(i+j-1)-sz(j);
      else
         MZP(i,j)=sz(DZ)-sz(j);
      end;      
   end;
end;

% Obliczanie parametrów regulatora

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M';
ku=K(1,:)*MP;
kz=K(1,:)*MZP;
ke=sum(K(1,:));

U(1:kk)=Upp;
Y(1:kk)=Ypp;
Z(1:kk)=0;
%startz=300;
%z(startz:kk)= 1;

e=zeros(1,kk);
Yzad(1:startk)=Ypp; 
Yzad(startk:kk)=Ypp+1;

u=U-Upp;
y=U-Ypp;
yzad = Yzad-Ypp;
umax = Umax - Upp;
umin = Umin - Upp;

deltaup=zeros(1,D-1);
deltazp=zeros(1,DZ-1);


for k=startk:kk
   %symulacja obiektu
   Y(k)= readMeasurements(1);
   y(k) = Y(k) - Ypp;
   %uchyb regulacji
   e(k)=yzad(k) - y(k);
   
   %uwzględnianie zakłócenia
   for n=DZ:-1:2;
       deltazp(n)=deltazp(n-1);
   end
   deltazp(1)=Z(k)-Z(k-1);
   
   % Prawo regulacji
   deltauk=ke*e(k)-ku*deltaup';
   if(zak)
       deltauk=deltauk-kz*deltazp';
   end;
   
   for n=D-1:-1:2
      deltaup(n)=deltaup(n-1);
   end
   deltaup(1)=deltauk;
   u(k)=u(k-1)+deltaup(1);
   
   if u(k)>umax
      	u(k)=umax;
   elseif u(k)<umin
        u(k)=umin;
   end
   U(k)=u(k)+Upp;
   
    sendControlsToG1AndDisturbance(U(k),Z(k));
   
    waitForNewIteration (); % wait for new iteration
    plot(Y)
    drawnow
    
    toPlotForLatex('dmc_y',1:kk,Y);
    toPlotForLatex('dmc_u',1:kk,Z);
    toPlotForLatex('dmc_yzad',1:kk,Yzad);
    toPlotForLatex('dmc_z',1:kk,Z);
end

E=0;
for k=1:kk
    E=E+((Yzad(k)-Y(k))^2);
end 