clear all

Nsamples = 500;

Xsaved   = zeros(Nsamples, 1);
Zsaved   = zeros(Nsamples, 1);
Alpsaved = zeros(Nsamples, 1);


for k = 1:Nsamples
    z          = GetSonar();            % Read sonar measurement 
    [x, alpha] = AdaptiveLPF(z);        % Call adaptive LPF

    Xsaved(k)   = x;
    Zsaved(k)   = z;
    Alpsaved(k) = alpha;
end


dt = 0.02;
t  = 0:dt:Nsamples*dt-dt;

figure
hold on
grid
plot(t, Xsaved, '-')
plot(t, Zsaved, 'r:.')
legend('Adaptive LPF', 'Measurements')

figure
hold on
grid
plot(t, Alpsaved, 'b:.')
