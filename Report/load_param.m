WB = 2.0;       % [m], wheel base
dWB = 0.5;      % [m], wheel base offset of left wheel w.r.t. right wheel
TW = 1.330;     % [m], track width
r = 7.5;        % [m], turning radius
% ST = 1.0;     % [m], horizontal distance between wheel attachment and rack-and-pinion attachment
% x_t = 0.05;   % [m], rack-and-pinion displacement

st     = 0.05;   % [m], maximal rack and pinion extension
p3x_r  = 0.3;    % [m], rack and pinion attachment point x, rigth
p3x_l  = 0.3;    % [m], rack and pinion attachment point x, left

%% function of turning radius
d_l_lt = atan((WB-dWB)/(r - TW/2));     % [deg], steeringwheel input left wheel, left turn
d_r_lt = atan((WB)/(r + TW/2));         % [deg], steeringwheel input right wheel, left turn
d_l_rt = atan((WB-dWB)/(r + TW/2));     % [deg], steeringwheel input left wheel, right turn
d_r_rt = atan((WB)/(r - TW/2));         % [deg], steeringwheel input right wheel, right turn


opt = optimset('Display','off');