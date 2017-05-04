clear all
close all
Upp=0;
Ypp=0;
Umin=-1;
Umax=1;
kk=250;
startk=15;
dU=-1:0.1:1;
L=length(dU);
U=Upp*ones(L,kk);
Y=Ypp*ones(L,kk);
Yu=zeros(1,L);
Yd=zeros(1,floor(L/2));

for i=1:L
    U(i,startk:kk)=Upp+dU(i);
    for k=startk:kk
        Y(i,k)=symulacja_obiektu3y(U(i,k-5),U(i,k-6),Y(i,k-1),Y(i,k-2));
    end
    Yu(i)=Y(i,kk);
    if dU(i)>0 || true
        for k=startk:kk
            if abs(Y(i,k)-Ypp)>abs(0.9*(Yu(i)-Ypp))
                Yd(i)=k-startk;%-ceil(L/2)
                break;
            end
        end
    end
end
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
    toPlotForLatex(sprintf('z2_y%d',i),1:kk,Y(i,:))
end
figure (2)
plot(dU+Upp,Yu,'*-')
title('Charakterystyka statyczna Y(U)')
xlabel('U')
ylabel('Y(U)')
toPlotForLatex('z2_stat',dU+Upp,Yu);
figure(3)
plot(dU(1:L),Yd,'*-')%ceil(L/2)+
title('Charakterystyka dynamiczna Y')
xlabel('Wartoœæ skoku z punktu pracy')
ylabel('Iloœæ kroków po których Y(k)-Ypp >= 90%*(Ykoncowe-Ypp)')
axis tight
toPlotForLatex('z2_dyn',dU(ceil(L/2)+1:L),Yd)
Kstat=(Yu(1)-Ypp)/dU(1)