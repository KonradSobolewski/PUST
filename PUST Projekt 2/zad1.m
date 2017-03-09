clear all;

Tp=0.5;
Upp=1;
U = zeros(200,1);
Y = zeros(200,1);
Z = zeros(200,1);
for k=5:200
    Y(k)=symulacja_obiektu7y(Upp,Upp,Z(k-1),Z(k-2),Y(k-1),Y(k-2));
end  %U(k-4),U(k-5)

plot(Y);
ylabel('y');
xlabel('kroki');
legend('Y(k)');
title('Punkt pracy Upp = 1');
toPlotForLatex('z1',1:length(Y),Y');