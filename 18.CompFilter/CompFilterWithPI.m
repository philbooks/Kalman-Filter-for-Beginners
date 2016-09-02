function [phi theta psi] = CompFilterWithPI(p, q, r, ax, ay, dt)
%
%
persistent p_hat q_hat
persistent prevPhi prevTheta prevPsi

if isempty(p_hat)
  p_hat = 0;
  q_hat = 0;
  
  prevPhi = 0;
  prevTheta = 0;
  prevPsi = 0;
end


[phi_a theta_a] = EulerAccel(ax, ay); 

[dotPhi dotTheta dotPsi] = BodyToInertial(p, q, r, prevPhi, prevTheta);

phi   = prevPhi   + dt*(dotPhi   - p_hat);
theta = prevTheta + dt*(dotTheta - q_hat);
psi   = prevPsi   + dt*dotPsi;

p_hat = PILawPhi(phi - phi_a);
q_hat = PILawTheta(theta - theta_a);

prevPhi   = phi;
prevTheta = theta;
prevPsi   = psi;


function [dotPhi dotTheta dotPsi] = BodyToInertial(p, q, r, phi, theta)
% Bod rate --> Euler angular rate
%
sinPhi   = sin(phi);    cosPhi   = cos(phi);
cosTheta = cos(theta);  tanTheta = tan(theta);

dotPhi   = p + q*sinPhi*tanTheta + r*cosPhi*tanTheta;
dotTheta =     q*cosPhi          - r*sinPhi;
dotPsi   =     q*sinPhi/cosTheta + r*cosPhi/cosTheta;