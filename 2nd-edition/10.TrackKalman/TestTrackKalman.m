clear all

rng(1);

Nsamples = 24;

Xsaved = zeros(Nsamples, 2);
Zsaved = zeros(Nsamples, 2);

for k = 1:Nsamples
    [xm, ym] = GetBallPos(k);
    [xh, yh] = TrackKalman([xm ym]');

    hold on                                        % Start animation 
    plot(xm, ym, 'r*')                             % Measured ball position 
    plot(xh, yh, 'bo', 'MarkerFaceColor', 'b');    % Estimated ball position 
    pause(1)

    Xsaved(k, :) = [xh yh];
    Zsaved(k, :) = [xm ym];
end


figure
hold on
grid
plot(Xsaved(:, 1), Xsaved(:, 2), 'b-o')
plot(Zsaved(:, 1), Zsaved(:, 2), 'r:*')
set(gca, 'YDir', 'reverse')
legend('Kalman Filter', 'Measurements')
