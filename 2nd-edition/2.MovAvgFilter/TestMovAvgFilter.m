clear all

Nsamples = 500;

Xsaved  = zeros(Nsamples, 1);
Zsaved  = zeros(Nsamples, 1);


for k = 1:Nsamples
    z = GetSonar();            % Read sonar measurement 
    x = MovAvgFilter(z);       % Call moving average filter 

    Xsaved(k) = x;
    Zsaved(k) = z;
end


dt = 0.02;
t  = 0:dt:Nsamples*dt-dt;

figure
hold on
grid
plot(t, Xsaved, '-')
plot(t, Zsaved, 'r:.')
legend('Moving Average Filter', 'Measurements')