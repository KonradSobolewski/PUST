function [ e ] = aproksym_error( T1, T2, K, Td, draw )
%APROKSYM Summary of this function goes here
%   Detailed explanation goes here
Td = round(Td);

alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);

a1 = -alfa1 - alfa2;
a2 = alfa1*alfa2;
b1 = (K/(T1-T2))*(T1*(1-alfa1)-T2*(1-alfa2));
b2 = (K/(T1-T2))*(alfa1*T2*(1-alfa2)-(alfa2*T1*(1-alfa1)))

y=zeros(len(s));
e = 0;
for k=k_skok_sterowania:len(s)
    y(k) =b1*u(k-Td-1) + b2*u(k-Td-2) - a1*y(k-1) - a2*y(k-2); 
    e=e+((s(k)-y(k))^2);
end

if(draw)
    stairs(s);
    title({'Aproksymacja odpowiedzi skokowej ';['T1 = ', num2str(T1), ', T2 = ', num2str(T2),', K = ',num2str(K),', Td = ',num2str(Td)];['e = ',num2str(e)]; ' '});
    xlabel('k')
    ylabel('y')
    hold on;
    plot(y);
    legend('Odpowiedzi skokowa','Aproksymacja','location','best');
end

