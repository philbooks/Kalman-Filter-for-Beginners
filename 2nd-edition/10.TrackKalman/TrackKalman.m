function [x_, y_] = TrackKalman(z)
%
%
persistent A H Q R
persistent x P


persistent firstRun
if isempty(firstRun)
    dt = 1;

    A = [ 1 dt 0  0
          0  1 0  0
          0  0 1 dt
          0  0 0  1 ];

    H = [ 1 0 0 0            % Measure x position
          0 0 1 0 ];         % Measure y position

    Q = 1.0 * eye(4);
    R = 10^2 * eye(2);

    x = [z(1) 0 z(2) 0]';    % init position from first measurement
    P = 1.0 * eye(4);

    firstRun = 1;
end


xp = A*x;
zp = H*xp;

Pp = A*P*A' + Q;
K  = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - zp);
P = Pp - K*H*Pp;


x_ = x(1);                   % Return estimated position (through line 42) 
y_ = x(3);