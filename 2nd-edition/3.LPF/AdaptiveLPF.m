function [xlpf, alpha] = AdaptiveLPF(x)
%
%
persistent prevX

persistent firstRun
if isempty(firstRun)
    prevX = x;

    firstRun = 1;
end


alpha = CalcAlpha(x);                    % Adapts to |xdot|
xlpf = (1 - alpha)*prevX + alpha*x;

prevX = xlpf;