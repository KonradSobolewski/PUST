clear all

%inicjalizacja sta³ych i wektorów
kk=200;
startk=15;
[dU,dZ]=meshgrid(-1:0.1:1);
L = length(dZ);
y=zeros(L,L);
U = zeros(1,kk);
Y = zeros(1,kk);
Z = zeros(1,kk);

%symulacja obiektu dla kolejnych skoków sterowania i zak³ócenia
for i=1:L
    for j=1:L
        Y = zeros(1,kk);
        U(startk:kk)=dU(i,j);
        Z(startk:kk)=dZ(i,j);
        for k=startk:kk
            Y(k)=symulacja_obiektu7y(U(k-4),U(k-5),Z(k-1),Z(k-2),Y(k-1),Y(k-2));
        end
        y(i,j)=Y(kk);
    end
end
%wyœwietlenie i zapis wykresu do txt
mesh(dU,dZ,y);
fileID=fopen('YUZ.txt','w');
fprintf(fileID,'%1.4f %1.4f %1.4f\r\n',[reshape(dU,1,L*L);reshape(dZ,1,L*L);reshape(y,1,L*L)]);
fclose(fileID);