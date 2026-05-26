function z = GetPos()
%
%
persistent pos
persistent vel

persistent firstRun
if isempty(firstRun)
    pos = 0;
    vel = 80;

    firstRun = 1;
end

dt  = 0.1;
pos = pos + vel*dt;

z = pos + 10*randn;
