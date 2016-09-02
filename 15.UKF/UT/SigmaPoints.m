function [Xi W] = SigmaPoints(xm, P, kappa)
%
%
n  = numel(xm);
Xi = zeros(n, 2*n+1);              % sigma points = col of Xi
W  = zeros(n, 1);

Xi(:, 1) = xm;
W(1)     = kappa / (n + kappa);

U = chol((n+kappa)*P);             % U'*U = (n+kappa)*P

for k=1:n
  Xi(:, k+1) = xm + U(k, :)';      % row of U
  W(k+1)     = 1 / (2*(n+kappa));
end

for k=1:n
  Xi(:, n+k+1) = xm - U(k, :)';
  W(n+k+1)      = 1 / (2*(n+kappa));
end