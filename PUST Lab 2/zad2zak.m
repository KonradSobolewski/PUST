addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM14 % initialise com port

Upp=123;
Ypp=123;
kk=310;
startk=10;
U(1:kk)=Upp;
Y(1:kk)=Ypp;
Z(1:startk)=0;
Z(startk:kk)=10;

for i=1:kk
    
    Y(k)= readMeasurements(1);
    
    sendControlsToG1AndDisturbance(U(k),Z(k));
     
    waitForNewIteration (); % wait for new iteration
    plot(Y)
    drawnow
    
    toPlotForLatex('skokZ_10',1:kk,Y);
end
