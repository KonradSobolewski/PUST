clear all;
% x0 = [0.1, 5, 0.4, 0.1, 5, 0.4,10,0.3];
% lb = [0, 0, 0,0,0,0,0,-0.16];
% [nastawy,min_error] = fmincon(@(x)(p5PID([x(1) x(4)],[x(2) x(5)],[x(3) x(6)],2,x(7),x(8),false)),x0,[],[],[],[],lb)
% 
% E = p5PID([nastawy(1) nastawy(4)],[nastawy(2) nastawy(5)],[nastawy(3) nastawy(6)],2,nastawy(7),nastawy(8),false)

% x0 = [0.1, 5, 0.4, 0.1, 5, 0.4,0.1, 5, 0.4,10,0,1.4];
% lb = [0, 0, 0,0,0,0,0,0,0,0,0,0];
% [nastawy,min_error] = fmincon(@(x)(p5PID([x(1) x(4) x(7)],[x(2) x(5) x(8)],[x(3) x(6) x(9)],3,x(10),[x(11) x(12)],false)),x0,[],[],[],[],lb)
% 
% E = p5PID([nastawy(1) nastawy(4) nastawy(7)],[nastawy(2) nastawy(5) nastawy(8)],[nastawy(3) nastawy(6) nastawy(9)],3,nastawy(10),[nastawy(11) nastawy(12)],false)

% x0=[100 100 10];
% lb=[1 1 0];
% ub=[100 100 Inf];
% [nastawy, min_error]=fmincon(@(x)(p3DMC(x(1),x(2),x(3),false)),x0,[],[],[],[],lb,ub)
% E=p3DMC(nastawy(1),nastawy(2),nastawy(3),false)

% x0=[100 100 10 10 10 0.5];
% lb=[1 1 0 0 0 0];
% ub=[100 100 Inf Inf Inf Inf];
% [nastawy, min_error]=fmincon(@(x)(p6DMC(x(1),x(2),x(3),2,[x(4) x(5)],x(6),false)),x0,[],[],[],[],lb,ub)
% E=p6DMC(nastawy(1),nastawy(2),nastawy(3),2,[nastawy(4) nastawy(5)],nastawy(6),false)

x0=[100 100 10 10 10 10 10 10];
lb=[1 1 0 0 0 0 0 0];
ub=[100 100 Inf Inf Inf Inf Inf Inf];
[nastawy, min_error]=fmincon(@(x)(p6DMC(x(1),x(2),[x(3) x(4) x(5)],3,[x(6) x(7) x(8)],[-0.05 1.4],false)),x0,[],[],[],[],lb,ub)
E=p6DMC(nastawy(1),nastawy(2),[nastawy(3) nastawy(4) nastawy(5)],3,[nastawy(6) nastawy(7) nastawy(8)],[-0.05 1.4],false)