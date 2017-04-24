
function[Y,U] = zad1()
 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM5 % initialise com port

Upp=36;
Ypp=35.06;
dU=0;
kk=300;
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
 sendNonlinearControls(U(k)) ;

 %% synchronising with the control process
 plot(Y)
 drawnow
 toPlotForLatex('lab11U',1:kk,U')
 toPlotForLatex('lab11Y',1:kk,Y')
 waitForNewIteration (); % wait for new iteration
 end
end