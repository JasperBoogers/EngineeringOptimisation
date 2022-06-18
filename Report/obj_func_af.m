function [c] = obj_func_af(delta_r, delta_l)
    load_param;

    r_r = WB./tan(delta_r) + TW/2;
    r_l = (WB-dWB)./tan(delta_l) - TW/2;

    r = (r_r+r_l)/2;
    
    d_r_A = atan(WB./(r+TW/2));
    d_l_A = atan((WB-dWB)./(r-TW/2));

%     c = ((delta_r - delta_l)/(d_r_A - d_l_A) - 1)^2;
   c = (delta_r/d_r_A - 1)^2 + (delta_l/d_l_A - 1)^2;
end
