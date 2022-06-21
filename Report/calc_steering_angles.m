function [a_l, a_r, b_l, b_r] = calc_steering_angles(x, n)
    load_param;

    % unpack x into coordinates
    p2y_r = x(1); p2y_l = x(2); p3y_r = x(3); p3y_l = x(4);
    p2r = [nan, p2y_r];
    p3r = [p3x_r, p3y_r];
    
    p2l = [nan, p2y_l];
    p3l = [p3x_l, p3y_l];
    
    % linearly spaced steering inputs, optionally filter out 0 and 1
    st_f = linspace(0,1,n+2);
    % st_f = st_f(2:end-1);
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
end

