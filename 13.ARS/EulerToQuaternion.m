function z = EulerToQuaternion(phi, theta, psi)
%
%
sinPhi   = sin(phi/2);    cosPhi   = cos(phi/2);
sinTheta = sin(theta/2);  cosTheta = cos(theta/2);
sinPsi   = sin(psi/2);    cosPsi   = cos(psi/2);

z = [ cosPhi*cosTheta*cosPsi + sinPhi*sinTheta*sinPsi;
      sinPhi*cosTheta*cosPsi - cosPhi*sinTheta*sinPsi;
      cosPhi*sinTheta*cosPsi + sinPhi*cosTheta*sinPsi;
      cosPhi*cosTheta*sinPsi - sinPhi*sinTheta*cosPsi;
    ];