function [phi theta] = EulerAccel(ax, ay)
%
%
g = 9.8;

theta = asin(  ax / g );
phi   = asin( -ay / (g*cos(theta)) );

 