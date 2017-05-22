%%Socket Communication demo script

%t = tcpip('192.168.127.250',4000, 'NetworkRole', 'client');

delete(instrfindall)

pause(2);

%%fclose(t);
%%delete(t);
%%clear t;

close all;
clear all;
 
 
%%t = tcpip('192.168.0.150',4000);
 
t = tcpip('192.168.127.250',4000, 'NetworkRole', 'client');

t.OutputBufferSize = 3000;
t.InputBufferSize = 3000;
 
fopen(t);
fprintf('Fopen zadzialal');
iterator = 1;
data = zeros(2,2);
figure(1);
while(1)   
    if (t.BytesAvailable ~= 0)
        temp = fscanf(t)
        eval(temp);
        data(1,iterator) = U1;
        data(2,iterator) = U2;
        data(3,iterator) = Y1;
        data(4,iterator) = Y2;
        data(5,iterator) = Yzad1;
        data(6,iterator) = Yzad2;
        fprintf('Fscanf zadzialal');
        iterator=iterator + 1
        subplot(2,2,1)
        plot(1:length(data(1,:)), data(1,:),'b');
        grid on;
        subplot(2,2,2)
        plot(1:length(data(2,:)), data(2,:),'g');
        grid on;
        subplot(2,2,3)
        plot(1:length(data(3,:)), data(3,:),'r');
        hold on;
        plot(1:length(data(5,:)), data(5,:),'c');
        grid on;
        hold off;
        subplot(2,2,4)
        plot(1:length(data(4,:)), data(4,:),'k');
        hold on;
        plot(1:length(data(6,:)), data(6,:),'c');
        grid on;
        hold off;
        drawnow
        toPlotForLatex('pidU1',1:length(data(1,:)), data(1,:));
        toPlotForLatex('pidU2',1:length(data(2,:)), data(2,:));
        toPlotForLatex('pidY1',1:length(data(3,:)), data(3,:));
        toPlotForLatex('pidY2',1:length(data(4,:)), data(4,:));
        toPlotForLatex('pidYzad1',1:length(data(5,:)), data(5,:));
        toPlotForLatex('pidYzad2',1:length(data(6,:)), data(6,:));
    end
    pause(0.05);
end

fclose(t);
delete(t);
clear t;


%fprintf(t,'Init comm');
 
 
%fclose(t);



%fopen(t); 

iter = 1;
%data = fread(t,2);
read_done = 0;
while(read_done == 0)
    pause(1);
    fprintf(t,'Waiting for response from server %d\n',iter);
    iter = iter + 1;
%     if (t.BytesAvailable ~= 0)
%         data = fread(t,t.BytesAvailable);
%         read_done = 1;
%     end
    temp = fscanf(t);
    temp

end
data

temp = fscanf(t);

temp

fclose(t);
delete(t);
clear t;