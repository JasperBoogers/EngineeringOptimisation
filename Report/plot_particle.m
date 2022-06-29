function stop = plot_particle(optimValues, ~)
    x = optimValues.bestx;
    load_param;
    n = 5;

    [a_l, a_r, ~, ~] = calc_steering_angles(x, n);
    
    delta_r = abs(a_r(2:end) - a_r(1));
    delta_l = abs(a_l(2:end) - a_l(1));
    
    % calcualte differential steer angle = delta_i - delta_o
    r_r = WB./tan(delta_r) + TW/2;
    r_l = (WB-dWB)./tan(delta_l) - TW/2;
    
    r = (r_r+r_l)/2; % average radius
    
    % ideal ackerman angles with given radius
    d_r_A = atan(WB./(r-TW/2));
    d_l_A = atan((WB-dWB)./(r+TW/2));

    plot_config(x);

    figure(2);clf;hold on;
    plot(rad2deg(delta_l), rad2deg(delta_l - delta_r))
    plot(rad2deg(d_l_A), rad2deg(d_l_A - d_r_A))
    title('Ackerman factor')
    xlabel('Steer angle inside wheel \delta_i legt wheel (deg)')
    ylabel('Differential steer angle \Delta\delta = \delta_i - \delta_o (deg)');
    legend('Actual angles', 'Ideal Ackermann angles')
    stop = false;
end
