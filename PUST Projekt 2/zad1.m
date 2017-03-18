clear all;


%inicjalizacja wektorów
U = zeros(kk,1);
Y = zeros(kk,1);
Z = zeros(kk,1);

%czas symulacji
kk=200;

for k=6:kk
    Y(k)=symulacja_obiektu7y(U(k-4),U(k-5),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
end

%wykresy
plot(Y);
hold on;
plot(U);
plot(Z);
ylabel('y');
xlabel('kroki');
legend('Y(k)','U(k)','Z(k)');
title('Punkt pracy: Upp = Ypp = Zpp = 0');

%zapis wykresów do Latexa
toPlotForLatex('z1u',1:length(U),U');
toPlotForLatex('z1y',1:length(Y),Y');
toPlotForLatex('z1z',1:length(Z),Z');