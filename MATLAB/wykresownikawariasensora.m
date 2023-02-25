
runIDs = Simulink.sdi.getAllRunIDs;
runID = runIDs(end);
dataset = Simulink.sdi.exportRun(runID);
time=dataset{1}.Values.Time;
y(:)=dataset{1}.Values.Data(:,:,:)*100; % razy 100 bo procent
y2(:)=dataset{2}.Values.Data(:,:,:)*100; % razy 100 bo procent
f= figure;

f.Position = [10 10 550 400];
wyk=plot(time,y);
axis([0 1 80 120]);
hold on
plot(time,y2);
hold on
scatter(time,y4);
title('awaria sensora ciśnienia P3')
xlabel('czas [s]')
grid minor
ylabel('P3t [%]')
legend('normalne zakłócenia', 'awaria sensora', 'różnica >2%');
saveas(wyk,'emer1.png')
dataset.getElementNames