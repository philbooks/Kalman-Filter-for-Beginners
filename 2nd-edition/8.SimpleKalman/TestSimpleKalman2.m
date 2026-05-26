clear all

rng(7);

dt = 0.2;
t  = 0:dt:10;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 3);
Zsaved = zeros(Nsamples, 1);

for k = 1:Nsamples
    z = GetVolt();
    [x, P, K] = SimpleKalman2(z);

    Xsaved(k, :) = [x P K];
    Zsaved(k)    = z;
end


figure
hold on
grid
plot(t, Xsaved(:, 1), 'o-')
plot(t, Zsaved, 'r:*')
legend('Kalman Filter', 'Measurements')
axis([0 10 5 25])

figure
plot(t, Xsaved(:, 2), 'o-')
xlabel('Time [sec]')
ylabel('P')

figure
plot(t, Xsaved(:, 3), 'o-')
xlabel('Time [sec]')
ylabel('K')