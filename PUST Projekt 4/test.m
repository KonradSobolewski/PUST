clear all
close all
X=-2:0.1:2;
d=10;
c1=0;
c2=1.4;

% b=Inf;
% d=2;
% c=0;
for k=1:length(X)
    Y(k)=1/(1+exp(-d*(X(k)-c1)))-1/(1+exp(-d*(X(k)-c2)));
    
    %Y(k)=1/(1+((X(k)-c)/d)^2^b);
end
plot(X,Y)