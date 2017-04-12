%skrypt s³u¿¹cy do utworzenia charakterystyk Y1(U1,U2) i Y1(U1,U2) na
%podstawie odpowiedzi skokowych Y1(U1) i Y2(U2)
%rysuje tak¿e odpowiedzi skokowe skroœne i nieskroœne w wersji otrzymanej w
%laboratorium i przesuniête do wspólnego punktu pracy
clc
clear
close all;

draw = 1
latex  = 1

startk = 1;
endk = 300;

Y1pp = 39;
Y2pp = 41.3;
%³adowanie zebranych odp skokowych
min1 = load('Wykresy/z2Y141.000041.0000.txt');
medium1 = load('Wykresy/z2Y146.000041.0000.txt');
max1 = load('Wykresy/z2Y151.000041.0000.txt');

min2 = load('Wykresy/z2Y241.000041.0000.txt');
medium2 = load('Wykresy/z2Y246.000041.0000.txt');
max2 = load('Wykresy/z2Y251.000041.0000.txt');

diff(1,1)=0 ;
%obliczenie ró¿nic
diff(1,2)= min1(endk,2) - Y1pp; %min1(startk,2) ;
diff(1,3)= medium1(endk,2)-39.25; %medium1(startk,2) ;
diff(1,4)= max1(endk,2) -39.62; %max1(startk,2) ;

diff(2,1)=0 ;
diff(2,2) = min2(endk,2)-Y2pp; %min2(s2_startk,2) ;
diff(2,3) = medium2(endk,2) -41.56; %medium2(s2_startk,2) ;
diff(2,4) = max2(endk,2)- 42.06; %max2(s2_startk,2) ;


[dU1,dU2]=meshgrid(0:5:15);

L = length(dU1);
for i=1:L
    for j=1:L       
        Y1(i,j) = diff(1,j) + diff(2,i);
        Y2(i,j) = diff(1,i) + diff(2,j);
    end
end
%zapis w odpowiednim formacie
if(latex)
    fileID=fopen('z2Y1U1U2.txt','w');
    fprintf(fileID,'%1.4f %1.4f %1.4f\r\n',[reshape(dU1,1,L*L);reshape(dU2,1,L*L);reshape(Y1,1,L*L)]);
    fclose(fileID);
    
    fileID=fopen('z2Y2U1U2.txt','w');
    fprintf(fileID,'%1.4f %1.4f %1.4f\r\n',[reshape(dU1,1,L*L);reshape(dU2,1,L*L);reshape(Y2,1,L*L)]);
    fclose(fileID);
end
%narysowanie wykresów odpowiedzi skokoywch skroœnych i zwyk³ych, tak¿e
%przesuniêtych do wspólnego punktu w celu ³atwiejszej analizy

if(draw)
    figure
    mesh(dU1,dU2,Y1);
    figure
    mesh(dU1,dU2,Y2);
    figure
    hold on
    plot(min1(:,1),min1(:,2))
    plot(medium1(:,1),medium1(:,2))
    plot(max1(:,1),max1(:,2))

    figure
    hold on
    plot(min2(:,1),min2(:,2))
    plot(medium2(:,1),medium2(:,2))
    plot(max2(:,1),max2(:,2))

    min1(:,2) = min1(:,2)+0.25
    max1(:,2) = max1(:,2)-0.37

    min2(:,2) = min2(:,2)+0.25;
    max2(:,2) = max2(:,2)-0.5;
    figure
    hold on
    plot(min1(:,1),min1(:,2))
    plot(medium1(:,1),medium1(:,2))
    plot(max1(:,1),max1(:,2))

    figure
    hold on
    plot(min2(:,1),min2(:,2))
    plot(medium2(:,1),medium2(:,2))
    plot(max2(:,1),max2(:,2))
    
end
if(false)
    toPlotForLatex(sprintf('z2presY141.000041.0000'),min1(:,1)',min1(:,2)')
    toPlotForLatex(sprintf('z2presY146.000041.0000'),medium1(:,1)',medium1(:,2)')
    toPlotForLatex(sprintf('z2presY151.000041.0000'),max1(:,1)',max1(:,2)')
end
if(false)
    toPlotForLatex(sprintf('z2presY241.000041.0000'),min2(:,1)',min2(:,2)')
    toPlotForLatex(sprintf('z2presY246.000041.0000'),medium2(:,1)',medium2(:,2)')
    toPlotForLatex(sprintf('z2presY251.000041.0000'),max2(:,1)',max2(:,2)')
end