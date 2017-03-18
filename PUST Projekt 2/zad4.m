function [ E ] = zad4(N,Nu,lambda,s,draw,latex)

%Inichjalizacja danych
D=100;  
N=round(N);
Nu=round(Nu);
kk=100;
startk=15;
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

% Obliczanie parametrów regulatora

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M';
ku=K(1,:)*MP;
ke=sum(K(1,:));

u(1:kk)=0;
y(1:kk)=0;
z(1:kk)=0;
e=zeros(1,kk);
yzad(1:startk)=0; 
yzad(startk:kk)=1;

deltaup=zeros(1,D-1);

for k=startk:kk
   %symulacja obiektu
   y(k)= symulacja_obiektu7y(u(k-4),u(k-5),z(k-1),z(k-2),y(k-1),y(k-2));
   %uchyb regulacji
   e(k)=yzad(k) - y(k);
   % Prawo regulacji
   deltauk=ke*e(k)-ku*deltaup';        
   
   for n=D-1:-1:2
      deltaup(n)=deltaup(n-1);
   end
   deltaup(1)=deltauk;
   u(k)=u(k-1)+deltaup(1);
   
end

%Obliczanie wskaŸnika jakoœci regulacji
E=0;
for k=1:kk
    E=E+((yzad(k)-y(k))^2);
end 

%Rysowanie
if(draw)
    subplot(211)
    plot(u);
    title({'Algorytm DMC ';['D = ', num2str(D), ', N = ', num2str(N),', Nu = ',num2str(Nu), ', lambda = ',num2str(lambda)];['E = ',num2str(E)]; ' '});
    xlabel('k')
    ylabel('sterowanie u')
    legend('U(k)','location','best');
    hold on;
    subplot(212)
    plot(y);
    hold on;
    stairs(yzad,'--')
    xlabel('k')
    ylabel('wyjœcie y')
    legend('Y(k)','Y_z_a_d(k)','location','best');
    hold on;
end

%Zapis do pliku
if(latex)
    toPlotForLatex(sprintf('dmcu_%d_%d_%3.4f',N,Nu,lambda),1:kk,u)
    toPlotForLatex(sprintf('dmcy_%d_%d_%3.4f',N,Nu,lambda),1:kk,y)
    toPlotForLatex(sprintf('dmcyzad_%3.4f',yzad(kk)),1:kk,yzad)
end
end