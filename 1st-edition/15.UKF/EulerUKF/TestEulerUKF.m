clear all

Nsamples = 41500;
EulerSaved = zeros(Nsamples, 3);

dt = 0.01;

for k=1:Nsamples
  [p q r] = GetGyro();
  [ax ay] = GetAccel(); 

  [phi_a theta_a] = EulerAccel(ax, ay); 

  [phi theta psi] = EulerUKF([phi_a theta_a]', [p q r], dt);
  
  EulerSaved(k, :) = [ phi theta psi ];
end 


PhiSaved   = EulerSaved(:, 1) * 180/pi;
ThetaSaved = EulerSaved(:, 2) * 180/pi;
PsiSaved   = EulerSaved(:, 3) * 180/pi;

t = 0:dt:Nsamples*dt-dt;

figure
plot(t, PhiSaved)

figure
plot(t, ThetaSaved)

figure
plot(t, PsiSaved)