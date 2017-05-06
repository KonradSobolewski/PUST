clear all
close all
X=-10:0.1:10;
d=20;
c1=0;
c2=1.4;

% b=5;
% d=2;
% c=0;

% a=-5;
% b=-3;
% c=3;
% d=5;
for k=1:length(X)
    Y(k)=1/(1+exp(-d*(X(k)-c1)))-1/(1+exp(-d*(X(k)-c2)));
    
%     Y(k)=1/(1+((X(k)-c)/d)^2^b);

%     if X(k)<=a
%         Y(k)=0;
%     elseif X(k)>a && X(k)<=b
%         Y(k)=(X(k)-a)/(b-a);
%     elseif X(k)>b && X(k)<=c
%         Y(k)=1;
%     elseif X(k)>c && X(k)<=d
%         Y(k)=(d-X(k))/(d-c);
%     else
%         Y(k)=0;
%     end
end
plot(X,Y)