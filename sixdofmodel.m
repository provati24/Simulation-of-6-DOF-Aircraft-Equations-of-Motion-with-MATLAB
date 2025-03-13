function dstates = sixdofmodel(t, states)

% load the params
params;

statesCell = num2cell(states);
[u, v, w, x, y, z, p, q, r, phi, theta, psi] = statesCell{:};
ctrl = control(t,states);

[Fxaero, Fyaero, Fzaero, l, M, N] = aeroForcesMoments(states, ctrl);

T = ctrl(4);

du = Fxaero/m + T/m - q*w + r*v - g*sin(theta);
dv = Fyaero/m - r*u + p*w + g*cos(theta)*sin(phi);
dw = Fzaero/m - p*v + q*u + g*cos(theta)*cos(phi);

[b2i_mat, pqr2eul] = rotmats([phi theta psi]);

dxx = b2i_mat*[u; v; w];

dx = dxx(1);
dy = dxx(2);
dz = dxx(3);

dp = (l*Izz + N*Ixz - p*q*(Ixz*(Iyy-Ixx-Izz)) - q*r*(Izz*(Izz-Iyy)+Ixz^2))/(Ixx*Izz - Ixz^2);
dq = (M + p*r*(Izz-Ixx) - Ixz*(p^2-r^2))/Iyy;
dr = (l*Ixz + N*Ixx + p*q*(Ixz^2+Ixx*(Ixx-Iyy)) + q*r*(Ixz*(Iyy-Ixx-Izz)))/(Ixx*Izz - Ixz^2);

deul = pqr2eul*[p;q;r];
dphi = deul(1);
dtheta = deul(2);
dpsi = deul(3);

dstates = [du, dv, dw, dx, dy, dz, dp, dq, dr, dphi, dtheta, dpsi]';
% dstates = [du, 0, dw, 0, 0, dz, 0, dq, 0, 0, dtheta, 0]';
end