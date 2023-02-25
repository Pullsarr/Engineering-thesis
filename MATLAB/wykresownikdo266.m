clc;
clear;
Bp=0.3375;
Bf=[0.00436 0.00065 1.19210 1.27548 0.007765];
Ba=-1;
Bv=[-0.149 0.181];
matrixA=readtable("matrixA.xlsx");
matrixA=table2array(matrixA(:,2:10));
wyk= figure;
wyk.Position = [10 10 800 800];
wyk=tiledlayout(2,2,"TileSpacing","compact");
title(wyk,'test 2.6');

ylabel(wyk,'Parametry silnika [%]')
xlabel(wyk,'czas [s]')
text=["Moduł śmigła","Moduł paliwowy","Moduł upustu powietrza","Moduł zmiennej geometrii"];
text2=["Ng","Np","P_{0t}","T_{1t}","P_{2t}","P_{3t}","P_{4t}","P_{4.5t}","T_{4.5t}"];


for k=1:4
    for i=1:10000
        simin.time(i)=i/1000;
        simin.signals.values(i,1:4)=0;
        simin.signals.values(i,k)=0.1*sin(i/1000);
        simin.signals.dimensions=4;
    end
    simIn = Simulink.SimulationInput('tester');
    simIn = setModelParameter(simIn,'StartTime','0','StopTime','10','FixedStep','0.001');
    runIDs = Simulink.sdi.getAllRunIDs;
    runID = runIDs(end);
    dataset = Simulink.sdi.exportRun(runID);
    
    out = sim(simIn);
    simout = out.simout;
    nexttile(wyk)

    for l=1:9
        y{k}.y{l}(:)=out.simout.Data(l,:,:)*100; % razy 100 bo procent
        x{k}.time{l}(:)=out.simout.Time(:,1);
        plot(x{k}.time{l}(:),y{k}.y{l}(:));
        title(text(k));
        grid on
        hold on
    end
end
leg=legend(text2,Orientation="horizontal");
leg.Layout.Tile='north';
title(leg,'Parametry silnika [%]');
leg.FontSize=12;

saveas(wyk,'test266.png')
dataset.getElementNames
