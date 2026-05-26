clear all

load ars.mat

Nsamples = length(t);
EulerSaved = zeros(Nsamples, 3);

for k = 1:Nsamples
    gyro = [wx(k) wy(k) wz(k)]';       % [rad/sec]
    acc  = [ax(k) ay(k) az(k)]';       % [g]

    quat = QuatEKF(gyro, acc, dt(k));  % Compute quaternion estimate  

    q1 = quat(1);                      % Convert to Euler angles (through line 21)  
    q2 = quat(2);
    q3 = quat(3);
    q4 = quat(4);
    phi   = atan2(2*(q2*q3 + q1*q4), 1-2*(q1*q1 + q2*q2));
    theta = asin(2*(q2*q4 - q1*q3));
    psi   = atan2(2*(q1*q2 + q3*q4), 1-2*(q2*q2 + q3*q3));
    EulerSaved(k, :) = [ phi theta psi ] * 180/pi;
end


subplot(211)
hold on
plot(t, phi_true, 'b:')
plot(t, EulerSaved(:, 1))
ylabel('Roll angle [deg]')
legend('Ground truth', 'QuatEKF')
grid

subplot(212)
hold on
plot(t, theta_true, 'b:')
plot(t, EulerSaved(:, 2))
xlabel('Time [sec]')
ylabel('Pitch angle [deg]')
legend('Ground truth', 'QuatEKF')
grid

figure
hold on
plot(t, EulerSaved(:, 3))
ylabel('Yaw angle [deg]')
grid