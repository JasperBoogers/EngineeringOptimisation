function [s,t, alpha0, beta0, p2] = calc_length(p2, p3, d)

    % load parameters
    load_param;

    % calculate lenths and initial angles
    syms a b p2x bp
    ss = sqrt(p2x^2 + p2(2)^2);
    ts = sqrt((p3(2)-p2(2))^2 + (p3(1)-p2x)^2);
    
    % solve system of equations
        eq1 = ss*cos(a) + ts*cos(b) - p3(1);
        eq2 = ss*sin(a) + ts*sin(b) - p3(2);
        eq3 = ss*cos(a-d) + ts*cos(bp) - p3(1) - st; %dit minnetje is heel gaar
        eq4 = ss*sin(a-d) + ts*sin(bp) - p3(2);
    S = vpasolve([eq1,eq2,eq3,eq4],[a, b, p2x, bp]);
    
    alpha0 = double(mod(S.a, 2*pi));
    beta0  = double(mod(S.b, 2*pi));
%     bp     = double(mod(S.bp, 2*pi))
    p2(1)  = double(S.p2x);
    
    s = sqrt(p2(1)^2 + p2(2)^2);
    t = sqrt((p3(2)-p2(2))^2 + (p3(1)-p2(1))^2);
end

