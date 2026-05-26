clear all

rng(7);

dt = 0.1;
t  = 0:dt:10;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 2);
Zsaved = zeros(Nsamples, 1);

for k = 1:Nsamples
    z = GetVel();            % Read measured velocity
    x = IntKalman(z);        % x(1) = pos, x(2) = vel

    Xsaved(k, :) = x;
    Zsaved(k)    = z;
end


figure
hold on
grid
plot(t, Xsaved(:, 1))

figure
hold on
grid
plot(t, Xsaved(:, 2))
plot(t, Zsaved(:), 'ro')
legend('Kalman Filter', 'Measurements')
