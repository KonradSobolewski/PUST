function[Y,U] = zad1 ()
%Badanie punktu pracy

 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM13 % initialise com port

Upp=36;
Ypp=36.75;
dU=0;
kk=500;
U = Upp*ones(kk,1);
U(10:kk)=U(10:kk)+dU;
Y = zeros(kk,1);
 for k=1:kk
 %% obtaining measurements
 Y(k) = readMeasurements (1) ; % read measurements

 %% processing of the measurements
 disp(k);
 disp ( Y(k) ); % process measurements

 %% sending new values of control signals
 sendControlsToG1AndDisturbance(U(k),0);

 %% synchronising with the control process
 waitForNewIteration (); % wait for new iteration
 plot(Y)
 drawnow
 end
%toPlotForLatex('skokU_15',1:kk,U')
%toPlotForLatex('skokY_15',1:kk,Y')
end