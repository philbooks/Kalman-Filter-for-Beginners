function z = GetVel()
%
%
persistent vel

persistent firstRun
if isempty(firstRun)
    vel = 80;

    firstRun = 1;
end

z = vel + 10*randn;
