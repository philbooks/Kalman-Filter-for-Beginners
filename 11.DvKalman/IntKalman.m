function [pos vel] = IntKalman(z)
%
%
persistent A H Q R 
persistent x P
persistent firstRun


if isempty(firstRun)
  firstRun = 1;
  
  dt = 0.1;
  
  A = [ 1 dt;
        0 1  ];
  H = [0 1];
  
  Q = [ 1 0;
        0 3 ];
  R = 10;

  x = [ 0 20 ]';
  P = 5*eye(2);
end

  
xp = A*x;  
Pp = A*P*A' + Q;    

K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - H*xp);
P = Pp - K*H*Pp;   
  
pos = x(1);
vel = x(2);