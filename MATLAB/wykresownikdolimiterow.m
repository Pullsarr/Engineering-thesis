clc;
clear;
alfa=linspace(-20,20,101);
y=(0.00143*alfa*10^6+8.7025e+04)/101325.353;
xlin=linspace(0,0.1,101);
Np=linspace(0.5,2,101);
Q=1./Np;
% dane
IPR=0.99;
Ng_safe=1.25;
Np_safe=1.25;
No_perf=1;
No_safe=1.16;
Q_safe=1.15;
P3tDIVP2t_perf=1;
P3tDIVP2t_safe=1.35;
T45_perf=1;
T45_safe=1.3;

wyk= figure;
wyk.Position = [10 10 800 800];
wyk=tiledlayout(3,3,"TileSpacing","compact");
title(wyk,'test 3.2');

xlabel(wyk,'czas [s]')
text=["Ng SAFE","Np SAFE","No PERF","No SAFE","Q_{p} SAFE","P_{3t}/P_{2t} PERF","P_{3t}/P_{2t} SAFE","T_{4.5t} SAFE","T_{4.5t} PERF"];
for d=1:length(text)
    text2(d)=append(text(d)," limiter");
    text3=text;
    numer(d)=string(d);
end

for i=1:6000
    simin.time(i)=i/1000;
    simin.signals.values(i,1:9)=1+i/10000;
    simin.signals.dimensions=9;
end
simIn = Simulink.SimulationInput('tester');
simIn = setModelParameter(simIn,'StartTime','0','StopTime','6','FixedStep','0.001');
runIDs = Simulink.sdi.getAllRunIDs;
runID = runIDs(end);
dataset = Simulink.sdi.exportRun(runID);

out = sim(simIn);
simout = out.simout;
data=struct2cell(simout);

for k=1:length(data)
    nexttile(wyk)
    plot(data{k}.time,data{k}.Data)
    grid on
    hold on
    title(text2(k));
    ylabel(text3(k));
end



saveas(wyk,'test32.png')
dataset.getElementNames
