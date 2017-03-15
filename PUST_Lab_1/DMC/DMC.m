function [ E ] = DMC(N,Nu,lambda,draw,latex,s)
                            %DMC
%----------------------------------------------------------------
%punkt pracy
Upp=36;
Ypp=36.5;
kk=600;
startk=30;

%sta³e
Umin=0;
Umax=100;
dUmax=Inf;

D=300;  

N=round(N);
Nu=round(Nu);

%przygotowywanie wektorów
U=Upp*ones(1,kk);
Y=Ypp*ones(1,kk);
U(1:19)=Upp; Y(1:19)=Ypp;
Yzad(1:startk)=Ypp; 
Yzad(startk:330)=40;
Yzad(330:kk)=38;

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


% Obliczanie parametrów regulatora

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M';
ku=K(1,:)*MP;
ke=sum(K(1,:));


e=zeros(1,kk);

u=U-Upp;
y=Y-Ypp;
yzad = Yzad-Ypp;
umax = Umax - Upp;
umin = Umin - Upp;

deltaup=zeros(1,D-1);

TD= 2;
T1=91.607279510963700;
T2=6.971579071504170;
Kp=0.997200696364098;

%obliczanie modelu obiektu
alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);
a1 = -alfa1 - alfa2; 
a2 = alfa1*alfa2;
b1 = (Kp/(T1-T2))*(T1*(1-alfa1)-T2*(1-alfa2));
b2 = (Kp/(T1-T2))*(alfa1*T2*(1-alfa2)-(alfa2*T1*(1-alfa1)));

for k=20:kk
   %symulacja obiektu
   Y(k)= b1*U(k-TD-1) + b2*U(k-TD-2) - a1*Y(k-1) - a2*Y(k-2); 
   y(k)=Y(k)-Ypp;
   yzad(k) = Yzad(k)-Ypp;
   %uchyb regulacji
   e(k)=yzad(k) - y(k);
   % Prawo regulacji
   deltauk=ke*e(k)-ku*deltaup';        
   
   for n=D-1:-1:2
      deltaup(n)=deltaup(n-1);
   end
   
   %Uwzglêdnianie ograniczeñ
   if  deltauk>dUmax
        deltauk=dUmax;
   elseif deltauk<-dUmax
        deltauk=-dUmax;
   end 
   
   deltaup(1)=deltauk;
   u(k)=u(k-1)+deltaup(1);
   
   if u(k)>umax
      	u(k)=umax;
   elseif u(k)<umin
        u(k)=umin;
   end
   U(k)=u(k)+Upp;
end
%Obliczanie b³êdu
E=0;
for k=1:kk
    E=E+((Yzad(k)-Y(k))^2);
end 
%Opcjonalne rysowanie
if(draw)
    subplot(211)
    plot(U);
    title({'Algorytm DMC ';['D = ', num2str(D), ', N = ', num2str(N),', Nu = ',num2str(Nu), ', lambda = ',num2str(lambda)];['E = ',num2str(E)]; ' '});
    xlabel('k')
    ylabel('sterowanie u')
    legend('U(k)','location','best');
    hold on;
    subplot(212)
    plot(Y);
    hold on;
    stairs(Yzad,'--')
    xlabel('k')
    ylabel('wyjœcie y')
    legend('Y(k)','Y_z_a_d(k)','location','best');
    hold on;
end
%Opcjonalny zapis do pliku
if(latex)
    toPlotForLatex(sprintf('dmcu_%d_%d_%3.4f',N,Nu,lambda),1:kk,U)
    toPlotForLatex(sprintf('dmcy_%d_%d_%3.4f',N,Nu,lambda),1:kk,Y)
    toPlotForLatex(sprintf('dmcyzad_%3.4f',Yzad(kk)),1:kk,Yzad)
end
end