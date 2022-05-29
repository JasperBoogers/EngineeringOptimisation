% constanten

RP_uitslag  = 32;           % mm naar links en rechts
RP_voor     = [-940 -180];  % mm
RP_achter   = [-1620 -180]; % mm
extender    = 150;          % mm

stuurarm_L  = 120;          % mm
tierod_L    = 241;          % mm

stuurarm_R  = 80;           % mm
tierod_R    = 236;          % mm

upright_R   = [-900 -500];   % mm
upright_L   = [-1700 500];   % mm

wielpunten  = [-800 -1489.5 -2770;
               -665  665    -665];

close
figure;hold on;axis('equal');view([90 -90])
% Nuna 'contour' plotten
line([0 0], 1800*[1/2 -1/2])
line(-3500*[1 1], 1800*[1/2 -1/2])

plot(upright_L(1), upright_L(2), '*r')
plot(upright_R(1), upright_R(2), '*r')
plot(wielpunten(1,:), wielpunten(2,:), '*k')

% R&Ps plotten
line(RP_voor(1)*[1 1], RP_voor(2)+RP_uitslag*[1 -1], 'LineWidth', 1.5, 'Color', 'k')
line(RP_achter(1)*[1 1], RP_achter(2)+RP_uitslag*[1 -1], 'LineWidth', 1.5, 'Color', 'k')
line([RP_voor(1) RP_achter(1)], [RP_voor(2) RP_achter(2)])






