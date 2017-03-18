%Nastawy, z którymi zostanie uruchomiony algorytm DMC
N=8;
Nu=1;
lambda=0.1;

%Uzyskanie odpowiedzi skokowych
[s,sz]=zad3(false,false);

%Symulacja sterowania z regulatorem DMC o danych nastawach
E=zad4(N,Nu,lambda,s,true,true)