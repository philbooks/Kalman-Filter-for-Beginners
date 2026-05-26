function [phi theta psi] = EulerUKF(z, rates, dt)
%
%
persistent Q R
persistent x P
persistent n m
persistent firstRun


if isempty(firstRun)
  Q = [ 0.0001  0       0;
        0       0.0001  0;
        0       0       1 ];
     
  R = [ 6   0;
        0  12 ];

  x = [0 0 0]';  
  P = 1*eye(3);
  
  n = 3;
  m = 2;
  
  firstRun = 1;  
end


[Xi W] = SigmaPoints(x, P, 0);

fXi = zeros(n, 2*n+1);
for k = 1:2*n+1
  fXi(:, k) = fx(Xi(:,k), rates, dt);
end

[xp Pp] = UT(fXi, W, Q);

hXi = zeros(m, 2*n+1);
for k = 1:2*n+1
  hXi(:, k) = hx(fXi(:,k));
end

[zp Pz] = UT(hXi, W, R);

Pxz = zeros(n, m);
for k = 1:2*n+1
  Pxz = Pxz + W(k)*(fXi(:,k) - xp)*(hXi(:,k) - zp)';
end

K = Pxz*inv(Pz);

x = xp + K*(z - zp);
P = Pp - K*Pz*K';


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
function yp = hx(x)
%
%
yp(1) = x(1);
yp(2) = x(2);