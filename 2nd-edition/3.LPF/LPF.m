function xlpf = LPF(x)
%
%
persistent prevX                % Previous estimate 

persistent firstRun
if isempty(firstRun)
    prevX = x;                  % Initialize previous estimate with first input

    firstRun = 1;
end


alpha = 0.3;                    % Filter algorithm (through line 15)
xlpf = (1 - alpha)*prevX + alpha*x;

prevX = xlpf;