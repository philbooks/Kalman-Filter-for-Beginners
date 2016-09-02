function xhpf = HPF(u)
%
%
persistent prevX
persistent prevU
persistent dt tau
persistent firstRun


if isempty(firstRun)
  prevX = 0;
  prevU = 0;
  dt    = 0.01;
  tau   = 0.0233;
  
  firstRun = 1;  
end


alpha = tau / (tau + dt);
xhpf = alpha*prevX + alpha*(u - prevU);

prevX = xhpf;
prevU = u;