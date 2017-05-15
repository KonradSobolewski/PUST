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
        temp = fscanf(t);
        temp
        eval(temp);
        data(1,iterator) = U1;
        data(2,iterator) = U2;
        data(3,iterator) = Y1;
        data(4,iterator) = Y2;
        fprintf('Fscanf zadzialal');
        iterator=iterator + 1
        plot(1:length(data(1,:)), data(1,:),'b');
        hold on;
        grid on;
        plot(1:length(data(2,:)), data(2,:),'g');
        plot(1:length(data(3,:)), data(3,:),'r');
        plot(1:length(data(4,:)), data(4,:),'k');
        hold off;
        drawnow
        toPlotForLatex('tempU1',1:length(data(1,:)), data(1,:));
        toPlotForLatex('tempU2',1:length(data(2,:)), data(2,:));
        toPlotForLatex('tempY1',1:length(data(3,:)), data(3,:));
        toPlotForLatex('tempY2',1:length(data(4,:)), data(4,:));
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