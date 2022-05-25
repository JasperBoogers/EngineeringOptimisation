function [a, b] = calc_angles(s, t, y)

% load parameters
load_param;

f = @(x) [s*sin(x(1)) - t*sin(x(2)) - y; s*cos(x(1)) + t*cos(x(2)) - ST];
x0 = rand(2,1)*2*pi;
res = fsolve(f, x0);

a = mod(res(1), 2*pi);
b = mod(res(2), 2*pi);
end