kk=200;
y = zeros(1,kk);
for k=10:kk
   y(k)=symulacja_obiektu3y(0,0,y(k-1),y(k-2));
end
plot(y)
toPlotForLatex('z1Y',1:kk,y);
