
function [Fxaero, Fyaero, Fzaero, l, M, N] = aeroForcesMoments(states, ctrl)

% load the params
params;

statesCell = num2cell(states);
[u, v, w, x, y, z, p, q, r, phi, theta, psi] = statesCell{:};

dele = ctrl(1);
dela = ctrl(2);
delr = ctrl(3);

rho = density(-z);

Vinf = sqrt(u^2 + v^2 + w^2);
alpha = atan2(w,u);
beta = asin(v/Vinf);

ph = p*b/2/Vinf;
qh = q*cb/2/Vinf;
rh = r*b/2/Vinf;

cL = cL0 + cLa*alpha + cLq*qh + cLde*dele;
cD = cd0 + k*cL^2;
cY = cy0 + cyb*beta + cydr*delr;
cM = cm0 + cma*alpha + cmq*qh + cmde*dele;
cl = cl0 + clb*beta + clp*ph + clr*rh + clda*dela + cldr*delr;
cN = cn0 + cnb*beta + cnp*ph + cnr*rh + cnda*dela + cndr*delr;

cX = cL*sin(alpha) - cD*cos(alpha);
cZ = -(cL*cos(alpha) + cD*sin(alpha));

Q = 1/2*rho*Vinf^2;

Fxaero = Q*S*cX;
Fyaero = Q*S*cY;
Fzaero = Q*S*cZ;

l = Q*S*b*cl;
M = Q*S*cb*cM;
N = Q*S*b*cN;
end