function [xh yh] = TrackKalmanQR(xm, ym)
%
%
persistent A H Q R
persistent x P
persistent firstRun


if isempty(firstRun)
  dt = 1;
  
  A = [ 1  dt  0   0
        0  1   0   0
        0  0   1  dt
        0  0   0   1 ];
  
  H = [ 1  0  0  0
        0  0  1  0 ];
 
  Q = 1.0*eye(4);
  R = 0.01*[ 50  0
         0 50 ];

  x = [0, 0, 0, 0]';
  P = 100*eye(4);
  
  firstRun = 1;
end


xp = A*x;
Pp = A*P*A' + Q;

K = Pp*H'*inv(H*Pp*H' + R);

z = [xm ym]';
x = xp + K*(z - H*xp);
P = Pp - K*H*Pp;


xh = x(1);
yh = x(3);