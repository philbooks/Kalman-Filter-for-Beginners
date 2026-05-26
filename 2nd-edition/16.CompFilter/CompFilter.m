function [phi_, theta_, psi_] = CompFilter(gyro, acc, dt)
persistent phi
persistent theta
persistent psi

if isempty(phi)
    phi   = 0.0;
    theta = 0.0;
    psi   = 0.0;
end


[phi_g, theta_g, psi_g] = EulerGyro(gyro(1), gyro(2), gyro(3), phi, theta, psi, dt);
[phi_a, theta_a]        = EulerAccel(acc(1), acc(2), acc(3));

tau   = 0.2;                                   % Designer-chosen value
alpha = tau / (tau + dt);

phi_   = alpha*phi_g   + (1 - alpha)*phi_a;    % Complementary fusion (line 20) 
theta_ = alpha*theta_g + (1 - alpha)*theta_a;
psi_   = psi_g;

phi   = phi_;
theta = theta_;
psi   = psi_;

end