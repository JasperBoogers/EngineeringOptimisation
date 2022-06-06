%% init
clear
clf
clc
load_param

%% Decision variables
p2y_r = 0.11;
p2y_l = 0.15;

p3y_r = 0.005;
p3y_l = 0.05;

%% calculate beam lengts
p2r = [nan, p2y_r];
p3r = [p3x_r, p3y_r];
[s,t, alpha0, beta0, p2r] = calc_length(p2r, p3r, d_r_lt);

st_f = 1;
[a, b] = calc_angles(s,t, alpha0, beta0, p2r, p3r, st_f);


figure(1); clf; hold on;
plot(-[0 p2r(1) p3r(1)], [0 p2r(2) p3r(2)])
plot(-[0 s*cos(a) s*cos(a)+t*cos(b)], [0   s*sin(a) s*sin(a)+t*sin(b)])
axis('equal')


p2l = [nan, p2y_l];
p3l = [p3x_l, p3y_l];
[s,t, alpha0, beta0, p2l] = calc_length(p2l, p3l, d_l_lt)

st_f = -1;
[a, b] = calc_angles(s,t, alpha0, beta0, p2l, p3l, st_f);


figure(2); clf; hold on;
plot(-[0 p2l(1) p3l(1)], [0 p2l(2) p3l(2)])
plot(-[0 s*cos(a) s*cos(a)+t*cos(b)], [0   s*sin(a) s*sin(a)+t*sin(b)])
axis('equal')

