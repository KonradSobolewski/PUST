clear;
x0 = [T1, T2, K, Td];%do ustalenia!
lb = [0 0 0 0];%ditto
ub = [80 80 80 80];%ditto

s=loadStepResponse();%tutaj inicjacja znormalizowanej odp skokowej

k_skok_sterowania =30; %tutaj moment skoku sterowania
u=zeros(len(s)); %inicjacja sterowania
u(k_skok_sterowania:len(s))=1;

[factors,E]= fmincon(@(x)(aproksym_error(x(1),x(2),x(3),x(4),false)),x0,[],[],[],[],lb,ub);

aproksym_error(factors(1),factors(2),factors(3),factors(4),true)