function r = GetRadar(dt)
%
%
persistent pos

if isempty(pos)
    pos = 0;
end


alt = 1000 + 10*randn;
vel = 100  + 5*randn;
pos = pos + vel*dt;

v = 0 + pos*0.05*randn;

r = sqrt(pos^2 + alt^2) + v;