% WB = 2.0;   % [m], wheel base
% dWB = 0.5;  % [m], wheel base offset of left wheel w.r.t. right wheel
% B = 1.0;    % [m], front wheel track
% r = 5.0;    % [m], turning radius
% ST = 1.0;   % [m], horizontal distance between wheel attachment and rack-and-pinion attachment
% x_t = 0.05; % [m], rack-and-pinion displacement

st     = 0.05;   % [m], maximal rack and pinion extension
p3x_r  = 0.3;    % [m], rack and pinion attachment point x, rigth
p3x_l  = 0.3;    % [m], rack and pinion attachment point x, left

%% function of turning radius
d_l_lt = 20;     % [deg], steeringwheel input left wheel, left turn
d_l_lt = deg2rad(d_l_lt);
d_r_lt = 20;     % [deg], steeringwheel input left right, left turn
d_r_lt = deg2rad(d_r_lt);
d_l_rt = 20;     % [deg], steeringwheel input left wheel, right turn
d_l_rt = deg2rad(d_l_rt);
d_r_rt = 20;     % [deg], steeringwheel input right wheel, right turn
d_r_rt = deg2rad(d_r_rt);
