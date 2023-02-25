clc;
clear;
runIDs = Simulink.sdi.getAllRunIDs;
runID = runIDs(end);
dataset = Simulink.sdi.exportRun(runID);
time=dataset{1}.Values.Time;
y1(:)=dataset{1}.Values.Data(:,:,:)*100; % razy 100 bo procent
y2(:)=dataset{2}.Values.Data(:,:,:)*100; % razy 100 bo procent
y3(:)=dataset{3}.Values.Data(:,:,:)*100; % razy 100 bo procent
y4(:)=dataset{4}.Values.Data(:,:,:)*100; % razy 100 bo procent
y5(:)=dataset{5}.Values.Data(:,:,:)*100; % razy 100 bo procent
f= figure;
f.Position = [10 10 900 400];

subplot(1,2,1)
wyk=plot(time,y1);
hold on
wyk=plot(time,y2);
hold on
wyk=plot(time,y5);
title('moduł paliwowy (Ng,Np, T_{4.5t})')
xlabel('czas [s]')
grid minor
ylabel('Ng, Np, T_{4.5t} [%]')
subplot(1,2,2)
wyk=plot(time,y3);
hold on
wyk=plot(time,y4);
title('moduł paliwowy (P_{4t}, P_{4.5t})')
xlabel('czas [s]')
grid minor
ylabel('P_{4t}, P_{4.5t} [%]')
saveas(wyk,'test22.png')
dataset.getElementNames
