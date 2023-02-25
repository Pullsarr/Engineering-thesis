clc;
clear;
matrixA=readtable("matrixA.xlsx");
matrixA=table2array(matrixA(:,2:10));
wyk= figure;
wyk.Position = [10 10 1200 1200];
wyk=tiledlayout(3,3,"TileSpacing","compact");
title(wyk,'test 2.5');

ylabel(wyk,'Parametry silnika [%]')
xlabel(wyk,'czas [s]')
text=["Ng","Np","P_{0t}","T_{1t}","P_{2t}","P_{3t}","P_{4t}","P_{4.5t}","T_{4.5t}"];




for k=1:9
    for i=1:10000
        sinus.time(i)=i/1000;
        sinus.signals.values(i,1:9)=0;
        sinus.signals.values(i,k)=0.5*sin(i/1000);
        sinus.signals.dimensions=9;
    end
    sim('tester','StartTime','0','StopTime','10','FixedStep','0.001');
    runIDs = Simulink.sdi.getAllRunIDs;
    runID = runIDs(end);
    dataset = Simulink.sdi.exportRun(runID);

    nexttile(wyk)

    for l=1:9
        y{k}.y{l}(:)=dataset{l}.Values.Data(:,:,:)*100; % razy 100 bo procent
        x{k}.time{l}(:)=dataset{l}.Values.Time;
        plot(x{k}.time{l}(:),y{k}.y{l}(:));
        title(text(k));
        grid on
        hold on
    end
end
leg=legend(text,Orientation="horizontal");
leg.Layout.Tile='north';
title(leg,'Parametry silnika [%]');
leg.FontSize=12;

saveas(wyk,'test25.png')
dataset.getElementNames
