clear all

dt = 0.05;
t  = 0:dt:20;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 3);
Zsaved = zeros(Nsamples, 1);
               
for k=1:Nsamples
  r = GetRadar(dt); 

  [pos vel alt] = RadarUKF(r, dt);
  
  Xsaved(k, :) = [pos vel alt];
  Zsaved(k)    = r;
end 


PosSaved = Xsaved(:, 1);
VelSaved = Xsaved(:, 2);
AltSaved = Xsaved(:, 3);

t = 0:dt:Nsamples*dt-dt;

figure
plot(t, PosSaved)

figure
plot(t, VelSaved)

figure
plot(t, AltSaved)