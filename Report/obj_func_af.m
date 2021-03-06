function [c] = obj_func_af(delta_r, delta_l)
    load_param;
    
    % Calculate turning radius for each wheel
    r_r = WB./tan(delta_r) + TW/2;
    r_l = (WB-dWB)./tan(delta_l) - TW/2;

    % average turning radius
    r = (r_r+r_l)/2;
    
    % ideal ackerman steering angle per wheel
    d_r_A = atan(WB./(r-TW/2));
    d_l_A = atan((WB-dWB)./(r+TW/2));

    c = sum(((delta_r - delta_l)./(d_r_A - d_l_A) - 1).^2);
end