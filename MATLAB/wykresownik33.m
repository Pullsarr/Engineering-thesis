clc;
clear;
alfa=linspace(92.5,23,101);
xlin=linspace(0,0.35,101);
y=(0.00143*alfa*10^6+8.7025e+04)/101325.353;

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
wyk.Position = [10 10 1200 800];
wyk=tiledlayout(2,2,"TileSpacing","compact");
for i=1:15000
    simin.time(i)=i/1000;
    simin.signals.values(i,1)=max(1-i/20000,0.5);
    simin.signals.dimensions=1;
end
for i=15001:45000
    simin.time(i)=i/1000;
    simin.signals.values(i,1)=min(simin.signals.values(15000,1)+(i-15000)/20000,1.5);
    simin.signals.dimensions=1;
end

simIn = Simulink.SimulationInput('tester');
simIn = setModelParameter(simIn,'StartTime','0','StopTime','45','FixedStep','0.001');
runIDs = Simulink.sdi.getAllRunIDs;
runID = runIDs(end);
dataset = Simulink.sdi.exportRun(runID);

out = sim(simIn);
simout = out.simout;
data=struct2cell(simout);
title(wyk,"test 3.3")
%% plot 1
nexttile(wyk)
ax=plot(data{1}.time,data{1}.Data*100,data{2}.time,data{2}.Data*100,data{4}.time,data{4}.Data*100);
hold on
grid minor
ax(1).LineWidth=3;
title("PCV limiter")
ylabel("N_o zadane, N_o uśrednione , PCV limiter [%]")
xlabel("czas [s]");
text=["N_o zadane","N_o uśrednione", "PCV limiter"];
legend(text,"Location","southeast");
%% plot 2
nexttile(wyk)
ay=plot(data{1}.time,data{1}.Data*100,data{3}.time,data{3}.Data*100);
yline(116,"LineWidth",2)
ay(2).LineWidth=4;
title("FBV limiter")
xlabel("czas [s]");
grid minor
text2=["N_o zadane","FBV kontroler ","N_o safe= 116 %"];
ylabel("N_o zadane , FBV kontroler [%]")
legend(text2,Location="southeast");
%% plot 3
nexttile(wyk)
w(:)=data{7}.Data(1,1,:)*100;
x=transpose(data{7}.time);
ax=plot(data{1}.time,data{1}.Data*100,x,w);
hold on
yline(116,"LineWidth",2)
title(" Odpowiedź układu śmigła")
xlabel("czas [s]");
ylabel("N_o zadane , \alpha_{prop} [%]")
legend(["N_o zadane","\alpha_{prop}","N_o safe 116%"],"Location","northwest");
grid minor
%% plot 4
nexttile(wyk)
ww(:)=data{6}.Data(1,1,:);
xx=transpose(data{6}.time);
ax=plot(xx,ww);
hold on
xline(28.5,"LineWidth",2);
title("kąt nastawienia łopat śmigła")
xlabel("czas [s]");
ylabel("\alpha_{prop} [\circ]")
legend(["\alpha_{prop}","FBV kontroler=1"],"Location","northwest");
grid minor
saveas(wyk,'test33.png')
dataset.getElementNames

