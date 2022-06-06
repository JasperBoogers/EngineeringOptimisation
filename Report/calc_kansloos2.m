clc; clear;
% paramters
p2 = [nan, -5];
p3 = [15, -1];
st = 4;
d = deg2rad(45);

% calculate lenths and initial angles
syms a b p2x bp
s = sqrt(p2x^2 + p2(2)^2);
t = sqrt((p3(2)-p2(2))^2 + (p3(1)-p2x)^2);

% solve system of equations
    eq1 = s*cos(a) + t*cos(b) - p3(1);
    eq2 = s*sin(a) + t*sin(b) - p3(2);
    eq3 = s*cos(a-d) + t*cos(bp) - p3(1) + st;
    eq4 = s*sin(a-d) + t*sin(bp) - p3(2);
S = vpasolve([eq1,eq2,eq3,eq4],[a, b, p2x, bp]);

alpha0 = double(mod(S.a, 2*pi))
beta0  = double(mod(S.b, 2*pi))
bp     = double(mod(S.bp, 2*pi))
p2(1)  = double(S.p2x);


[alpha1, beta1] = calc_angles(p2, p3, st);


figure(1); clf; hold on;
plot(-[0 p2(1) p3(1)], [0 p2(2) p3(2)])
plot(-[0 s*cos(alpha0) p3(1)], [0 s*sin(alpha0) p3(2)], '--')
plot(-[0 s*cos(alpha0-d) s*cos(alpha0-d)+t*cos(bp)], [0   s*sin(alpha0-d) s*sin(alpha0-d)+t*sin(bp)])
plot(-[0 s*cos(alpha1) s*cos(alpha1)+t*cos(beta1)], [0   s*sin(alpha1) s*sin(alpha1)+t*sin(beta1)],'--')
axis('equal')
