close all;
clear;

u0 = 44.673; v0 = 0; w0 = 0.4030; x0 = 0; y0 = 0; z0 = -1500; p0 = 0; q0 = 0.04; r0 = 0;phi0 = 0; theta0 = 0.007539; psi0 = 0; 

states0 = [u0, v0, w0, x0, y0, z0, p0, q0, r0, phi0, theta0, psi0];

[t,y] = rk4(@sixdofmodel, 50, 0.01, states0);

figure();
subplot(6,1,1);
plot(t,y(:,1));
ylabel('u');

subplot(6,1,2);
plot(t,y(:,2));
ylabel('v');

subplot(6,1,3);
plot(t,y(:,3));
ylabel('w');

subplot(6,1,4);
plot(t,y(:,10));
ylabel('phi');

subplot(6,1,5);
plot(t,y(:,11));
ylabel('theta');

subplot(6,1,6);
plot(t,y(:,12));
ylabel('psi');

function rho = density(h)
% calculates the air density between 0-5 kms approximately
% altitude is in meters

rho0 = 1.225; % kg/m^3
H0 = 10400; %m (scale height)

rho = rho0*exp(-h/H0);
end
