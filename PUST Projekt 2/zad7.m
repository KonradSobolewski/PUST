function [E]=zad7(DZ,N,Nu,lambda,s,sz,draw,latex,Z)
%DZ - horyzont dynamiki zak³óceñ
%N - horyzont predykcji
%Nu - horyzont sterowania
%lambda - lambda
%s - znormalizowana odpowiedŸ skokowa toru sterowania
%sz - znormalizowana odpowiedŸ skokowa toru zak³óceñ
%draw - boolean, okreœla czy rysowaæ wykresy
%latex - boolean, okreœla czy zapisywaæ zmienne do txt dla latexa
%Z - najwiêkszy mo¿liwy szum pomiaru zak³ócenia 
D=100;
N=round(N);
Nu=round(Nu);
kk=150;
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

MZP=zeros(N,DZ-1);
for i=1:N
   for j=1:DZ-1
      if i+j<=DZ
         MZP(i,j)=sz(i+j)-sz(j);
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

%inicjalizacja wektorów
u(1:kk)=0;
y(1:kk)=0;
z(1:kk)=0;
startz=50;

z(startz:kk)= 1;
zz(1:kk)= z+rand(1,kk)*2*Z-Z;

e=zeros(1,kk);
yzad(1:startk)=0; 
yzad(startk:kk)=1;


deltaup=zeros(1,D-1);
deltazp=zeros(1,DZ-1);

for k=startk:kk
   %symulacja obiektu
   y(k)= symulacja_obiektu7y(u(k-4),u(k-5),z(k-1),z(k-2),y(k-1),y(k-2));
   %uchyb regulacji
   e(k)=yzad(k) - y(k);
   
   for n=DZ-1:-1:2;
       deltazp(n)=deltazp(n-1);
   end
   deltazp(1)=zz(k)-zz(k-1);
   
   % Prawo regulacji
   deltauk=ke*e(k)-ku*deltaup';
   deltauk=deltauk-kz*deltazp';
   
   for n=D-1:-1:2
      deltaup(n)=deltaup(n-1);
   end
   deltaup(1)=deltauk;
   u(k)=u(k-1)+deltaup(1);
   
end
%obliczanie b³êdu
E=0;
for k=1:kk
    E=E+((yzad(k)-y(k))^2);
end 
%rysowanie wykresów
if(draw)
    subplot(311)
    plot(u);
    title({'Algorytm DMC ';['DZ = ', num2str(DZ),', D = ', num2str(D), ', N = ', num2str(N),', Nu = ',num2str(Nu), ', lambda = ',num2str(lambda)];['E = ',num2str(E)];})
    xlabel('k')
    ylabel('sterowanie u')
    legend('U(k)','location','best');
    hold on;
    subplot(312)
    plot(y);
    hold on;
    stairs(yzad,'--')
    xlabel('k')
    ylabel('wyjœcie y')
    legend('Y(k)','Y_z_a_d(k)','location','best');
    hold on;
    subplot(313)
    stairs(z)
    hold on
    plot(zz)
    legend('z(k)','zz(k)')
    xlabel('k')
    ylabel('z(k)')
    hold on;
end
%zapis wykresów dla latexa
if(latex)
    toPlotForLatex(['7' sprintf('dmcu_%d_%d_%3.4f_%d_%3.4f',N,Nu,lambda,DZ,Z)],1:kk,u)
    toPlotForLatex(['7' sprintf('dmcy_%d_%d_%3.4f_%d_%3.4f',N,Nu,lambda,DZ,Z)],1:kk,y)
    toPlotForLatex(['7z' sprintf('%3.4f',z(kk))],1:kk,z)
    toPlotForLatex(['7zz' sprintf('%3.4f',Z)],1:kk,zz)
    toPlotForLatex(sprintf('dmcyzad_%3.4f',yzad(kk)),1:kk,yzad)
end
end