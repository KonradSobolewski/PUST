function [] = toPlotForLatex(name,A,B)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
name=[name '.txt'];
fileID=fopen(name,'w');
fprintf(fileID,'%1.4f %1.4f\r\n',[A;B]);
fclose(fileID);
end