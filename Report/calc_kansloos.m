clc; clear;
p2 = [nan, -5];
p3 = [15, -1];

[a, b, s, t, p2] = calc_angle(p2, p3);
alpha = rad2deg(a)
beta = rad2deg(b)

st = 4;
d = deg2rad(10);

figure(1); clf; hold on;
plot(-[0 p2(1) p3(1)], [0 p2(2) p3(2)])
plot(-[0 s*cos(a) p3(1)-st], [0   s*sin(a) p3(2)])
% plot(-[0 s*cos(a) s*cos(a+d)+t*cos(bp)], [0   s*sin(a+d) s*sin(a)+t*sin(bp)])
axis('equal')

function [alpha, beta, s, t, p2] = calc_angle(p2, p3)

    % load parameters
%     load_param;
    st = 4;
    d = deg2rad(45);
    % calculate lenths and initial angles
tic
    syms a b p2x bp
    s = sqrt(p2x^2 + p2(2)^2);
    t = sqrt((p3(2)-p2(2))^2 + (p3(1)-p2x)^2);

    % solve system of equations
        eq1 = s*cos(a) + t*cos(b) - p3(1);
        eq2 = s*sin(a) + t*sin(b) - p3(2);
        eq3 = s*cos(a+d) + t*cos(bp) - p3(1) + st;
        eq4 = s*sin(a+d) + t*sin(bp) - p3(2);
    S = vpasolve([eq1,eq2,eq3,eq4],[a, b, p2x, bp]);

    alpha = double(mod(S.a, 2*pi));
    beta  = double(mod(S.b, 2*pi));
    bp    = double(mod(S.bp, 2*pi));
    p2(1) = double(S.p2x);
toc
    [alpha, beta, s, t] = calc_angles(p2, p3);

end