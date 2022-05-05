clc; clear; clf;


% Assignment of constant design parameter values
springparams1;

% Assignment of unconstant design parameter values
Tau12max = 600e6;
Freq1lb = 400;

% Matrix of output values for combinations of design variables D and d 
D = [0.020:0.001:0.040];
d = [0.002:0.0002:0.005];
for j=1:1:length(d)
  for i=1:1:length(D)
%   Analysis of valve spring.
    [svol,smass,bvol,matc,manc,Lmin,L2,k,F1,F2,Tau1,Tau2,freq1,F1min,F2min]=...
    springanalysis1(D(i),d(j),L0,L1,n,E,G,rho,Dv,h,p1,p2,nm,ncamfac,nne,matp,bldp);
    funk(j,i) = smass;
    c1(j,i) = (Lmin - L2)/Lmin;
    c2(j,i) = (F1min - F1)/F1min;
    c3a(j,i) = (F2min - F2)/1;
    c3(j,i) = (F2min - F2)/F2min;
    c4(j,i) = (Tau2 - Tau12max)/Tau12max;
    c5(j,i) = (Freq1lb - freq1)/Freq1lb;
    c6a(j,i) = (D(i) - 0.04)/0.04;
    c6b(j,i) = (0.02 - D(i))/0.02;
    c7a(j,i) = (d(j) - 0.005)/0.005;
    c7b(j,i) = (0.002 - d(j))/0.002; 

  end
end

% Contour plot of objective and constraint 1
subplot(231)
hold on
contour(D, d, funk, [0.1 0.08 0.06 0.04 0.02], '-', "ShowText","on")
m1 = contour(D, d, c1, [0 0], 'b--', LineWidth=1);
m2 = contour(D, d, c1, -0.04*[1 2 3], 'b--');

% x = [m1(1,2:end) flip(m2(1,2:end))];
% y = [m1(2,2:end) flip(m2(2,2:end))];
% 
% fill(x,y,'b', FaceAlpha=0.1, LineStyle='none')

% contour(D, d, c1, -0.05*[1 2 3], 'b--')
legend('mass (kg)', 'L_{min}')
xlabel('D (m)'), ylabel('d (m)'), title('      Contours of objective function (kg)')
grid

% Contour of objective and constraint 2
subplot(232)
hold on
contour(D, d, funk, [0.1 0.08 0.06 0.04 0.02], '-', "ShowText","on")
contour(D, d, c2, [0 0], 'm--', LineWidth=1)
contour(D, d, c2, -0.2*[1 2 3], 'm--')
legend('mass (kg)', 'F_{1, min}')
xlabel('D (m)'), ylabel('d (m)'), title('      Contours of objective function (kg)')
grid

% Contour of objective and constraint 3
subplot(233)
hold on
contour(D, d, funk, [0.1 0.08 0.06 0.04 0.02], '-', "ShowText","on")
contour(D, d, c3, [0 0], 'c--', LineWidth=1)
contour(D, d, c3, -0.2*[1 2 3], 'c--')
% contour(D, d, c3a, 'r-', 'ShowText',	'on')
legend('mass (kg)', 'F_{2, min}')
xlabel('D (m)'), ylabel('d (m)'), title('      Contours of objective function (kg)')
grid

% Contour of objective and constraint 4
subplot(234)
hold on
contour(D, d, funk, [0.1 0.08 0.06 0.04 0.02], '-', "ShowText","on")
contour(D, d, c4, [0 0], 'r--', LineWidth=1)
contour(D, d, c4, -0.1*[1 2 3], 'r--')
legend('mass (kg)', '\tau _{1,2, max}')
xlabel('D (m)'), ylabel('d (m)'), title('      Contours of objective function (kg)')
grid

% Contour of objective and constraint 5
subplot(235)
hold on
contour(D, d, funk, [0.1 0.08 0.06 0.04 0.02], '-', "ShowText","on")
contour(D, d, c5, [0 0], 'g--', LineWidth=1)
contour(D, d, c5, -0.1*[1 2 3], 'g--')
legend('mass (kg)', 'Freq_{1, lb}')
xlabel('D (m)'), ylabel('d (m)'), title('      Contours of objective function (kg)')
grid


subplot(236)
hold on
contour(D, d, funk, [0.1 0.08 0.06 0.04 0.02], "ShowText","on")
m1 = contour(D, d, c1, [0 0], 'b--', LineWidth=1);
contour(D, d, c2, [0 0], 'm-', LineWidth=1);
m3 = contour(D, d, c3, [0 0], 'c--', LineWidth=1);
m4 = contour(D, d, c4, [0 0], 'r--', LineWidth=1);
contour(D, d, c5, [0 0], 'g--', LineWidth=1)

[x1, y1] = intersections(m1(1,2:end), m1(2,2:end), m3(1,2:end), m3(2,2:end));
[x2, y2] = intersections(m3(1,2:end), m3(2,2:end), m4(1,2:end), m4(2,2:end));
[x3, y3] = intersections(m1(1,2:end), m1(2,2:end), m4(1,2:end), m4(2,2:end));


fill([x1 x2 x3],[y1 y2 y3],'r', FaceAlpha=0.1, LineStyle='none')

contour(D, d, c1, -0.005*[1 2 3], 'b--')
contour(D, d, c2, -0.02*[1 2 3], 'm-')
contour(D, d, c3, -0.02*[1 2 3], 'c--')
contour(D, d, c4, -0.01*[1 2 3], 'r--')
contour(D, d, c5, -0.01*[1 2 3], 'g--')
legend('mass (kg)', 'L_{min}', 'F_{1, min}', 'F_{2, min}', '\tau _{1,2, max}', 'Freq_{1, lb}', 'feasble region')
xlabel('D (m)'), ylabel('d (m)'), title('      Contours of objective function (kg)')
grid



