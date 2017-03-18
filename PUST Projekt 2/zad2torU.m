clear all

%inicjalizacja sta³ych i wektorów
kk=200;
startk=15;
dU=-0.2:0.05:0.2;
L = length(dU);
U = zeros(L,kk);
Y = zeros(L,kk);
Z = zeros(L,kk);
Yu=zeros(1,L);
Yd=zeros(1,floor(L/2));

%symulacja obiektu dla kolejnych skoków sterowania
for i=1:L
    U(i,startk:kk)=dU(i);
    for k=startk:kk
        Y(i,k)=symulacja_obiektu7y(U(i,k-4),U(i,k-5),Z(i,k-1),Z(i,k-2),Y(i,k-1),Y(i,k-2));
    end
    Yu(i)=Y(i,kk);
    if dU(i)>0
        for k=startk:kk
            if Y(i,k)>0.9*Yu(i)
                Yd(i-ceil(L/2))=k-startk;
                break;
            end
        end
    end
end

%wykres odpowiedzi obiektu na zmiany w torze U
figure(1)
for i=1:L
    subplot(211)
    title('U(k)')
    set(stairs(U(i,:),'--'),'color',[(L-i)/L mod(i,2)*4/5 i/L]);
    xlabel('Kolejne kroki')
    ylabel('U')
    hold on
    subplot(212)
    title('Y(k)')
    set(plot(Y(i,:)),'color',[(L-i)/L mod(i,2)*4/5 i/L]);
    xlabel('Kolejne kroki')
    ylabel('Y')
    hold on
    toPlotForLatex(sprintf('z2_u%d',i),1:kk,U(i,:))
    toPlotForLatex(sprintf('z2_yu%d',i),1:kk,Y(i,:))
end

%wykres charakterystyki statycznej Y(U)
figure (2)
plot(dU,Yu,'*-')
title('Charakterystyka statyczna Y(U)')
xlabel('U')
ylabel('Y(U)')
toPlotForLatex('z2_statU',dU,Yu);

%wykres charakterystyki dynamicznej Y(U)
figure(3)
plot(dU(ceil(L/2)+1:L),Yd,'*-')
title('Charakterystyka dynamiczna Y')
xlabel('Wartoœæ skoku z punktu pracy')
ylabel('Iloœæ kroków po których Y(k)-Ypp >= 90%*(Ykoncowe-Ypp)')
axis tight
toPlotForLatex('z2_dynU',dU(ceil(L/2)+1:L),Yd)

%wzmocnienie statyczne Y(U)
Kstat=(Yu(1))/dU(1)