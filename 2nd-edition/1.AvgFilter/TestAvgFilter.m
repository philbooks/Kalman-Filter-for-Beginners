clear all

rng(7);

dt = 0.2;
t  = 0:dt:10;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 1);
Zsaved = zeros(Nsamples, 1);

for k = 1:Nsamples
    z = GetVolt();           % Read voltage measurement
    x = AvgFilter(z);        % Call averaging filter

    Xsaved(k) = x;
    Zsaved(k) = z;
end


figure
hold on
grid
plot(t, Xsaved, 'o-')
plot(t, Zsaved, 'r:*')
legend('Average Filter', 'Measurements')
axis([0 10 5 25])