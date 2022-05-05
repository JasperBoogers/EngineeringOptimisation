clc; clear; close;


% Assignment of constant design parameter values
springparams1;

% Assignment of unconstant design parameter values
Tau12max = 600e6;
Freq1lb = 1;

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
    c3(j,i) = (F2min - F2)/F2min;
    c4(j,i) = (Tau2 - Tau12max)/Tau12max;
    c5(j,i) = (Freq1lb - freq1)/Freq1lb;
    c6a(j,i) = (D(i) - 0.04)/0.04;
    c6b(j,i) = (0.02 - D(i))/0.02;
    c7a(j,i) = (d(j) - 0.005)/0.005;
    c7b(j,i) = (0.002 - d(j))/0.002; 

  end
end

% Contour plot of objective function: mass
% subplot(221)
hold on
contour(D, d, funk, [0.1 0.08 0.06 0.04 0.02], '--', "ShowText","on")
contour(D, d, c1, [0 -0.1], 'b-')
contour(D, d, c2, [0 -0.1], 'm-')
contour(D, d, c3, [0 -0.1], 'c-')
contour(D, d, c4, [0 -0.1], 'r-')
contour(D, d, c5, [0 -0.1], 'g-')
legend('mass', 'c1', 'c2', 'c3', 'c4', 'c5')
xlabel('D (m)'), ylabel('d (m)'), title('      Contours of objective function (kg)')
grid




