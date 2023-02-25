clc;
clear;
Np=linspace(0.5,2,101);
Q=1./Np;
wyk= figure;
wyk.Position = [10 10 800 1600];
wyk=tiledlayout(4,2,"TileSpacing","compact");
title(wyk,'test 3.1');

xlabel(wyk,'czas [s]')
text=["Ng","Np","No","Q_{p}","P_{0t}","T_{1t}","P_{3t}","T_{4.5t}"];
for d=1:length(text)
text2(d)=append(text(d)," sensor");
text3(d)=append(text(d)," [%]");
numer(d)=string(d);
end

for i=1:5000
    simin.time(i)=i/1000;
    simin.signals.values(i,1:9)=1;
    simin.signals.dimensions=9;
end
simIn = Simulink.SimulationInput('tester');
simIn = setModelParameter(simIn,'StartTime','0','StopTime','5','FixedStep','0.001');
runIDs = Simulink.sdi.getAllRunIDs;
runID = runIDs(end);
dataset = Simulink.sdi.exportRun(runID);

out = sim(simIn);
simout = out.simout;
data=struct2cell(simout);

for k=1:length(data)
    nexttile(wyk)
    data{k}.data=struct2cell(data{k});
    for l=1:length(data{k}.data)
        plot(data{k}.data{l}.time,data{k}.data{l}.Data*100)
        grid on
        hold on
        names{k}(l)=append(text2(k)," ",numer(l));
    end
    title(text2(k));
    ylabel(text3(k));
    legend(names{k},NumColumns=2,FontSize=8,Location="southeast")
end



saveas(wyk,'test31.png')
dataset.getElementNames
