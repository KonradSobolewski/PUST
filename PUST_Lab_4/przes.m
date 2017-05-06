load('wykresy/lab2Y_5.txt');
load('wykresy/lab2Y_10.txt');
load('wykresy/lab2Y_15.txt');
load('wykresy/lab2Y_20.txt');
load('wykresy/lab2Y_25.txt');
ticks = lab2Y_5(:,1);
lab2Y_5 = lab2Y_5(:,2);
lab2Y_10 = lab2Y_10(:,2)-0.5;
lab2Y_15 = lab2Y_15(:,2)-0.75;
lab2Y_20 = lab2Y_20(:,2)-0.9;
lab2Y_25 = lab2Y_25(:,2)-0.9;

figure();
hold on;
plot(ticks,lab2Y_5)
plot(ticks,lab2Y_10)
plot(ticks,lab2Y_15)
plot(ticks,lab2Y_20)
plot(ticks,lab2Y_25)


toPlotForLatex(sprintf('lab2Y_przes_%d',5),1:310,lab2Y_5')
toPlotForLatex(sprintf('lab2Y_przes_%d',10),1:310,lab2Y_10')
toPlotForLatex(sprintf('lab2Y_przes_%d',15),1:310,lab2Y_15')
toPlotForLatex(sprintf('lab2Y_przes_%d',20),1:310,lab2Y_20')
toPlotForLatex(sprintf('lab2Y_przes_%d',25),1:310,lab2Y_25')
stat = [lab2Y_5(310) lab2Y_10(310) lab2Y_15(310) lab2Y_20(310) lab2Y_25(310)]
toPlotForLatex('lab2Y_stat',5:5:25,stat)
figure()
plot(stat)