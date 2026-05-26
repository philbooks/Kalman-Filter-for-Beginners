function x_ = RadarEKF(z, dt)
%
%
persistent A Q R
persistent x P

persistent firstRun
if isempty(firstRun)
    A = eye(3) + dt*[ 0 1 0;
                      0 0 0;
                      0 0 0 ];
    Q = [ 0 0     0;
          0 0.001 0;
          0 0     0.001 ];

    R = 10;

    x = [0 90 1100]';        % Arbitrary initial estimate
    P = 10*eye(3);

    firstRun = 1;
end


xp = A*x;
zp = h(xp);

Pp = A*P*A' + Q;

H = Hjacob(xp);              % Compute linearized matrix

K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - zp);
P = Pp - K*H*Pp;


x_ = x;


%------------------------------
function zp = h(x)
%
%
zp = sqrt(x(1)^2 + x(3)^2);


%------------------------------
function H = Hjacob(x)
%
%
H = zeros(1, 3);

H(1) = x(1) / sqrt(x(1)^2 + x(3)^2);
H(2) = 0;
H(3) = x(3) / sqrt(x(1)^2 + x(3)^2);