addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM13 % initialise com port

Upp=36;
Ypp=37.75;
kk=310;
startk=10;
U(1:kk)=Upp;
Y(1:kk)=Ypp;
Z(1:startk)=0;
Z(startk:kk)=30;

for k=1:kk
    
    Y(k)= readMeasurements(1);
    
    sendControlsToG1AndDisturbance(U(k),Z(k));
     
    waitForNewIteration (); % wait for new iteration
    plot(Y)
    drawnow
    
    toPlotForLatex('skokZ_30',1:kk,Y);
end
