function [c] = obj_func(delta_r, delta_l, dir)
    load_param;
    
%     if contains(dir,'left')
%         ack_r = atan2(WB/(r+TW/2));
%         ack_l = atan2((WB-dWB)/(r-TW/2));
% 
%         c = (delta_r-delta_l)/(ack_r - ack_l);
% 
%     else
%         ack_r = atan2( WB/(r-TW/2) );
%         ack_l = atan2((WB-dWB)/(r+TW/2));
% 
%         c = (delta_l-delta_r)/(ack_l - ack_r);
%     end
    r_r = WB./tan(delta_r) + TW/2;
    r_l = (WB-dWB)./tan(delta_l) - TW/2;
    
    c = norm(r_r - r_l)^2;
    
end

