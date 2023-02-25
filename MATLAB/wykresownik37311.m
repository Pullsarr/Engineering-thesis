clc;
clear;
% dane
IPR=0.99;
Ng_safe=1.25;
Np_safe=1.25;
No_perf=1;
No_safe=1.16;
Q_safe=1.15;
P3tDIVP2t_perf=1.0101;
P3tDIVP2t_safe=1.35;
T45_perf=1;
T45_safe=1.3;
a_prop=50;
Np=linspace(0.5,2,101);
Q=1./Np;
xfuel=linspace(-1,1,201);
Wf=max(min((1-xfuel)*44,55),33)/1000;
optimal_rotation=11.8694;
% program

simin.signals.dimensions=5;
simin.time(1:45)=1:45;
simin.signals.values(1:45,1:5)=1;
limit=[Ng_safe Np_safe Q_safe, P3tDIVP2t_safe, T45_safe]*100;
name=["Ng","Np","Q_{p}"];
testname= ["test 3.7","test 3.8", "test 3.9", "test 3.10" , "test  3.11"];
savename= ["test 37.png","test 38.png", "test 39.png", "test 310.png", "test 311.png"];
name2=append(name," sensor");
for k=1:3
    dozapis=convertStringsToChars(savename(k));
    name3=append(name(k)," zadane");
    name4=append(name(k)," SAFE");
    simin.time(1:45)=1:45;
    simin.signals.values(1:45,1:5)=1;
    simin.signals.values(1:5,k)=1;
    simin.signals.values(6:10,k)=1-(1:5)*0.05;
    simin.signals.values(11:15,k)=0.75;
    simin.signals.values(16:30,k)=0.75+(1:15)*0.05;
    simin.signals.values(31:35,k)=1.5;
    simin.signals.values(36:45,k)=1.5-(1:10)*0.05;
    if k==3
        simin.signals.values(:,k)=1./simin.signals.values(:,k);
    end
    xx=simin.time(:);
    yy=simin.signals.values(:,k);
    simIn = Simulink.SimulationInput('tester');
    simIn = setModelParameter(simIn,'StartTime','0','StopTime','45','FixedStep','0.001');
    runIDs = Simulink.sdi.getAllRunIDs;
    runID = runIDs(end);
    dataset = Simulink.sdi.exportRun(runID);
    out = sim(simIn);
    simout = out.simout;
    data=struct2cell(simout);
    wyk{k}= figure;
    wyk{k}.Position = [10 10 1200 600];
    wyk{k}=tiledlayout(1,2,"TileSpacing","compact");
    title(wyk{k},testname(k));
    ax{k}=nexttile(wyk{k});

    for l=1:3
        x(l,:)=data{l}.Time(:);
        y(l,:)=data{l}.Data(:);
        ax{k}=plot(x(l,:),y(l,:)*100);
        hold on
        grid minor
    end
    ax{k}=plot(xx,yy*100,"LineWidth",2);
    ax{k}=yline(limit(k),"LineWidth",3);
    x(7,:)=data{7}.Time(:);
    y(7,:)=data{7}.Data(:);
    ax{k}=plot(x(7,:),y(7,:)*100,"LineWidth",3);
    xlabel("czas [s]");
    ylabel("Ng , Np , Q_{p} , SOV kontroler [%]")
    title("SOV kontroler"); 
    legendtext=[name2 , name3, name4, "SOV kontroler"];
    if k==3
        legendtext=[name2 , "Np zadane", name4, "SOV kontroler"];
    end
    ax{k}=legend(legendtext,"Location","southeast");
    nexttile(wyk{k})
    x(8,:)=data{8}.Time(:);
    y(8,:)=data{8}.Data(:);
    xdupa=data{9}.Time(:);
    ydupa=data{9}.Data(:);
    plot(x(8,:),y(8,:)*1000,xdupa,ydupa*1000)
    hold on
    xlabel("czas [s]");
    ylabel("W_f  [g/s]");
    title("Ilość paliwa dostarczanego do silnika [g/s]")
    legendarnytext=["W_f zadane przez kontroler", "W_f prawidzwe"];
    legend(legendarnytext,Location="southwest");
    grid minor
    saveas(wyk{k},dozapis);
end
%%
for k=4
        dozapis=convertStringsToChars(savename(k));
    simin.time(1:45)=1:45;
    simin.signals.values(1:45,1:5)=1;
    simin.signals.values(1:5,k)=1;
    simin.signals.values(6:10,k)=1-(1:5)*0.05;
    simin.signals.values(11:15,k)=0.75;
    simin.signals.values(16:30,k)=0.75+(1:15)*0.05;
    simin.signals.values(31:35,k)=1.5;
    simin.signals.values(36:45,k)=1.5-(1:10)*0.05;
    xx=simin.time(:);
    yy=simin.signals.values(:,k);
    simIn = Simulink.SimulationInput('tester');
    simIn = setModelParameter(simIn,'StartTime','0','StopTime','45','FixedStep','0.001');
    runIDs = Simulink.sdi.getAllRunIDs;
    runID = runIDs(end);
    dataset = Simulink.sdi.exportRun(runID);
    out = sim(simIn);
    simout = out.simout;
    data=struct2cell(simout);
    wyk{k}= figure;
    wyk{k}.Position = [10 10 1200 600];
    wyk{k}=tiledlayout(1,2,"TileSpacing","compact");
    title(wyk{k},testname(k));
    ax{k}=nexttile(wyk{k});
    x4(:)=data{4}.Time(:);
    y4(:)=data{4}.Data(:);
    x5(:)=data{5}.Time(:);
    y5(:)=data{5}.Data(:);
    ax{k}=plot(x4,y4*100);
        hold on
    ax{k}=plot(x5,y5*100);

    grid minor
    ax{k}=plot(xx,yy*100,"LineWidth",2);
    x(7,:)=data{7}.Time(:);
    y(7,:)=data{7}.Data(:);
    ax{k}=plot(x(7,:),y(7,:)*100,"LineWidth",3);
    xlabel("czas [s]");
    ylabel("P_{3t}/P_{2t} , T_{4.5t} , SOV kontroler [%]")
    title("SOV kontroler");
    legendtext=["P_{3t}/P_{2t} średnia", "T_{4.5t} średnia","P_{3t}/P_{2t} zadane", "SOV kontroler"];
    ax{k}=legend(legendtext,"Location","southeast");
    nexttile(wyk{k})
    x(8,:)=data{8}.Time(:);
    y(8,:)=data{8}.Data(:);
    xdupa=data{9}.Time(:);
    ydupa=data{9}.Data(:);
    plot(x(8,:),y(8,:)*1000,xdupa,ydupa*1000)
    hold on
    xlabel("czas [s]");
    ylabel("W_f  [g/s]");
    title("Ilość paliwa dostarczanego do silnika [g/s]")
    legendarnytext=["W_f zadane przez kontroler", "W_f prawidzwe"];
    legend(legendarnytext);
    grid minor
    saveas(wyk{k},dozapis);
end
%%
for k=5
    dozapis=convertStringsToChars(savename(k));
    simin.time(1:45)=1:45;
    simin.signals.values(1:45,1:5)=1;
    simin.signals.values(1:5,k-1)=1;
    simin.signals.values(6:10,k-1)=1-(1:5)*0.05;
    simin.signals.values(11:15,k-1)=0.75;
    simin.signals.values(16:30,k-1)=0.75+(1:15)*0.05;
    simin.signals.values(31:35,k-1)=1.5;
    simin.signals.values(36:45,k-1)=1.5-(1:10)*0.05;

    simin.signals.values(1:5,k)=1;
    simin.signals.values(6:10,k)=1-(1:5)*0.05;
    simin.signals.values(11:15,k)=0.75;
    simin.signals.values(16:30,k)=0.75+(1:15)*0.05;
    simin.signals.values(31:35,k)=1.5;
    simin.signals.values(36:45,k)=1.5-(1:10)*0.05;
    xx=simin.time(:);
    yy=simin.signals.values(:,k);
    simIn = Simulink.SimulationInput('tester');
    simIn = setModelParameter(simIn,'StartTime','0','StopTime','45','FixedStep','0.001');
    runIDs = Simulink.sdi.getAllRunIDs;
    runID = runIDs(end);
    dataset = Simulink.sdi.exportRun(runID);
    out = sim(simIn);
    simout = out.simout;
    data=struct2cell(simout);
    wyk{k}= figure;
    wyk{k}.Position = [10 10 1200 600];
    wyk{k}=tiledlayout(2,2,"TileSpacing","compact");
    title(wyk{k},testname(k));
        nexttile(1,1:2)
    xl(:)=data{6}.Time(:);
    for l=1:5
        yl(l,:)=data{6}.Data(l,1,:);
        ay(l)=plot(xl,yl(l,:)*100,"LineWidth",2);
        namer(l)=sprintf("T_{4.5t} sensor %d",l);
        hold on
    end
    namer(6)="T_{4.5t} zadane";
 

    ay(1).Color="black";
    ay(1).LineStyle=":";

    ay(5).Color="black";
    ay(5).LineStyle="--";
    grid minor
    xlabel("czas [s]");
    ylabel("T_{4.5t} [%]")
    plot(xx,yy*100,"LineWidth",2);
       legend(namer,Location="northwest",NumColumns=2);
    title("Voter dla sensora T_{4.5t}");
    ax{k}=nexttile(wyk{k});
    x4(:)=data{4}.Time(:);
    y4(:)=data{4}.Data(:);
    x5(:)=data{5}.Time(:);
    y5(:)=data{5}.Data(:);
    ax{k}=plot(x4,y4*100);
    hold on
    ax{k}=plot(x5,y5*100);

    grid minor
    ax{k}=plot(xx,yy*100,"LineWidth",2);
    yline(limit(k),LineWidth=2);
    x(7,:)=data{7}.Time(:);
    y(7,:)=data{7}.Data(:);
    ax{k}=plot(x(7,:),y(7,:)*100,"LineWidth",3);
    xlabel("czas [s]");
    ylabel("P_{3t}/P_{2t} , T_{4.5t} , SOV kontroler [%]")
    title("SOV kontroler");
    legendtext=["P_{3t}/P_{2t} średnia", "T_{4.5t} średnia","P_{3t}/P_{2t} zadane", "T_{4.5t} safe=1.3","SOV kontroler"];
    ax{k}=legend(legendtext,"Location","southeast");

    nexttile(wyk{k})
    x(8,:)=data{8}.Time(:);
    y(8,:)=data{8}.Data(:);
    xdupa=data{9}.Time(:);
    ydupa=data{9}.Data(:);
    plot(x(8,:),y(8,:)*1000,xdupa,ydupa*1000)
    hold on
    xlabel("czas [s]");
    ylabel("W_f  [g/s]");
    title("Ilość paliwa dostarczanego do silnika [g/s]")
    legendarnytext=["W_f zadane przez kontroler", "W_f prawidzwe"];
    legend(legendarnytext);
    grid minor
    saveas(wyk{k},dozapis);

end

% 1- Ng usrednione
% 2 Np
% 3 Torque
% 4- P3/P2t usrednione
% 5 T45 usrednione
% 6 T45 z sensorow
% 7 SOV kontroler
% 8 zadane Wf [g/s]
% 9 Wf [%]


