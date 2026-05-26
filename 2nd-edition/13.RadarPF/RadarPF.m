function x_ = RadarPF(z, dt)
%
%
persistent x
persistent pt wt
persistent Npt

persistent firstRun
if isempty(firstRun)
    x = [0 90 1100]';

    Npt = 1000;

    pt(1, :) = x(1) + 10*randn(1, Npt);
    pt(2, :) = x(2) + 0.1*x(2)*randn(1, Npt);
    pt(3, :) = x(3) + 0.1*x(3)*randn(1, Npt);

    wt = ones(1, Npt) * 1/Npt;

    firstRun = 1;
end


for k = 1:Npt
    pt(:, k) = f(pt(:, k), dt) + randn(3, 1);
end

sigma = 10;
for k = 1:Npt
    err   = z - h(pt(:, k));
    wt(k) = wt(k) * exp(-0.5 * (err/sigma)^2);
end
wt = wt / sum(wt);

x = pt * wt';

x_ = x;

edges  = cumsum(wt);                % Systematic resampling (through line 50)       
points = rand/Npt + (0:Npt-1)/Npt;
bin         = 1;
pt_resample = zeros(3, Npt);
for i = 1:Npt
    while edges(bin) < points(i) 
        bin = bin + 1;
    end
    pt_resample(:, i) = pt(:, bin);
end
pt = pt_resample;
wt = ones(1, Npt) / Npt;


%------------------------------
function xp = f(x, dt)
%
%
A = eye(3) + dt*[ 0 1 0;
                  0 0 0;
                  0 0 0 ];

xp = A*x;


%------------------------------
function zp = h(x)
%
%
zp = sqrt(x(1)^2 + x(3)^2);