% prints the trim conditions

% load params
params;

alt = 1500; % meters
rho = density(alt); % meters

Vinf = 50; % m/s

W = m*g;
Q = 1/2*rho*Vinf^2;

cLtrim = W / (Q*S)
cDtrim = cd0 + k*cLtrim^2;
thrust = Q*S*cDtrim

res = inv([cLa cLde; cma cmde])*[cLtrim-cL0; -cm0];

alpha_trim = res(1)
dele_trim = res(2)

u_trim = Vinf*cos(alpha_trim)
w_trim = Vinf*sin(alpha_trim)