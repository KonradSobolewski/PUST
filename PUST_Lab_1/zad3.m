%clear;

load('zad3skok5.mat')
x0 = [11, 10, 1, 8];%do ustalenia!
lb = [0 0 0 0];%ditto
ub = [1000 1000 10 30];%ditto


%k_skok_sterowania =30; %tutaj moment skoku sterowania
%u=zeros(len(s)); %inicjacja sterowania
%u(k_skok_sterowania:len(s))=1;

%[factors,E]= ga(@(x)(aproksym_error(x(1),x(2),x(3),x(4),false,skok)),4,[],[],[],[],lb,ub,[],[4]);
[factors,E]= fmincon(@(x)(aproksym_error(x(1),x(2),x(3),x(4),false,skok)),x0,[],[],[],[],lb,ub);

aproksym_error(factors(1),factors(2),factors(3),factors(4),true,skok)