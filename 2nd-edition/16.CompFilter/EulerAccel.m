function [phi_, theta_] = EulerAccel(ax, ay, az)
%
%
phi_   = atan2(ay, az);
theta_ = atan2(-ax, sqrt(ay^2 + az^2));

end