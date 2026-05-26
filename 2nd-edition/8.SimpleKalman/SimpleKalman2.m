function [x_, P_, K] = SimpleKalman2(z)
%
%
persistent A H Q R 
persistent x P

persistent firstRun
if isempty(firstRun)
    A = 1;                   % Set up system matrices (through line 12)
    H = 1;
    Q = 0;
    R = 4;                   % modeled value (true noise has variance 9)

    x = 14;                  % Set initial values (through line 15)
    P = 6;

    firstRun = 1;
end


xp = A*x;                    % Step I
zp = H*xp;

Pp = A*P*A' + Q;             % Step II
K  = Pp*H'*inv(H*Pp*H' + R); % Step III

x = xp + K*(z - zp);         % Step IV
P = Pp - K*H*Pp;             % Step V


x_ = x;
P_ = P;