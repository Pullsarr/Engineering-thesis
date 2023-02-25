clc;
clear;
alfa=linspace(-20,20,101);
y=(0.00143*alfa*10^6+8.7025e+04)/101325.353;
xlin=linspace(0,0.1,101);
Np=linspace(0.5,2,101);
Q=1./Np;
Bp=0.3375;
Bf=[0.00436 0.00065 1.19210 1.27548 0.007765];
Ba=-1;
Bv=[-0.149 0.181];
matrixA=readtable("matrixA.xlsx");
matrixA=table2array(matrixA(:,2:10));
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
wyk.Position = [10 10 800 400];
wyk=tiledlayout(1,2,"TileSpacing","compact");
title(wyk,'test 2.2');



simIn = Simulink.SimulationInput('tester22');
simIn = setModelParameter(simIn,'StartTime','0','StopTime','30','FixedStep','0.001');
runIDs = Simulink.sdi.getAllRunIDs;
runID = runIDs(end);
dataset = Simulink.sdi.exportRun(runID);

out = sim(simIn);
simout = out.simout;
nexttile(wyk)
plot(simout.Time,simout.Data(:,1)*100);
hold on
plot(simout.Time,simout.Data(:,2)*100);
hold on
plot(simout.Time,simout.Data(:,5)*100);
grid minor
hold off
xlabel("czas [s]");
ylabel("Ng , Np , T_{4.5t} [%]")
title("Moduł paliwowy (Ng , Np , T_{4.5t})")
legend(["Ng","Np","T_{4.5t}"])
nexttile(wyk)
plot(simout.Time,simout.Data(:,3)*100);
hold on
plot(simout.Time,simout.Data(:,4)*100);
grid minor
hold off
xlabel("czas [s]")
ylabel("P_{4t} , P_{4.5t} [%]")
title("moduł paliwowy (P_{4t} P_{4.5t})")
legend(["P_{4t}","P_{4.5t}"])
saveas(wyk,'test22.png')
dataset.getElementNames
