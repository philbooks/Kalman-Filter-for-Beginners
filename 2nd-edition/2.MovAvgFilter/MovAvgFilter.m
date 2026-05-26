function avg = MovAvgFilter(x)
%
%
persistent n
persistent xbuf

persistent firstRun
if isempty(firstRun)
    n    = 10;               % Set window size  
    xbuf = x*ones(n, 1);     % Initialize internal buffer

    firstRun = 1;
end


for m = 1:n-1
    xbuf(m) = xbuf(m+1);     % Drop the oldest sample 
end
xbuf(n) = x;                 % Append the new sample 

avg = sum(xbuf) / n;