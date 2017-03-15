function [ e ] = aproksym_fun2( T1, T2, K, Td, draw,s )
%APROKSYM Summary of this function goes here
%   Detailed explanation goes here
Td = round(Td);
Upp=36;
Ypp=36.5;
alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);

a1 = -alfa1 - alfa2;
a2 = alfa1*alfa2;
b1 = (K/(T1-T2))*(T1*(1-alfa1)-T2*(1-alfa2));
b2 = (K/(T1-T2))*(alfa1*T2*(1-alfa2)-(alfa2*T1*(1-alfa1)));

u=Upp*ones(length(s)+Td+2,1);
u(Td+2:length(u))=Upp+1;
y=Ypp*ones(length(s)+Td+2,1);
e = 0;
for k=Td+3:length(y)
    y(k) =b1*u(k-Td-1) + b2*u(k-Td-2) - a1*y(k-1) - a2*y(k-2); 
    e=e+((Ypp+s(k-Td-2)-y(k))^2);
end

if(draw)
    toPlotForLatex('aprskok',Td+3:length(y),y(Td+3:length(y))');
    stairs(s+Ypp);
    title({'Aproksymacja odpowiedzi skokowej ';['T1 = ', num2str(T1), ', T2 = ', num2str(T2),', K = ',num2str(K),', Td = ',num2str(Td)];['e = ',num2str(e)]; ' '});
    xlabel('k')
    ylabel('y')
    hold on;
    plot(y(Td+3:length(y)));
    legend('Odpowiedzi skokowa','Aproksymacja','location','best');
end

if T1==T2
    e=1000;
end
end

