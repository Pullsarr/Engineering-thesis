clear; clc;
x=linspace(1,101,101);
a1=figure;
a1.Position= [10 10 800 400];
a1=tiledlayout(1,2,"TileSpacing","loose");
title(a1,'Różnica w odczytach czujnika momentu')
leglabel=["wypustka wału obciążonego","wypustka wału nieobciążonego"];
for i=1:101
    if mod(i,20)==15
        y1(i)=1;
        y2(i)=0;
        y3(i)=0;
    elseif mod(i,20)==5
        y1(i)=0;
        y2(i)=1;
        y3(i)=0;
    elseif mod(i,20)==10
        y1(i)=0;
        y2(i)=0;
        y3(i)=1;
    else
        y1(i)=0;
        y2(i)=0;
        y3(i)=0;
    end
end
nexttile(a1)
plot(x,y1,x,y2);
hold on
grid minor
axis([0 100 0 1])
xlabel('czas [ms]')
ylabel('sygnał komparatora [-]')
legend(leglabel,Location="southeast");
nexttile(a1)
plot(x,y1,x,y3);
hold on
grid minor
axis([0 100 0 1])
xlabel('czas [ms]')
ylabel('sygnał komparatora [-]')
legend(leglabel,Location="southeast");
saveas(a1,'momenty.png')
