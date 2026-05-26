function [x_, y_] = TrackKalmanQR(z)
%
%
persistent A H Q R
persistent x P


persistent firstRun
if isempty(firstRun)
  dt = 1;
  
  A = [ 1  dt  0   0
        0  1   0   0
        0  0   1   dt
        0  0   0   1 ];
  
  H = [ 1  0  0  0
        0  0  1  0 ];
 
  Q = 0.01*eye(4);                 % 0.1 --> 0.01
  R = [ 50  0
         0 50 ];

  x = [0, 0, 0, 0]';
  P = 100*eye(4);
  
  firstRun = 1;
end


xp = A*x;
zp = H*xp;

Pp = A*P*A' + Q;
K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - zp);
P = Pp - K*H*Pp;


x_ = x(1);                         % Return estimated position (through line 42)
y_ = x(3);