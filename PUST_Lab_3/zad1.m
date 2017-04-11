function[] = zad1 ()
%Badanie punktu pracy

 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM5 % initialise com port

Upp=[36;41];
kk=500;
Y = zeros(2,kk);
figure
 for k=1:kk
 %% obtaining measurements
 Y(:,k) = readMeasurements ([1,3]) ; % read measurements

 %% processing of the measurements
 disp(k);
 disp ( Y(:,k) ); % process measurements

 %% sending new values of control signals
 sendControls([1,2,5,6],[50,50,Upp(1),Upp(2)]);

 %% synchronising with the control process
 subplot(211)
 plot(Y(1,:))
 subplot(212)
 plot(Y(2,:))
 drawnow
 toPlotForLatex('z1Y1',1:kk,Y(1,:));
 toPlotForLatex('z1Y2',1:kk,Y(2,:));
 waitForNewIteration (); % wait for new iteration
 end
end