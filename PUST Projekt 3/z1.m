kk=200;
y1 = zeros(1,kk);
y2 = zeros(1,kk);
for k=10:kk
    y1(k)=symulacja_obiektu3y1(0,0,0,0,y1(k-1),y1(k-2));
    y2(k)=symulacja_obiektu3y2(0,0,0,0,y2(k-1),y2(k-2));
end
toPlotForLatex('z1Y1',1:kk,y1);
toPlotForLatex('z1Y2',1:kk,y2);