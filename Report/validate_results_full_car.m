%% init
clear
clc

load('Data/data_ackerman_particle_9.mat')
load_param;

%%

n=2;

% unpack x into coordinates
p2y_r = x(1); p2y_l = x(2); p3y_r = x(3); p3y_l = x(4);
p2r = [nan, p2y_r];
p3r = [p3x_r, p3y_r];

p2l = [nan, p2y_l];
p3l = [p3x_l, p3y_l];

% linearly spaced steering inputs, filter out 0 and 1
st_f = linspace(0,1,n); %+1);
st_f = st_f(2:end);
[s_r, t_r, a0_r, b0_r, p2r] = calc_length(p2r, p3r, d_r_rt);
[s_l, t_l, a0_l, b0_l, p2l] = calc_length(p2l, p3l, d_l_rt);

 % calculate intermediate steering angles for the steering inputs
    a_r = [a0_r, zeros(1,n-1)];
    b_r = [b0_r, zeros(1,n-1)];
    a_l = [a0_l, zeros(1,n-1)];
    b_l = [b0_l, zeros(1,n-1)];
    for i = 1:n-1
        [a_r(i+1), b_r(i+1)] = calc_angles(s_r,t_r, a_r(i), b_r(i), p3r, st_f(i));
        [a_l(i+1), b_l(i+1)] = calc_angles(s_l,t_l, a_l(i), b_l(i), p3l, -st_f(i));
    end

delta_r = a_r(1:end) - a_r(1);
delta_l = -(a_l(1:end) - a_l(1));

% calcualte differential steer angle = delta_i - delta_o
r_r = WB./tan(delta_r) + TW/2;
r_l = (WB-dWB)./tan(delta_l) - TW/2;

% average radius
r = (r_r+r_l)/2;

% ideal ackerman angles with given radius
d_r_A = atan(WB./(r+TW/2));
d_l_A = atan((WB-dWB)./(r-TW/2));

% variables for nice plotting
D_wheel = 0.45; % wheel diameter
L = 10;         % length extending line

figure(1); clf;
for i = 1:n
    delta_r_plot = (delta_r(i) + pi/2);
    delta_l_plot = (delta_l(i) + pi/2);

    % rear wheel
    plot(0, 0, 'b*'); hold on;
    line([0 0], D_wheel*[1 -1], 'color', 'k')
    line(L*[-.2 1], [0 0])
    
    % front right
    plot(0, WB, 'b*') % wheel point
    line(D_wheel*cos(delta_r_plot)*[-1 1], D_wheel*sin(delta_r_plot)*[-1 1]+WB, 'color', 'k') % wheel
    line(L*cos(delta_r_plot+pi/2)*[-1 0], L*sin(delta_r_plot+pi/2)*[-1 0]+WB, 'color', 'r') % extending line
    plot(-[0 s_r*cos(a_r(i)) s_r*cos(a_r(i))+t_r*cos(b_r(i))] + 0, ...
         -[0 s_r*sin(a_r(i)) s_r*sin(a_r(i))+t_r*sin(b_r(i))] + WB, ...
          'r', 'LineWidth', 1)      % tie rod and steering arm
    plot(-[0 s_r*cos(a_r(1)) s_r*cos(a_r(1))+t_r*cos(b_r(1))] + 0, ...
         -[0 s_r*sin(a_r(1)) s_r*sin(a_r(1))+t_r*sin(b_r(1))] + WB, ...
          'b', 'LineWidth', 0.5)         % tie rod and steering arm straight position
    
    
    % front left
    plot(-TW, WB-dWB, 'b*') % wheel point
    line(D_wheel*cos(delta_l_plot)*[-1 1]-TW, D_wheel*sin(delta_l_plot)*[-1 1]+WB-dWB, 'color', 'k') % wheel
    line(L*cos(delta_l_plot+pi/2)*[-1 0]-TW, L*sin(delta_l_plot+pi/2)*[-1 0]+WB-dWB, 'color', 'r') % extending line
    plot([0 s_l*cos(a_l(i)) s_l*cos(a_l(i))+t_l*cos(b_l(i))] + -TW, ...
         -[0 s_l*sin(a_l(i)) s_l*sin(a_l(i))+t_l*sin(b_l(i))] + WB-dWB, ...
          'r', 'LineWidth', 1)      % tie rod and steering arm
    plot([0 s_l*cos(a_l(1)) s_l*cos(a_l(1))+t_l*cos(b_l(1))] + -TW, ...
         -[0 s_l*sin(a_l(1)) s_l*sin(a_l(1))+t_l*sin(b_l(1))] + WB-dWB, ...
          'b', 'LineWidth', 0.5)         % tie rod and steering arm straigth position


    hold off; axis('equal');
    drawnow;
    pause;
end



