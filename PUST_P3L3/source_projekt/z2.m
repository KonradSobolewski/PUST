clear all
close all

%inicjalizacja sta³ych i wektorów
kk=1000;
startk=10;
[dU1,dU2]=meshgrid(-1:0.1:1);
L = length(dU1);
U1 = zeros(1,kk);
Y1 = zeros(1,kk);
U2 = zeros(1,kk);
Y2 = zeros(1,kk);
Ys1=zeros(L,L);
Ys2=zeros(L,L);
Yd1u1(1:(L-1)/2)=0;
Yd2u1(1:(L-1)/2)=0;
Yd1u2(1:(L-1)/2)=0;
Yd2u2(1:(L-1)/2)=0;

%symulacja obiektu dla kolejnych skoków sterowania i zak³ócenia
for i=1:L
    for j=1:L
        Y = zeros(1,kk);
        U1(startk:kk)=dU1(i,j);
        U2(startk:kk)=dU2(i,j);
        for k=startk:kk
        Y1(k)=symulacja_obiektu3y1(U1(k-5),U1(k-6),U2(k-2),U2(k-3),Y1(k-1),Y1(k-2));
        Y2(k)=symulacja_obiektu3y2(U1(k-6),U1(k-7),U2(k-4),U2(k-5),Y2(k-1),Y2(k-2));
        end
        Ys1(i,j)=Y1(kk);
        Ys2(i,j)=Y2(kk);
        if U1(kk)==1 && U2(kk)==0
            toPlotForLatex('z2Y1U1',1:kk,Y1);
            figure
            plot(Y1)
            toPlotForLatex('z2Y2U1',1:kk,Y2);
            figure
            plot(Y2)
        elseif U2(kk)==1 && U1(kk)==0
            toPlotForLatex('z2Y1U2',1:kk,Y1);
            figure
            plot(Y1)
            toPlotForLatex('z2Y2U2',1:kk,Y2);
            figure
            plot(Y2)
        end
        if U1(kk)>0 && U2(kk)==0
            for k=startk:kk
                if Y1(k)>0.9*Ys1(i,j) && Yd1u1(ceil(U1(kk)*10))==0
                    Yd1u1(ceil(U1(kk)*10))=k;
                end
                if Y2(k)>0.9*Ys2(i,j) && Yd2u1(ceil(U1(kk)*10))==0
                    Yd2u1(ceil(U1(kk)*10))=k;
                end
            end
        elseif U2(kk)>0 && U1(kk)==0
            for k=startk:kk
                if Y1(k)>0.9*Ys1(i,j) && Yd1u2(ceil(U2(kk)*10))==0
                    Yd1u2(ceil(U2(kk)*10))=k;
                end
                if Y2(k)>0.9*Ys2(i,j) && Yd2u2(ceil(U2(kk)*10))==0
                    Yd2u2(ceil(U2(kk)*10))=k;
                end
            end
        end
    end
end
toPlotForLatex('z2dY1U1',0.1:0.1:1,Yd1u1);
toPlotForLatex('z2dY1U2',0.1:0.1:1,Yd1u2);
toPlotForLatex('z2dY2U1',0.1:0.1:1,Yd2u1);
toPlotForLatex('z2dY2U2',0.1:0.1:1,Yd2u2);
figure
plot(Yd1u1)
figure
plot(Yd1u2)
figure
plot(Yd2u1)
figure
plot(Yd2u2)
%wyœwietlenie i zapis wykresu do txt
figure
mesh(dU1,dU2,Ys1);
fileID=fopen('z2Y1U1U2.txt','w');
fprintf(fileID,'%1.4f %1.4f %1.4f\r\n',[reshape(dU1,1,L*L);reshape(dU2,1,L*L);reshape(Ys1,1,L*L)]);
fclose(fileID);
figure
mesh(dU1,dU2,Ys2);
fileID=fopen('z2Y2U1U2.txt','w');
fprintf(fileID,'%1.4f %1.4f %1.4f\r\n',[reshape(dU1,1,L*L);reshape(dU2,1,L*L);reshape(Ys2,1,L*L)]);
fclose(fileID);
