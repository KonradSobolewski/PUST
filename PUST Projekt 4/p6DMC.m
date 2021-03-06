function [E]=p6DMC(N,Nu,lambda,n,d,c,latex)

%aktualnie najlepsze: 
%p6DMC(12,1,[800 0.01 1 110],4,0.4,[-0.05 0.5 1.4],false)
%p6DMC(100,100,[510 25],2,0.2,[0.5],false)


%algorytm DMC z opcjonalnym uwzględnieniem parametrów
close all
N=round(N);
Nu=round(Nu);
load('p2/z2_y21.txt')
s1=load('skok_-1.000_-0.900.txt');
sn=load('skok_0.900_1.000.txt');
D=100;
Upp=0;
Ypp=0;
Umin=-1;
Umax=1;

%inicjalizacja stałych
kk=1410;
startk=10;
%DMC
%----------------------------------------------------------------

M=zeros(N,Nu);
MP=zeros(N,D-1);
I=eye(Nu);
ku=zeros(n,D-1);
ke=zeros(1,n);
for m=1:n
    if m==1
        s=s1(:,2);
    elseif m==n
        s=sn(:,2);
    elseif m==2 && n==3
        stemp=load('skok_-0.089_0.502.txt');
        s=stemp(:,2);
    elseif m==2 && n==4
        stemp=load('skok_-0.089_0.293.txt');
        s=stemp(:,2);
    elseif m==3 && n==4
        stemp=load('skok_0.293_0.502.txt');
        s=stemp(:,2);
    elseif m==2 && n==5
        stemp=load('skok_-0.089_0.194.txt');
        s=stemp(:,2);
    elseif m==3 && n==5
        stemp=load('skok_0.194_0.377.txt');
        s=stemp(:,2);
    elseif m==4 && n==5
        stemp=load('skok_0.377_0.502.txt');
        s=stemp(:,2);
    end
%     s=z2_y21(16:115,2);
    
    
    for i=1:N
        for j=1:Nu
            if (i>=j)
                M(i,j)=s(i-j+1);
            end;
        end;
    end;
    
    for i=1:N
        for j=1:D-1
            if i+j<=D
                MP(i,j)=s(i+j)-s(j);
            else
                MP(i,j)=s(D)-s(j);
            end;
        end;
    end;
    
    K=((M'*M+lambda(m)*I)^-1)*M';
    ku(m,:)=K(1,:)*MP;
    ke(m)=sum(K(1,:));
end

% Obliczanie parametrów regulatora


U(1:kk)=Upp;
Y(1:kk)=Ypp;

e=zeros(1,kk);
Yzad(1:startk)=Ypp;
Yzad(startk:210)=5;
Yzad(210:410)=2;
Yzad(410:610)=4;
Yzad(610:810)=-0.15;
Yzad(810:1010)=-0.05;
Yzad(1010:1210)=-0.1;
Yzad(1210:1410)=1;
% Yzad(startk:1410)=Ypp+5;

deltaup=zeros(1,D-1);

Un=zeros(1,n);
mi=Un;

for k=7:kk
    %symulacja obiektu
    Y(k)= symulacja_obiektu3y(U(k-5),U(k-6),Y(k-1),Y(k-2));
    %uchyb regulacji
    e(k)=Yzad(k) - Y(k);
    
    for m=1:n
        % Prawo regulacji
        Un(m)=ke(m)*e(k)-ku(m,:)*deltaup';
        %Un(m)=U(k-1)+deltauk;
    end
    if n==2
        mi(1)=1-1/(1+exp(-d*(Y(k)-c(1))));%0.5
        mi(2)=1/(1+exp(-d*(Y(k)-c(1))));
    elseif n==3
        mi(1)=1-1/(1+exp(-d*(Y(k)-c(1))));%-0.05
        mi(2)=1/(1+exp(-d*(Y(k)-c(1))))-1/(1+exp(-d*(Y(k)-c(2))));%1.4
        mi(3)=1/(1+exp(-d*(Y(k)-c(2))));
    elseif n==4 %200 10 2 0.1
        %p6DMC(100,100,[3 4 5 30],4,[200 10 2 0.1],[-0.05 0.8 1.4],false)
        mi(1)=1-1/(1+exp(-d*(Y(k)-c(1))));%-0.05
        mi(2)=1/(1+exp(-d*(Y(k)-c(1))))-1/(1+exp(-d*(Y(k)-c(2))));%0.5
        mi(3)=1/(1+exp(-d*(Y(k)-c(2))))-1/(1+exp(-d*(Y(k)-c(3))));%1.4
        mi(4)=1/(1+exp(-d*(Y(k)-c(3))));
    elseif n==5 %200 40 40 30 10
        mi(1)=1-1/(1+exp(-d*(Y(k)-c(1))));%-0.05
        mi(2)=1/(1+exp(-d*(Y(k)-c(1))))-1/(1+exp(-d*(Y(k)-c(2))));%0.25
        mi(3)=1/(1+exp(-d*(Y(k)-c(2))))-1/(1+exp(-d*(Y(k)-c(3))));%0.5
        mi(4)=1/(1+exp(-d*(Y(k)-c(3))))-1/(1+exp(-d*(Y(k)-c(4))));%1.4
        mi(5)=1/(1+exp(-d*(Y(k)-c(4))));
    end
    
    
    deltauk=sum(Un*mi')/sum(mi);
    for i=D-1:-1:2
        deltaup(i)=deltaup(i-1);
    end
    deltaup(1)=deltauk;
    U(k)=U(k-1)+deltauk;
    if U(k)>Umax
        U(k)=Umax;
    elseif U(k)<Umin
        U(k)=Umin;
    end
end
figure
plot(Y)
title('y')
hold on
plot(Yzad,'r-')
% figure
% plot(U)
% title('u')
if latex==true
    toPlotForLatex('p6dmcY74',1:kk,Y);
    toPlotForLatex('p6dmcU74',1:kk,U);
    toPlotForLatex('lab6Yzad',1:kk,Yzad);
end

%obliczenie błędu
E=sum((e).^2);
end