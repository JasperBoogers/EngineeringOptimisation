%% init
clear
clf
clc


load('Data/data_ackerman_particle_8.mat')
load_param;

%%

n=5;

% unpack x into coordinates
p2y_r = x(1); p2y_l = x(2); p3y_r = x(3); p3y_l = x(4);
p2r = [nan, p2y_r];
p3r = [p3x_r, p3y_r];

p2l = [nan, p2y_l];
p3l = [p3x_l, p3y_l];

% linearly spaced steering inputs, filter out 0 and 1
st_f = linspace(0,1,n+2);
%st_f = st_f(2:end-1);
[s_r, t_r, a0_r, b0_r, p2r] = calc_length(p2r, p3r, d_r_rt);
[s_l, t_l, a0_l, b0_l, p2l] = calc_length(p2l, p3l, d_l_rt);

 % calculate intermediate steering angles for the steering inputs
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

% calcualte differential steer angle = delta_i - delta_o
r_r = WB./tan(delta_r) + TW/2;
r_l = (WB-dWB)./tan(delta_l) - TW/2;

% average radius
r = (r_r+r_l)/2;

% ideal ackerman angles with given radius
d_r_A = atan(WB./(r+TW/2));
d_l_A = atan((WB-dWB)./(r-TW/2));

figure(2);clf;hold on;
plot(rad2deg(delta_l), rad2deg(delta_l - delta_r))
plot(rad2deg(d_l_A), rad2deg(d_l_A - d_r_A))
title('Ackerman factor')
xlabel('Steer angle inside wheel \delta_i legt wheel (deg)')
ylabel('Differential steer angle \Delta\delta = \delta_i - \delta_o (deg)')
legend('Actual', 'Ideal')

c = obj_func(delta_r, delta_l, 'right');
c_af = obj_func_af(delta_r, delta_l);

figure(1); clf;
subplot(1,2,2); hold on;
title('Right wheel');
plot(-[0 p2r(1) p3r(1)], [0 p2r(2) p3r(2)])
for i = 1:n
    plot(-[0 s_r*cos(a_r(i)) s_r*cos(a_r(i))+t_r*cos(b_r(i))], [0   s_r*sin(a_r(i)) s_r*sin(a_r(i))+t_r*sin(b_r(i))])
end
axis('equal')
legend()


subplot(1,2,1); hold on;
title('Left wheel')

plot([0 p2l(1) p3l(1)], [0 p2l(2) p3l(2)])
for i=1:n
    plot([0 s_l*cos(a_l(i)) s_l*cos(a_l(i))+t_l*cos(b_l(i))], [0   s_l*sin(a_l(i)) s_l*sin(a_l(i))+t_l*sin(b_l(i))])
end
axis('equal')
legend()

% function plot_ackerman_factor()
