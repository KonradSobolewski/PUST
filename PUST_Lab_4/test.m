clear all
close all
X=-10:0.1:10;
d=5;
c1=-2;
c2=Inf;

% b=Inf;
% d=2;
% c=0;
for k=1:length(X)
    Y(k)=1/(1+exp(-d*(X(k)-c1)))-1/(1+exp(-d*(X(k)-c2)));
    
    %Y(k)=1/(1+((X(k)-c)/d)^2^b);
end
plot(X,Y)