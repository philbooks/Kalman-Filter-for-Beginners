clear all

rng(7);

dt = 0.05;
t  = 0:dt:20;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 3);
Zsaved = zeros(Nsamples, 1);

for k = 1:Nsamples
    r = GetRadar(dt);

    x = RadarPF(r, dt);

    Xsaved(k, :) = x;
    Zsaved(k)    = r;
end


subplot(311)
plot(t, Xsaved(:, 2))
ylabel('Velocity [m/s]')
grid

subplot(312)
plot(t, Xsaved(:, 3))
ylabel('Altitude [m]')
grid
subplot(313)
plot(t, Xsaved(:, 1))
ylabel('Position [m]')
grid

figure
hold on
grid
plot(t, sqrt(Xsaved(:, 1).^2 + Xsaved(:, 3).^2), 'b')
plot(t, Zsaved, 'r:.')
ylabel('Slant range [m]')
legend('PF', 'Radar')