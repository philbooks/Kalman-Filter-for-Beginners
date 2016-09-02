function q_hat = PILawTheta(delTheta)
%
%
persistent prevQ prevdelTheta


if isempty(prevQ)
  prevQ        = 0;
  prevdelTheta = 0;
end

  
q_hat = prevQ + 0.1415*delTheta - 0.1414*prevdelTheta;

prevQ        = q_hat;
prevdelTheta = delTheta;