clear all;

Upp=0.8;
U = zeros(200,1);
Y = zeros(200,1);
for k=12:200
    Y(k)=symulacja_obiektu11Y(Upp,Upp,Y(k-1),Y(k-2));
end

plot(Y);
ylabel('y');
xlabel('kroki');
legend('Y(k)');
title('Punkt pracy Upp = 0.8');
toPlotForLatex('z1',1:length(Y),Y');