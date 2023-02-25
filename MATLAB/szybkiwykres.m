savus=["test14.png","test15.png", "test16.png"];
titles=["Zmiana ciśnienia przez przeciągnięcie samolotu przez pilota",...
    "Nagły spadek temperatury i ciśnienia atmosferycznego","Zagrożenie wlecenia ptaka do silnika"];
yylab=["P_{2t} [%]","T_{1t} , P_{0t} [%]","P_{3t} [%]"];
ACCtime=0;
for k=3
    xxxx(k,:)=dowyk{k}.Values.Time;
    yyyy(k,:)=dowyk{k}.Values.Data*100;
    wyk{k}=figure;
    wyk{k}.Position= [ 10 10 800 400];
    plot(xxxx(k,:),yyyy(k,:));
    hold on
    grid minor
    xlabel("czas [s]");
    ylabel(yylab(k));
    if k==1
        axis([0 60 -8 0])
    elseif k==2
        axis([0 300 -5 0])
    else
        axis([0 10 -30 0]);
    end
    title(titles(k));
    saveas(wyk{k},savus(k));
end

