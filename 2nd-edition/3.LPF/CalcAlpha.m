function alpha = CalcAlpha(x)
%
%
persistent dt
persistent dCutoff minCutoff beta

persistent prevX prevXdot

persistent firstRun

if isempty(firstRun)
    dt = 0.02;                   % [sec]

    dCutoff   = 1.0;             % [Hz]
    minCutoff = 1.0;             % [Hz]
    beta      = 0.2;             % speed coefficient

    prevX    = x;
    prevXdot = 0;

    firstRun = 1;
end

a_d  = 1 / (1 + 2*pi*dCutoff*dt);
xdot = (x - prevX) / dt;
xdot = (1 - a_d)*prevXdot + a_d*xdot;

cutoff = minCutoff + beta*abs(xdot);
alpha  = 1 / (1 + 2*pi*cutoff*dt);

prevX    = x;
prevXdot = xdot;