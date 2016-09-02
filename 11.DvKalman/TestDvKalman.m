clear all


dt = 0.1;
t  = 0:dt:10;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 2);
Zsaved = zeros(Nsamples, 1);

for k=1:Nsamples
  z = GetPos();      
  [pos vel] = DvKalman(z);
  
  Xsaved(k, :) = [pos vel];
  Zsaved(k)    = z;
end


figure
hold on
plot(t, Zsaved(:), 'r.')
plot(t, Xsaved(:, 1))

figure
plot(t, Xsaved(:, 2))