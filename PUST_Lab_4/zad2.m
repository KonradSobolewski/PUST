
function[Y,U] = zad2()
 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM14 % initialise com port

Upp=36;
%Ypp=36.5;
dU=0;
kk=310;
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
 sendControls ([ 1, 2, 3, 4, 5, 6],[ 50, 0, 0, 0, U(k), 0]) ;

 %% synchronising with the control process
 plot(Y)
 drawnow
 toPlotForLatex(sprintf('lab2U_%d',dU),1:kk,U')
 toPlotForLatex(sprintf('lab2Y_%d',dU),1:kk,Y')
 waitForNewIteration (); % wait for new iteration
 end
end