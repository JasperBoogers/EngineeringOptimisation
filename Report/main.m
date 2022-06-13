%% init
clear
clf
clc
load_param

%% Decision variables
p2y_r = 0.11;
p2y_l = 0.11;

p3y_r = 0.005;
p3y_l = 0.005;

%% calculate beam lengts
p2r = [nan, p2y_r];
p3r = [p3x_r, p3y_r];

p2l = [nan, p2y_l];
p3l = [p3x_l, p3y_l];

n = 5;
st_f = linspace(0,1,n+2);
st_f = st_f(2:end-1);
[s_r, t_r, a0_r, b0_r, p2r] = calc_length(p2r, p3r, d_r_lt);
[s_l, t_l, a0_l, b0_l, p2l] = calc_length(p2l, p3l, d_l_lt);
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

c = obj_func(delta_r, delta_l);

figure(1); clf;
subplot(1,2,2); hold on;
title('rechts');
for i = 1:n
    plot(-[0 p2r(1) p3r(1)], [0 p2r(2) p3r(2)])
    plot(-[0 s_r*cos(a_r(i)) s_r*cos(a_r(i))+t_r*cos(b_r(i))], [0   s_r*sin(a_r(i)) s_r*sin(a_r(i))+t_r*sin(b_r(i))])
end
axis('equal')


subplot(1,2,1); hold on;
title('links')
for i=1:n
    plot([0 p2l(1) p3l(1)], [0 p2l(2) p3l(2)])
    plot([0 s_l*cos(a_l(i)) s_l*cos(a_l(i))+t_l*cos(b_l(i))], [0   s_l*sin(a_l(i)) s_l*sin(a_l(i))+t_l*sin(b_l(i))])
end
axis('equal')

