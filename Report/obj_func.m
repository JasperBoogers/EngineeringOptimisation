function [c] = obj_func(delta_r, delta_l)
    %OBJ_FUNC Summary of this function goes here
    %   Detailed explanation goes here

    load_param;
    
    % right turn 
    r_r = WB./tan(delta_r) + TW/2;
    r_l = (WB-dWB)./tan(delta_l) - TW/2;
    
    c = norm(r_r - r_l)^2;
end

