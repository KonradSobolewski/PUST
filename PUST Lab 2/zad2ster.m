addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM14 % initialise com port

Upp=123;
Ypp=123;
kk=310;
startk=10;
U(1:startk)=Upp;
U(startk:kk)=Upp+10;
Y(1:kk)=Ypp;


for i=1:kk
    
    Y(k)= readMeasurements(1);
    
    sendControlsToG1AndDisturbance(U(k),0);
     
    waitForNewIteration (); % wait for new iteration
    plot(Y)
    drawnow
    
    toPlotForLatex('skokU_10',1:kk,Y);
end
