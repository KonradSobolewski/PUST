Kp=0.830924723684346;
T1=82.107104357462080;
T2=1.007198612141651e-07;
alfa1 = exp(-1/T1);
alfa2 = exp(-1/T2);
a1 = -alfa1 - alfa2;
a2 = alfa1*alfa2;
b1 = (Kp/(T1-T2))*(T1*(1-alfa1)-T2*(1-alfa2));
b2 = (Kp/(T1-T2))*(alfa1*T2*(1-alfa2)-(alfa2*T1*(1-alfa1)));

 Y = b1*36 + b2*36 - a1*36.5 - a2*36.5