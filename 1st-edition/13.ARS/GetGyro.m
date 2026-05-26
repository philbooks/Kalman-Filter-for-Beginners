function [p q r] = GetGyro()
%
%
persistent wx wy wz
persistent k firstRun


if isempty(firstRun) 
  load ArsGyro
  k = 1;
  
  firstRun = 1;
end

p = wx(k);
q = wy(k);
r = wz(k);
  
k = k + 1;
