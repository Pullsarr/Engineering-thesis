clc;
clear;
alfa=linspace(92.5,23,101);
xlin=linspace(0,0.35,101);
y=(0.00143*alfa*10^6+8.7025e+04)/101325.353;
W=readmatrix("test33smigloo.xlsx");
Np=linspace(0.5,2,101);
Q=1./Np;
Bp=-0.3375;
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
a_prop=50;
wyk= figure;
wyk.Position = [10 10 1200 600];
wyk=tiledlayout(1,2,"TileSpacing","compact");
simin.signals.dimensions=1;
for i=1:5000
    simin.time(i)=i/1000;
    simin.signals.values(i,1)=1;

end
for i=5001:10000
    simin.time(i)=i/1000;
    simin.signals.values(i,1)=1+(i-5000)/10000;
end
for i=10001:15000
        simin.time(i)=i/1000;
    simin.signals.values(i,1)=1.5;
end
for i=15001:20000
        simin.time(i)=i/1000;
    simin.signals.values(i,1)=1.5-(i-15000)/10000;
end
for i=20001:25000
        simin.time(i)=i/1000;
    simin.signals.values(i,1)=1;
end
simIn = Simulink.SimulationInput('tester');
simIn = setModelParameter(simIn,'StartTime','0','StopTime','25','FixedStep','0.001');
runIDs = Simulink.sdi.getAllRunIDs;
runID = runIDs(end);
dataset = Simulink.sdi.exportRun(runID);

out = sim(simIn);
simout = out.simout;
data=struct2cell(simout);
title(wyk,"test 3.6")
x1=data{1}.time;
y1(:)=(1-data{1}.Data(1,1,:))*100;
x2=data{2}.time;
y2=data{2}.Data*100;
x3=data{3}.time;
y3=data{3}.Data*100;
x4=data{4}.time;
y4=data{4}.Data*100;
x5=data{5}.time;
y5=data{5}.Data*100;
%% plot 1
nexttile(wyk)
ax=plot(x5,y5,x4,y4,x2,y2,x3,y3,"--");
ax(3).LineWidth=2;
yline(135,"LineWidth",2)
hold on
grid minor
ax(1).LineWidth=2;
ax(4).LineWidth=3;
title("ABV kontroler")
ylabel("P_{3t} zadane , P_{3t}/P_{2t} uśrednione , ABV kontroler, ABV limiter [%]")
xlabel("czas [s]");
text=["P_{3t} zadane ","P_{3t}/P_{2t} uśrednione","ABV kontroler", "ABV limiter","P_{3t}/P_{2t} safe= 135%"];
legend(text,"Location","southeast");
nexttile(wyk)
ax=plot(x1,y1);
grid minor
xlabel("czas [s]");
title("Spadek ciśnienia po otwarciu upustu powietrza");
ylabel("P_{3t} [%]");
saveas(wyk,'test36.png')
dataset.getElementNames

