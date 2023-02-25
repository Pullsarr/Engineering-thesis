A=readtable('formatlab.xlsx');
B=sortrows(A,"Nazwa");
save("frommatlab.csv","B");