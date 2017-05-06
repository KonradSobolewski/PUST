function s=odpSkok(U1,U2,itsY,latex)
    if itsY==false
        Uskok=zeros(1,210);
        Yskok=zeros(1,210);
        dU=-1:0.0001:1;
        for z=1:length(dU)
            Uskok(10:210)=dU(z);
            for x=7:210
                Yskok(x)=symulacja_obiektu3y(Uskok(x-5),Uskok(x-6),Yskok(x-1),Yskok(x-2));
            end
            if abs(Yskok(210)-U1)<0.001
                tU1=dU(z);
            end
            if abs(Yskok(210)-U2)<0.001
                tU2=dU(z);
            end
        end
        U1=tU1
        U2=tU2
    end
    Uskok=zeros(1,410);
    Yskok=zeros(1,410);
    Uskok(10:210)=U1;
    Uskok(210:410)=U2;
    for z=7:410
        Yskok(z)=symulacja_obiektu3y(Uskok(z-5),Uskok(z-6),Yskok(z-1),Yskok(z-2));
    end
    s=(Yskok(211:310)-Yskok(210))./(U2-U1);
    if latex==true
        toPlotForLatex(sprintf('skok_%3.3f_%3.3f',U1,U2),1:100,s)
    end
end