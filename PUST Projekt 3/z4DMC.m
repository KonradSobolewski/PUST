function [ E ] = z4DMC(N,Nu,lambda,draw,latex)
%-------------------------------------------------------------
%Odp Skokowa
kk=1000;
ny=2;
nu=2;
y=zeros(ny,kk);
yzad=zeros(ny,kk);
u=zeros(nu,kk);
du=zeros(nu,kk);
Yzad(1:N,1)={yzad};
% dU=0.2;
% Upp=0.8;
% Ypp=5;
% Umin=0.6;
% Umax=1;
% dUmax=0.05;
% kk=250;
% startk=15;
% 
% U(1:kk)=Upp;
% Y(1:kk)=Ypp;
% U(startk:kk)=Upp+dU;
% if Upp+dU>Umax
%    dU=Umax;
% elseif Upp-dU<Umin
%     dU=Umin;
% end
% for k=startk:kk 
%     Y(k)=symulacja_obiektu11Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
% end
% S=(Y-Ypp)/dU;
% s=S(startk+1:kk);
% 
%                             %DMC
% %----------------------------------------------------------------
% 
% D=100;  
% N=round(N);
% Nu=round(Nu);
% 
% 
% M=zeros(N,Nu);
% for i=1:N
%    for j=1:Nu
%       if (i>=j)
%          M(i,j)=s(i-j+1);
%       end;
%    end;
% end;
% 
% MP=zeros(N,D-1);
% for i=1:N
%    for j=1:D-1
%       if i+j<=D
%          MP(i,j)=s(i+j)-s(j);
%       else
%          MP(i,j)=s(D)-s(j);
%       end;      
%    end;
% end;
% 
% 
% % Obliczanie parametrów regulatora
% 
% I=eye(Nu);
% K=((M'*M+lambda*I)^-1)*M';
% ku=K(1,:)*MP;
% ke=sum(K(1,:));
% 
% U=Upp*ones(1,kk);
% Y=Ypp*ones(1,kk);
% e=zeros(1,kk);
% 
% Yzad(1:startk)=Ypp; 
% Yzad(startk:kk)=5.2;
% u=U-Upp;
% y=Y-Ypp;
% yzad = Yzad-Ypp;
% umax = Umax - Upp;
% umin = Umin - Upp;
% 
% deltaup=zeros(1,D-1);
% 
% for k=12:kk
%    %symulacja obiektu
%    Y(k)= symulacja_obiektu11Y(U(k-10),U(k-11),Y(k-1),Y(k-2));
%    y(k)=Y(k)-Ypp;
%    yzad(k) = Yzad(k)-Ypp;
%    %uchyb regulacji
%    e(k)=yzad(k) - y(k);
%    % Prawo regulacji
%    deltauk=ke*e(k)-ku*deltaup';        
%    
%    for n=D-1:-1:2
%       deltaup(n)=deltaup(n-1);
%    end
%    
%    if  deltauk>dUmax
%         deltauk=dUmax;
%    elseif deltauk<-dUmax
%         deltauk=-dUmax;
%    end 
%    
%    deltaup(1)=deltauk;
%    u(k)=u(k-1)+deltaup(1);
%    
%    if u(k)>umax
%       	u(k)=umax;
%    elseif u(k)<umin
%         u(k)=umin;
%    end
%    U(k)=u(k)+Upp;
% end
% 
% E=0;
% for k=1:kk
%     E=E+((Yzad(k)-Y(k))^2);
% end 
% 
% if(draw)
%     subplot(211)
%     plot(U);
%     title({'Algorytm DMC ';['D = ', num2str(D), ', N = ', num2str(N),', Nu = ',num2str(Nu), ', lambda = ',num2str(lambda)];['E = ',num2str(E)]; ' '});
%     xlabel('k')
%     ylabel('sterowanie u')
%     legend('U(k)','location','best');
%     hold on;
%     subplot(212)
%     plot(Y);
%     hold on;
%     stairs(Yzad,'--')
%     xlabel('k')
%     ylabel('wyjœcie y')
%     legend('Y(k)','Y_z_a_d(k)','location','best');
%     hold on;
% end
% if(latex)
%     toPlotForLatex(sprintf('dmcu_%d_%d_%3.4f',N,Nu,lambda),1:kk,U)
%     toPlotForLatex(sprintf('dmcy_%d_%d_%3.4f',N,Nu,lambda),1:kk,Y)
%     toPlotForLatex(sprintf('dmcyzad_%3.4f',Yzad(kk)),1:kk,Yzad)
% end
end