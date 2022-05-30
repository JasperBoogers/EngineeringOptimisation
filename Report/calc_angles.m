function [alpha, beta] = calc_angles(s,t, alpha0, beta0, p2, p3, st_f)
    % load parameters
    load_param;
    % st

    % solve system of equations
    f = @(x) [s*cos(x(1)) + t*cos(x(2)) - p3(1) + st_f*st; 
              s*sin(x(1)) + t*sin(x(2)) - p3(2)];
    x0 = [alpha0, beta0];
    res = fsolve(f, x0);
    
    alpha = mod(res(1), 2*pi);
    beta = mod(res(2), 2*pi);
end