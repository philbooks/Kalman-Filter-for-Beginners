clear all

Nsamples = 41500;
EulerSaved = zeros(Nsamples, 3);

dt = 0.01;

for k=1:Nsamples
  [p q r] = GetGyro();  
  A = eye(4) + dt*1/2*[ 0  -p  -q  -r;
                        p   0   r  -q;
                        q  -r   0   p;
                        r   q  -p   0
                      ];

  [ax ay] = GetAccel();                   
  [phi theta] = EulerAccel(ax, ay); 
  z = EulerToQuaternion(phi, theta, 0);

  [phi theta psi] = EulerKalman(A, z);
  
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