function [phi theta psi] = EulerKalman(A, z)
%
%
persistent H Q R
persistent x P
persistent firstRun


if isempty(firstRun)
  H = eye(4);
  
  Q = 0.0001*eye(4);
  R = 10*eye(4);

  x = [1 0 0 0]';  
  P = 1*eye(4);
  
  firstRun = 1;  
end

 
xp = A*x;
Pp = A*P*A' + Q;

K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - H*xp);     % x = [ q1 q2 q3 q4 ]
P = Pp - K*H*Pp;


phi   =  atan2( 2*(x(3)*x(4) + x(1)*x(2)), 1 - 2*(x(2)^2 + x(3)^2) );
theta = -asin(  2*(x(2)*x(4) - x(1)*x(3)) );
psi   =  atan2( 2*(x(2)*x(3) + x(1)*x(4)), 1 - 2*(x(3)^2 + x(4)^2) );