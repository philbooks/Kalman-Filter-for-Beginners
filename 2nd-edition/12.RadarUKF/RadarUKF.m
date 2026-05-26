function x_ = RadarUKF(z, dt)
%
%
persistent Q R
persistent x P
persistent n m

persistent firstRun
if isempty(firstRun)
    Q = [ 0 0     0;
          0 0.001 0;
          0 0     0.001 ];

    R = 10;

    x = [0 90 1100]';
    P = 10*eye(3);

    n = 3;
    m = 1;

    firstRun = 1;
end


[Xi, W] = SigmaPoints(x, P, 0);     % Call sigma-point function 

fXi = zeros(n, 2*n+1);              % Predict state and covariance (through line 33) 
for k = 1:2*n+1
    fXi(:, k) = f(Xi(:,k), dt);
end
[xp, Pp] = UT(fXi, W);
Pp = Pp + Q;

hXi = zeros(m, 2*n+1);              % Predict measurement and covariance (through line 40)   
for k = 1:2*n+1
    hXi(:, k) = h(fXi(:,k));
end
[zp, Pz] = UT(hXi, W);
Pz = Pz + R;

Pxz = zeros(n, m);                  % Cross-covariance of x and z (through line 45) 
for k = 1:2*n+1
    Pxz = Pxz + W(k)*(fXi(:, k) - xp)*(hXi(:, k) - zp)';
end

K = Pxz*inv(Pz);

x = xp + K*(z - zp);
P = Pp - K*Pz*K';


x_ = x;


%------------------------------
function xp = f(x, dt)
%
%
A = eye(3) + dt*[ 0 1 0;
                  0 0 0;
                  0 0 0 ];

xp = A*x;


%------------------------------
function zp = h(x)
%
%
zp = sqrt(x(1)^2 + x(3)^2);