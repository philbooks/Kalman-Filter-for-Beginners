function h = GetSonar()
%
%
persistent sonarAlt       % SonartAlt.mat
persistent k firstRun


if isempty(firstRun)
  load SonarAlt
  k = 1;
  
  firstRun = 1;
end

h = sonarAlt(k);
  
k = k + 1;
