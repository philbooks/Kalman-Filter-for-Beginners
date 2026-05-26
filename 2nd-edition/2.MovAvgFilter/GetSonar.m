function h = GetSonar()
%
%
persistent sonarAlt        % SonarAlt.mat
persistent k

persistent firstRun
if isempty(firstRun)
    load SonarAlt          % Load measurement data file
    k = 1;

    firstRun = 1;
end

h = sonarAlt(k);           % Return the current sample

k = k + 1;