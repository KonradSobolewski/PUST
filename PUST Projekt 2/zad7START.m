%Nastawy, z którymi zostanie uruchomiony algorytm DMC
DZ=40;
N=8;
Nu=1;
lambda=0.3;

%intensywnoœæ szumów w torze zak³óceñ
Z=0.7;

[s,sz]=zad3(false,false);
zad7(DZ,N,Nu,lambda,s,sz,true,true,Z)