clear all

load ars.mat

Nsamples = length(t);
EulerSaved = zeros(Nsamples, 3);

for k = 1:Nsamples
    gyro = [wx(k) wy(k) wz(k)]';     % [rad/sec]
    acc  = [ax(k) ay(k) az(k)]';     % [g]

    [phi, theta, psi] = CompFilter(gyro, acc, dt(k));

    EulerSaved(k, :) = [ phi theta psi ] * 180/pi;
end


subplot(211)
hold on
plot(t, phi_true, 'b:')
plot(t, EulerSaved(:, 1))
ylabel('Roll angle [deg]')
legend('Ground truth', 'Comp. Filter')
grid

subplot(212)
hold on
plot(t, theta_true, 'b:')
plot(t, EulerSaved(:, 2))
xlabel('Time [sec]')
ylabel('Pitch angle [deg]')
legend('Ground truth', 'Comp. Filter')
grid

figure
hold on
plot(t, EulerSaved(:, 3))
ylabel('Yaw angle [deg]')
grid