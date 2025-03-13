function [t,y] = rk4(dydt, tf, h, y0)
% reshape y0 to column vector
y0 = reshape(y0, [], 1);

n0= tf/h;
p = size(y0,1);

t = zeros(n0,1);
y = zeros(n0,p);

tn = 0;
yn = y0;

t(1,:) = tn;
y(1,:) = yn';

for i=2:n0+1
k1 = dydt(tn, yn);
k2 = dydt(tn + h/2, yn + h*k1/2);
k3 = dydt(tn + h/2, yn + h*k2/2);
k4 = dydt(tn + h, yn + h*k3);

yn = yn + (k1 + 2*k2 + 2*k3 + k4)*h/6;
tn = tn + h;

t(i) = tn;
y(i,:) = yn';
end
end