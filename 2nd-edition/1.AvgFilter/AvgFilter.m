function avg = AvgFilter(x)
%
%
persistent prevAvg
persistent k

persistent firstRun         % Initialize function (through line 13)
if isempty(firstRun)
    prevAvg = 0;
    k = 1;

    firstRun = 1;
end


alpha = 1 / k;
avg = (1 - alpha)*prevAvg + alpha*x;

prevAvg = avg;
k = k + 1;