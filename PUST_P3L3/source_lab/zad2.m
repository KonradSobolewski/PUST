function[] = zad2 ()
%Badanie punktu pracy

 addpath ('F:\SerialCommunication'); % add a path
 initSerialControl COM3 % initialise com port

Upp=[36 41];
Ypp=[39 41.31];
kk=310;
U=diag(Upp)*ones(2,kk);
Y = diag(Ypp)*ones(2,kk);
%dU=[41;41];  % 39 , 41.31
%dU=[46 41];  % 39.25 , 41.56
 dU=[51 41];  % 39.62 . 42.06
% dU=[36 46];
% dU=[36 51];
% dU=[36 56];
kstart=10;
U(:,kstart:kk)=diag(dU)*ones(2,kk-kstart+1);
figure
 for k=1:kk
 %% obtaining measurements
 Y(:,k) = readMeasurements ([1,3]) ; % read measurements

 %% processing of the measurements
 disp(k);
 disp ( Y(:,k) ); % process measurements

 %% sending new values of control signals
 sendControls([1,2,5,6],[50,50,U(1,k),U(2,k)]);

 %% synchronising with the control process
 subplot(211)
 plot(Y(1,:))
 subplot(212)
 plot(Y(2,:))
 drawnow
 toPlotForLatex(sprintf('z2Y1%1.4f%1.4f',dU(1),dU(2)),1:kk,Y(1,:));
 toPlotForLatex(sprintf('z2Y2%1.4f%1.4f',dU(1),dU(2)),1:kk,Y(2,:));
 toPlotForLatex(sprintf('z2U1%1.4f%1.4f',dU(1),dU(2)),1:kk,U(1,:));
 toPlotForLatex(sprintf('z2U2%1.4f%1.4f',dU(1),dU(2)),1:kk,U(2,:));
 waitForNewIteration (); % wait for new iteration
 end
end