clear
%% ECG system
ACCtime=0;
E4time=700;
Emerg1=[0,0];
Emerg2=[0,0];
Emerg3=[0,0];
Emerg4=[0,0];
Emerg5=[0,0];
Emerg6=[0,0];
%% ESU system
Bp=-0.3375*5;
Bf=[0.00436 0.00065 0.0119210 0.0127548 0.007765]*10000;
Ba=-1;
Bv=-[-0.149 0.181]/1000;
matrixA=readtable("matrixA.xlsx");
matrixA=table2array(matrixA(:,2:10));
%% ECU system
% to calculate parameters
%fuel rate
xfuel=linspace(-1,1,201);
Wf=max(min((1-xfuel)*44,55),33)/1000;
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


