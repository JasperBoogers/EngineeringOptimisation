function [] = plot_config(p2y_l, p2y_r, p3y_l, p3y_r)
    load_param;

    p2r = [nan, p2y_r];
    p3r = [p3x_r, p3y_r];

    p2l = [nan, p2y_l];
    p3l = [p3x_l, p3y_l];

    [~, ~, ~, ~, p2r] = calc_length(p2r, p3r, d_r_lt);
    [~, ~, ~, ~, p2l] = calc_length(p2l, p3l, d_l_lt);

    figure();
    subplot(1,2,2); hold on;
    title('rechts');
    plot(-[0 p2r(1) p3r(1)], [0 p2r(2) p3r(2)])
    axis('equal')
    
    subplot(1,2,1); hold on;
    title('links');
    plot([0 p2l(1) p3l(1)], [0 p2l(2) p3l(2)])
    axis('equal')

end

