xm    = 5;
Px    = 9;
kappa = 2;

[Xi W]      = SigmaPoints(xm, Px, kappa);
[xAvg xCov] = UT(Xi, W)