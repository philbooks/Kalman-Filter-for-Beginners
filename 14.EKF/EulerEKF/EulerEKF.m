function [phi theta psi] = EulerEKF(z, rates, dt)
%
%
persistent H Q R
persistent x P
persistent firstRun


if isempty(firstRun)
  H = [ 1 0 0;
        0 1 0 ];
  
  Q = [ 0.0001 0      0;
        0      0.0001 0;
        0      0      0.1 ];
     
  R = [  6  0;
         0  6 ];

  x = [0 0 0]';  
  P = 10*eye(3);
  
  firstRun = 1;  
end


A = Ajacob(x, rates, dt);

xp = fx(x, rates, dt);
Pp = A*P*A' + Q;

K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - H*xp);
P = Pp - K*H*Pp;


phi   = x(1);
theta = x(2);
psi   = x(3);


%------------------------------
function xp = fx(xhat, rates, dt)
%
%
phi   = xhat(1);
theta = xhat(2);

p = rates(1);
q = rates(2);
r = rates(3);

xdot = zeros(3, 1);
xdot(1) = p + q*sin(phi)*tan(theta) + r*cos(phi)*tan(theta);
xdot(2) =     q*cos(phi)            - r*sin(phi);
xdot(3) =     q*sin(phi)*sec(theta) + r*cos(phi)*sec(theta);

xp = xhat + xdot*dt;


%------------------------------
function A = Ajacob(xhat, rates, dt)
%
%
A = zeros(3, 3);


phi   = xhat(1);
theta = xhat(2);

p = rates(1);
q = rates(2);
r = rates(3);

A(1,1) = q*cos(phi)*tan(theta)   - r*sin(phi)*tan(theta);
A(1,2) = q*sin(phi)*sec(theta)^2 + r*cos(phi)*sec(theta)^2;
A(1,3) = 0;

A(2,1) = -q*sin(phi) - r*cos(phi);
A(2,2) = 0;
A(2,3) = 0;

A(3,1) = q*cos(phi)*sec(theta)            - r*sin(phi)*sec(theta);
A(3,2) = q*sin(phi)*sec(theta)*tan(theta) + r*cos(phi)*sec(theta)*tan(theta);
A(3,3) = 0;

A = eye(3) + A*dt;