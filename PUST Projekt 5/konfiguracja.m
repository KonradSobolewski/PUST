kk=510;
y=zeros(3,kk);
KKK=zeros(4,3);
for i=1:4
    u=zeros(4,kk);
    u(i,10:kk)=1;
    for k=10:kk
        [y(1,k),y(2,k),y(3,k)]=symulacja_obiektu3(u(1,k-1),u(1,k-2),u(1,k-3),u(1,k-4),...
        u(2,k-1),u(2,k-2),u(2,k-3),u(2,k-4),...
        u(3,k-1),u(3,k-2),u(3,k-3),u(3,k-4),...
        u(4,k-1),u(4,k-2),u(4,k-3),u(4,k-4),...
        y(1,k-1),y(1,k-2),y(1,k-3),y(1,k-4),...
        y(2,k-1),y(2,k-2),y(2,k-3),y(2,k-4),...
        y(3,k-1),y(3,k-2),y(3,k-3),y(3,k-4));
    end
    KKK(i,1)=y(1,kk);
    KKK(i,2)=y(2,kk);
    KKK(i,3)=y(3,kk);
end
KK1=KKK(2:4,:);
KK2=KKK([1 3 4],:);
KK3=KKK([1 2 4],:);
KK4=KKK(1:3,:);
cond(KK1)
cond(KK2)
cond(KK3)
cond(KK4)
disp(KK1.*(KK1^(-1))')
disp(KK2.*(KK2^(-1))')
disp(KK3.*(KK3^(-1))')
disp(KK4.*(KK4^(-1))')