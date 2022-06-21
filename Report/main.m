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

options = optimoptions('particleswarm', ...
    'UseParallel',true, ...
    Display='iter', ...
    PlotFcn=@plot_particle);

tic
[x,fval,exitflag,output] = particleswarm(@(x) fun(x), nvars, lb, ub, options); 
toc

function c = fun(x)
    % calculate intermediate steering angles
    [a_l, a_r, ~, ~] = calc_steering_angles(x, 5);
    
    % take absolute values of the steering angles
    delta_r = abs(a_r(2:end) - a_r(1));
    delta_l = abs(a_l(2:end) - a_l(1));
    
    % calculate objective function
%     c = obj_func(delta_r, delta_l, 'right');
    c = obj_func_af(delta_r, delta_l);
end
