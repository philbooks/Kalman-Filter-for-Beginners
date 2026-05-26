function [phi_, theta_, psi_] = EulerGyro(wx, wy, wz, phi, theta, psi, dt)
%
%
phi_dot   = wx + wy*sin(phi)*tan(theta) + wz*cos(phi)*tan(theta);
theta_dot =      wy*cos(phi)            - wz*sin(phi);
psi_dot   =      wy*sin(phi)/cos(theta) + wz*cos(phi)/cos(theta);

phi_   = phi   + dt*phi_dot;
theta_ = theta + dt*theta_dot;
psi_   = psi   + dt*psi_dot;

end