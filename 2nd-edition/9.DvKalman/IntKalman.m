function x_ = IntKalman(z)
%
%
persistent A H Q R
persistent x P

persistent firstRun
if isempty(firstRun)
    dt = 0.1;

    A = [ 1 dt;
          0  1 ];
    H = [ 0 1 ];             % Measure velocity only

    Q = [ 1 0;
          0 3 ];
    R = 10;

    x = [ 0 20 ]';
    P = 5*eye(2);

    firstRun = 1;
end


xp = A*x;
zp = H*xp;

Pp = A*P*A' + Q;
K  = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - zp);
P = Pp - K*H*Pp;


x_ = x;
