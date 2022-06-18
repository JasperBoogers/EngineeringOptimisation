%% init
clear
clf
clc
load_param

%% Decision variables
max_v = 0.3;
min_v = 0.01;
nvars = 4;
lb    = min_v*ones(nvars,1);
ub    = max_v*ones(nvars,1);

options = optimoptions('particleswarm', 'UseParallel',true, Display='iter');
fun = @(x) main(x); tic
[x,fval,exitflag,output] = particleswarm(fun, nvars, lb, ub, options); toc

%% calculate beam lengts
function c = main(x) %p2y_r, p2y_l, p3y_r, p3y_l)
    load_param
    p2y_r = x(1); p2y_l = x(2); p3y_r = x(3); p3y_l = x(4);
    p2r = [nan, p2y_r];
    p3r = [p3x_r, p3y_r];
    
    p2l = [nan, p2y_l];
    p3l = [p3x_l, p3y_l];
    
    n = 5;
    st_f = linspace(0,1,n+2);
    st_f = st_f(2:end-1);
    [s_r, t_r, a0_r, b0_r, p2r] = calc_length(p2r, p3r, d_r_rt);
    [s_l, t_l, a0_l, b0_l, p2l] = calc_length(p2l, p3l, d_l_rt);
    a_r = [a0_r, zeros(1,n)];
    b_r = [b0_r, zeros(1,n)];
    a_l = [a0_l, zeros(1,n)];
    b_l = [b0_l, zeros(1,n)];
    
    for i = 1:n
        [a_r(i+1), b_r(i+1)] = calc_angles(s_r,t_r, a_r(i), b_r(i), p2r, p3r, st_f(i));
        [a_l(i+1), b_l(i+1)] = calc_angles(s_l,t_l, a_l(i), b_l(i), p2l, p3l, -st_f(i));
    end
    
    delta_r = abs(a_r(2:end) - a_r(1));
    delta_l = abs(a_l(2:end) - a_l(1));
    
    c = obj_func(delta_r, delta_l, 'right');
%     c = obj_func_af(delta_r, delta_l);
end
