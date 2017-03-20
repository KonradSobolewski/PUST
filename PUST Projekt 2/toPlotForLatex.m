function [] = toPlotForLatex(name,A,B)
%name - nazwa pliku
%A - pierwszy wektor poziomy (pierwsza kolumna pliku)
%B - druga wektor poziomy (druga kolumna pliku)
name=[name '.txt'];
fileID=fopen(name,'w');
fprintf(fileID,'%1.4f %1.4f\r\n',[A;B]);
fclose(fileID);
end