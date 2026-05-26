clear all

rng(1);

Nsamples = 24;

Xsaved   = zeros(Nsamples, 2);
Xqrsaved = zeros(Nsamples, 2);
Zsaved   = zeros(Nsamples, 2);

for k = 1:Nsamples
    [xm, ym]   = GetBallPos(k);
    [xh, yh]   = TrackKalman([xm ym]');
    [xqr, yqr] = TrackKalmanQR([xm ym]');

    Xsaved(k, :)   = [xh yh];
    Xqrsaved(k, :) = [xqr, yqr];
    Zsaved(k, :)   = [xm ym];
end


figure
hold on
grid
plot(Xsaved(:, 1),   Xsaved(:, 2),   'bo', 'MarkerFaceColor', 'b')
plot(Xqrsaved(:, 1), Xqrsaved(:, 2), 'bs')
set(gca, 'YDir', 'reverse')
legend('Q = 1.0', 'Q = 0.01')
