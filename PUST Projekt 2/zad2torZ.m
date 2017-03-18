clear all

%inicjalizacja sta³ych i wektorów
kk=200;
startk=15;
dZ=-0.2:0.05:0.2;
L = length(dZ);
U = zeros(L,kk);
Y = zeros(L,kk);
Z = zeros(L,kk);
Yz=zeros(1,L);
Yd=zeros(1,floor(L/2));

%symulacja obiektu dla kolejnych skoków zak³ócenia
for i=1:L
    Z(i,startk:kk)=dZ(i);
    for k=startk:kk
        Y(i,k)=symulacja_obiektu7y(U(i,k-4),U(i,k-5),Z(i,k-1),Z(i,k-2),Y(i,k-1),Y(i,k-2));
    end
    Yz(i)=Y(i,kk);
    if dZ(i)>0
        for k=startk:kk
            if Y(i,k)>0.9*Yz(i)
                Yd(i-ceil(L/2))=k-startk;
                break;
            end
        end
    end
end

%wykres odpowiedzi obiektu na zmiany w torze Z
figure(1)
for i=1:L
    subplot(211)
    title('Z(k)')
    set(stairs(Z(i,:),'--'),'color',[(L-i)/L mod(i,2)*4/5 i/L]);
    xlabel('Kolejne kroki')
    ylabel('Z')
    hold on
    subplot(212)
    title('Y(k)')
    set(plot(Y(i,:)),'color',[(L-i)/L mod(i,2)*4/5 i/L]);
    xlabel('Kolejne kroki')
    ylabel('Y')
    hold on
    toPlotForLatex(sprintf('z2_z%d',i),1:kk,Z(i,:))
    toPlotForLatex(sprintf('z2_yz%d',i),1:kk,Y(i,:))
end

%wykres charakterystyki statycznej Y(Z)
figure (2)
plot(dZ,Yz,'*-')
title('Charakterystyka statyczna Y(Z)')
xlabel('Z')
ylabel('Y(Z)')
toPlotForLatex('z2_statZ',dZ,Yz);


%wykres charakterystyki dynamicznej Y(Z)
figure(3)
plot(dZ(ceil(L/2)+1:L),Yd,'*-')
title('Charakterystyka dynamiczna Y')
xlabel('Wartoœæ skoku z punktu pracy')
ylabel('Iloœæ kroków po których Y(k)>= 90%*Ykoncowe')
axis tight
toPlotForLatex('z2_dynZ',dZ(ceil(L/2)+1:L),Yd)

%wzmocnienie statyczne Y(Z)
Kstat=(Yz(1))/dZ(1)