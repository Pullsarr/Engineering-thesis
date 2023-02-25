clear 
clc
% position to angle
xlin=linspace(0,0.35,101);
alfaPRO=linspace(92.5,23,101);
alfa=linspace(-20,20,101);
y=(0.00143*alfa*10^6+8.7025e+04)/101325.353;
Yangle=linspace(0,2,101);
wyk= figure;
wyk.Position = [10 10 1200 400];
wyk=tiledlayout(1,2,"TileSpacing","compact");
simIn = Simulink.SimulationInput('tester');
simIn = setModelParameter(simIn,'StartTime','0','StopTime','30','FixedStep','0.001');
runIDs = Simulink.sdi.getAllRunIDs;
runID = runIDs(end);
dataset = Simulink.sdi.exportRun(runID);
out = sim(simIn);
simout = out.simout;
data=struct2cell(simout);
x1=data{1}.time;
y1=data{1}.Data*100;

x2=data{2}.time;
y2=data{2}.Data*100;

x3(:)=data{3}.time(:);
y3(:)=data{3}.Data(1,1,:)*100;

x4(:)=data{4}.time(:);
y4(:)=data{4}.Data;

x5(:)=data{5}.time(:);
y5(:)=data{5}.Data(1,1,:);

x6(:)=data{6}.time(:);
y6(:)=data{6}.Data(1,1,:);

title(wyk,"test 3.12");
%% plot 1
nexttile(wyk)
ax=plot(x1,y1,x2,y2,x3,y3);
hold on
grid minor
ax(1).LineStyle="--";
ax(3).LineWidth=3;
title("VG kontroler")
ylabel("T_1 , \alpha_{VG} [%]")
xlabel("czas [s]");
text=["T_1 zadane","T_1 uśrednione", "\alpha_{VG}"];
legend(text,"Location","north","NumColumns",3);
%% plot 1
nexttile(wyk)
ay=plot(x4,y4,x5,y5,x6,y6);
ay(2).LineWidth=3;
hold on
grid minor
title("kąt nastawienia zmiennej geometrii")
ylabel("\alpha_{VG} [\circ]")
xlabel("czas [s]");
text=["\alpha_{VG} zadane","\alpha_{VG} prawdziwe", "\alpha_{VG} sensor"];
legend(text,"Location","north","NumColumns",3);
saveas(wyk,'test312.png');