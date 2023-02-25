clear
%% ECG system
ACCtime=0;
%% ESU system
Bp=-0.3375*1;
Bf=[0.00436 0.00065 0.0069210 0.0127548 0.007765]*2;
Ba=-1;
Bv=-[-0.149 0.181]/20;
matrixA=readtable("matrixA.xlsx");
matrixA=table2array(matrixA(:,2:10));
%% ECU system
% to calculate parameters
%fuel rate
xfuel=linspace(-1,1,201);
Wf=max(min((1-xfuel)*44,55),33)/100;
optimal_rotation=11.8694;
%VG
alfa=linspace(-20,20,101);
y=(0.00143*alfa*10^6+8.7025e+04)/101325.353;
Yangle=linspace(0,2,101);
% position to angle
xlin=linspace(0,0.35,101);
alfaPRO=linspace(92.5,23,101);
% Q optimilzer
Np=linspace(0.5,2,101);
Q=1./Np;
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
% parametry modulow
a_prop=50;
saver=["walidacja 0.png", "walidacja 1.png","walidacja 2.png","walidacja 3.png",...
    "walidacja 4.png","walidacja 5.png","walidacja 6.png"];
titler=["Symulacja bez zagrożeń","Symulacja 1 zagrożenia","Symulacja 2 zagrożenia","Symulacja 3 zagrożenia"...
    ,"Symulacja 4 zagrożenia","Symulacja 5 zagrożenia","Symulacja 6 zagrożenia"];
czaas=["180" ,"60", "30" ,"5" ,"60" ,"300" ,"15"];
for c=6:6
    for l=1:7
        kk{l}=[0 0];
    end
    kk{c}=[0 1];
    Emerg1=kk{2};
    Emerg2=kk{3};
    Emerg3=kk{4};
    Emerg4=kk{5};
    Emerg5=kk{6};
    Emerg6=kk{7};
    simIn = Simulink.SimulationInput('sims');
    simIn = setModelParameter(simIn,'StartTime','0','StopTime',czaas(c),'FixedStep','0.001');
    runIDs = Simulink.sdi.getAllRunIDs;
    runID = runIDs(end);
    dataset = Simulink.sdi.exportRun(runID);
    out = sim(simIn);
    simout = out.simout;
    data=struct2cell(simout);
    data2=struct2cell(data{2});
    wyk{c}= figure;
    wyk{c}.Position=[0 0 1000 1000];
    wyk{c}=tiledlayout(3,2,"TileSpacing","compact");
    title(wyk{c},titler(c))
    nexttile(1,1:2);
    text=["Ng","Np","P_{0t}","T_{1t}","P_{2t}","P_{3t}","P_{4t}","P_{4.5t}","T_{4.5t}"];
    txtczas='czas [s]';
    time{c}(:)=data{1}.Time(:);
    for i=1:9
        yx{c}(:)=data{1}.Data(i,1,:);
        plot(time{c},yx{c}*100);
        hold on
    end
    grid minor
    ylabel('Parametry silnika [%]');
    xlabel(txtczas);
    title("Parametry silnka")
    leg=legend(text,"Location","southoutside","NumColumns",9);
    title(leg,"Paremtry");
    tytulek=["Skok śmigła","Paliwo","Upust powietrza", "Kąt nastawienia VG"];
    labelek=["\alpha_{prop} [\circ]","W_f [g/s]","dP_{3t} [%]","\alpha_{VG} [\circ]"];
    for k=1:4
        nexttile()
        if k==2
            czaspaliwa{c}(:)=data2{k}.Time(:);
            paliwo{c}(:)=data2{k}.Data(1,1,:)*1000;
            plot(czaspaliwa{c},paliwo{c}(:));
        else
            time{c}(k,:)=data2{k}.Time(:);
            yk{c}(k,:)=data2{k}.Data(1,1,:);
            plot(time{c}(k,:),yk{c}(k,:));
        end
        hold on
        xlabel(txtczas);
        ylabel(labelek(k));
        title(tytulek(k));
        grid minor
    end
    saveas(wyk{c},saver(c));
end
