clear all

NoOfImg = 24;

Xmsaved = zeros(2, NoOfImg);
Xhsaved = zeros(2, NoOfImg);

for k = 1:NoOfImg
  [xm, ym] = GetBallPos(k);
  [xh, yh] = TrackKalman(xm, ym);
      
  hold on
  plot(xm, ym, 'r*')
  plot(xh, yh, 'bs')
  
  pause(1)
  
  Xmsaved(:, k) = [xm ym]';
  Xhsaved(:, k) = [xh yh]';

end


figure
hold on
plot(Xmsaved(1,:), Xmsaved(2,:), '*')
plot(Xhsaved(1,:), Xhsaved(2,:), 's')
