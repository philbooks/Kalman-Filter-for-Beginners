clear all

rng(7);

dt = 0.1;
t  = 0:dt:10;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 2);
Zsaved = zeros(Nsamples, 1);

for k = 1:Nsamples
    z = GetPos();            % Read measured position
    x = DvKalman(z);         % x(1) = pos, x(2) = vel

    Xsaved(k, :) = x;
    Zsaved(k)    = z;
end


figure
hold on
grid
plot(t, Xsaved(:, 1))
plot(t, Zsaved(:), 'r:o')
legend('Kalman Filter', 'Measurements')

figure
hold on
grid
plot(t, Xsaved(:, 2))
