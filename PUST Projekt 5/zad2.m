clear all
close all
kk=210;
y=zeros(3,kk);
for i=1:4
    u=zeros(4,kk);
    u(i,10:kk)=1;
    for k=11:kk
        [y(1,k),y(2,k),y(3,k)]=symulacja_obiektu3(u(1,k-1),u(1,k-2),u(1,k-3),u(1,k-4),...
        u(2,k-1),u(2,k-2),u(2,k-3),u(2,k-4),...
        u(3,k-1),u(3,k-2),u(3,k-3),u(3,k-4),...
        u(4,k-1),u(4,k-2),u(4,k-3),u(4,k-4),...
        y(1,k-1),y(1,k-2),y(1,k-3),y(1,k-4),...
        y(2,k-1),y(2,k-2),y(2,k-3),y(2,k-4),...
        y(3,k-1),y(3,k-2),y(3,k-3),y(3,k-4));
    end
    toPlotForLatex(sprintf('sU%dY1',i),1:200,y(1,11:kk));
    toPlotForLatex(sprintf('sU%dY2',i),1:200,y(2,11:kk));
    toPlotForLatex(sprintf('sU%dY3',i),1:200,y(3,11:kk));
    subplot(2,2,i)
    hold on
    plot(y(1,11:kk),'r')
    plot(y(2,11:kk),'b')
    plot(y(3,11:kk),'g')
    legend('Y1','Y2','Y3')
    xlabel('k')
    ylabel('Y')
    title(sprintf('U%d',i))
end