function x_ = MEKF(gyro, acc, dt)
%
%
persistent x

persistent firstRun
if isempty(firstRun)
    x = [0 0 0 1]';

    firstRun = 1;
end


wm = gyro;
am = acc / norm(acc);

xb = f(x, wm, dt);
zb = h(xb);

[A, H] = GetJacobian(xb, wm, dt);    % System matrix of the linearized model 
e = KalmanFilter(A, H, am, zb);      % Estimate the error state 

qe = [0.5*e; 1];                     % Convert error state to quaternion
x = QuatMult(xb, qe);                % Final corrected state estimate  
x = x / norm(x);

x_ = x;
end


function x_ = f(x, wm, dt)
%
Omega = [    0     wm(3) -wm(2)  wm(1);
         -wm(3)     0     wm(1)  wm(2);
          wm(2) -wm(1)     0     wm(3);
         -wm(1) -wm(2) -wm(3)     0   ];
x = expm(1/2*Omega*dt) * x;

x_ = x / norm(x);
end


function z_ = h(x)
%
q1 = x(1);
q2 = x(2);
q3 = x(3);
q4 = x(4);

C_BI = [ 1-2*(q2^2 + q3^2)   2*(q1*q2 + q3*q4)   2*(q1*q3 - q2*q4);
         2*(q1*q2 - q3*q4)   1-2*(q1^2 + q3^2)   2*(q2*q3 + q1*q4);
         2*(q1*q3 + q2*q4)   2*(q2*q3 - q1*q4)   1-2*(q1^2 + q2^2) ];

z_ = C_BI*[0 0 1]';                  % [0 0 1]' = g_I
end


function [A, H] = GetJacobian(x, wm, dt) % Build A, H matrices (through line 71) 
%
A = expm(-skew(wm)*dt);

q1 = x(1);
q2 = x(2);
q3 = x(3);
q4 = x(4);
C_BI = [ 1-2*(q2^2 + q3^2)   2*(q1*q2 + q3*q4)   2*(q1*q3 - q2*q4);
         2*(q1*q2 - q3*q4)   1-2*(q1^2 + q3^2)   2*(q2*q3 + q1*q4);
         2*(q1*q3 + q2*q4)   2*(q2*q3 - q1*q4)   1-2*(q1^2 + q2^2) ];
g_B = C_BI*[0 0 1]';
H = skew(g_B);
end


function e_ = KalmanFilter(A, H, z, zb)
%
persistent P
persistent Q R

persistent firstRun
if isempty(firstRun)
    P = eye(3);

    Q = 1e-2*eye(3);
    R = 1*eye(3);

    firstRun = 1;
end


P = A*P*A' + Q;
K = P*H'*inv(H*P*H' + R);

e_ = K*(z - zb);

P = P - K*H*P;
end


function q_ = QuatMult(p, q)
%
L = [  p(4) -p(3)  p(2)  p(1);
       p(3)  p(4) -p(1)  p(2);
      -p(2)  p(1)  p(4)  p(3);
      -p(1) -p(2) -p(3)  p(4) ];

q_ = L * q;
end


function M = skew(v)
%
M = [  0    -v(3)  v(2);
       v(3)  0    -v(1);
      -v(2)  v(1)  0   ];
end