load('aprskoky1.txt');
load('aprskoky2.txt');
D=100;
N=100;
Nu=100;
lambda=1;
Ypp=[38;40];
Upp=[36;41];
s11=aprskoky1(:,2);
s12=aprskoky2(:,2);
s21=aprskoky2(:,2);
s22=aprskoky1(:,2);
ny=2;
nu=2;
M=cell(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)={[s11(i-j+1) s12(i-j+1); s21(i-j+1) s22(i-j+1)]};
      else
          M(i,j)={zeros(nu,ny)};
      end;
   end;
end
MP=cell(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)={[s11(i+j)-s11(j) s12(i+j)-s12(j); s21(i+j)-s21(j) s22(i+j)-s22(j)]};
      else
         MP(i,j)={[s11(D)-s11(j) s12(D)-s12(j); s21(D)-s21(j) s22(D)-s22(j)]};
      end;      
   end;
end;
K=(cell2mat(M)'*cell2mat(M)+diag(ones(1,Nu*nu)*lambda))^(-1)*cell2mat(M)';
ku=K(1:nu,:)*cell2mat(MP);
ke1=sum(K(1,1:2:(N*ny)));
ke2=sum(K(1,2:2:(N*ny)));
ke3=sum(K(2,1:2:(N*ny)));
ke4=sum(K(2,2:2:(N*ny)));
fileID=fopen('ku.txt','w');
for i=0:1
    for j=0:197
        fprintf(fileID,'ku[%d].wiersz_ku[%d]:=%1.4f;\n',i,j,ku(i+1,j+1));
    end
end
fclose(fileID);