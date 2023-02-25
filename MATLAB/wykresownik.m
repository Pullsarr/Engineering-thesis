clc;
clear;
runIDs = Simulink.sdi.getAllRunIDs;
runID = runIDs(end);
dataset = Simulink.sdi.exportRun(runID);
time=dataset{1}.Values.Time;
y(:)=dataset{1}.Values.Data(:,:,:)*100; % razy 100 bo procent
y2(:)=dataset{2}.Values.Data(:,:,:)*100; % razy 100 bo procent
f= figure;
f.Position = [10 10 550 400];

wyk=tiledlayout(3,3)
wyk=plot(time,y);
hold on
wyk=plot(time,y2);
title('moduł zmiennej geometrii')
xlabel('czas [s]')
grid minor
ylabel('Ng, P_{3t} [%]')
saveas(wyk,'test33.png')
dataset.getElementNames
