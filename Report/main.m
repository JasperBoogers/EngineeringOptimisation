%% init
clear
clf
clc
load_param

%% Decision variables
p2y_r = 0.10;
p2y_l = 0;

p3y_r = -0.05;
p3y_l = 0;

%% calculate beam lengts
p2r = [nan, p2y_r];
p3r = [p3x_r, p3y_r];
[s,t, alpha0, beta0, p2r] = calc_length(p2r, p3r, d_l_lt)


st_f = 1;
[a, b] = calc_angles(s,t, alpha0, beta0, p2r, p3r, st_f);


figure(1); clf; hold on;
plot(-[0 p2r(1) p3r(1)], [0 p2r(2) p3r(2)])
plot(-[0 s*cos(a) s*cos(a)+t*cos(b)], [0   s*sin(a) s*sin(a)+t*sin(b)])
axis('equal')