clear all


dt = 0.2;
t  = 0:dt:10;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 1);
Zsaved = zeros(Nsamples, 1);

for k=1:Nsamples
  z = GetVolt();  
  volt = SimpleKalman(z);
  
  Xsaved(k) = volt;
  Zsaved(k) = z;
end


figure
plot(t, Xsaved, 'o-')
hold on
plot(t, Zsaved, 'r:*') 