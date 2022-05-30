function [alpha, beta, s, t] = calc_angles(p2, p3, st)

    % load parameters
%     load_param;

    % calculate lenths and initial angles
    s = sqrt(p2(1)^2 + p2(2)^2);
    t = sqrt((p3(2)-p2(2))^2 + (p3(1)-p2(1))^2);

    alpha0 = atan2(p2(2),p2(1));
    beta0  = atan2((p3(2)-p2(2)),(p3(1)-p2(1)));

    % solve system of equations
    f = @(x) [s*cos(x(1)) + t*cos(x(2)) - p3(1) + st; 
              s*sin(x(1)) + t*sin(x(2)) - p3(2)];
    x0 = [alpha0, beta0];
    res = fsolve(f, x0);
    
    alpha = mod(res(1), 2*pi);
    beta = mod(res(2), 2*pi);


%     syms a b 
%         eq1 = s*cos(a) + t*cos(b) - p3(1) + st;
%         eq2 = s*sin(a) + t*sin(b) - p3(2);
%     S = vpasolve([eq1,eq2],[a, b],[alpha0, beta0]);
% 
%     alpha = double(mod(S.a, 2*pi));
%     beta  = double(mod(S.b, 2*pi));
end

% clc; clear;
% p2 = [8, -7];
% p3 = [15, -1];
% 
% [a, b, s, t] = calc_angle(p2, p3);
% alpha = rad2deg(a)
% beta = rad2deg(b)
% 
% figure(1); clf; hold on;
% plot(-[0 p2(1) p3(1)], [0 p2(2) p3(2)])
% plot(-[0 s*cos(a) s*cos(a)+t*cos(b)], [0   s*sin(a) s*sin(a)+t*sin(b)])
% axis('equal')