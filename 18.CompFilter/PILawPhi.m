function p_hat = PILawPhi(delPhi)
%
%
persistent prevP prevdelPhi


if isempty(prevP)
  prevP      = 0;
  prevdelPhi = 0;
end

  
p_hat = prevP + 0.1415*delPhi - 0.1414*prevdelPhi;

prevP      = p_hat;
prevdelPhi = delPhi;