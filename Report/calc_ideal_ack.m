clc; clear; clf;

% calculate ideal Ackerman angles.
% from lecture slides RO47017 lecture 10 and https://nl.mathworks.com/help/vdynblks/ref/kinematicsteering.html

d_ack = 20;         % deg steering angle
TW    = 1.330;      % track width
WB_l  = 0.6895;     % wheel base left
WB_r  = 1.97;       % wheel base right
D_w   = 0.43;       % wheel diameter

% % right cornering (ignoring kingpin offset
% d_out = atand(WB_l*tand(d_ack) / (WB_l + 0.5*TW*tand(d_ack)));
% d_in  = atand(WB_r*tand(d_ack) / (WB_r - 0.5*TW*tand(d_ack)));


% % left cornering
% d_out = atand(WB_r*tand(d_ack) / (WB_r + 0.5*TW*tand(d_ack)));
% d_in  = atand(WB_l*tand(d_ack) / (WB_l - 0.5*TW*tand(d_ack)));

% right cornering input steering circle
r = 7;
d_out = atand(WB_l/(TW+r));
d_in  = atand(WB_r/(r));

wielpunten  = 1e-3*[665   -665     665;
                    -800  -1489.5 -2770];

figure(1); hold on
L = 10; % lengte stuur lijnen

% rechts voor
plot(wielpunten(1,1), wielpunten(2,1), 'k*') 
line(wielpunten(1,1)+ D_w/2*sind(d_in)*[1 -1], wielpunten(2,1)+ D_w/2*cosd(d_in)*[1 -1], 'Linewidth', 2)
line(wielpunten(1,1)+ L*sind(d_in+90)*[1 -1],  wielpunten(2,1)+ L*cosd(d_in+90)*[1 -1])

% links voor
plot(wielpunten(1,2), wielpunten(2,2), 'k*') 
line(wielpunten(1,2)+ D_w/2*sind(d_out)*[1 -1], wielpunten(2,2)+ D_w/2*cosd(d_out)*[1 -1], 'Linewidth', 2)
line(wielpunten(1,2)+ L*sind(d_out+90)*[1 -1],  wielpunten(2,2)+ L*cosd(d_out+90)*[1 -1])

% achter
plot(wielpunten(1,3), wielpunten(2,3), 'k*')
line(wielpunten(1,3)+[0 0], wielpunten(2,3)+0.5*[D_w -D_w], 'Linewidth', 2)
line(wielpunten(1,3)+[-L L], wielpunten(2,3)+[0 0])

axis('equal')

