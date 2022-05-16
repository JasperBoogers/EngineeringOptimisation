% Two variable valve spring problem - Exercise 3.1
% Visualization of SCALED spring stiffnes and frequency 
% optimization problem

% Initialization
clf, hold off, clear

% Constant parameter values
springparams1;
w=1;
ktarget=10000; 
frtarget=300;

% Matrix of output values for combinations of design variables D and d 
D = [0.020:0.0005:0.040];
d = [0.002:0.00004:0.005];
for j=1:1:length(d)
  for i=1:1:length(D)
%   Analysis of valve spring.
    [svol,smass,bvol,matc,manc,Lmin,L2,k,F1,F2,Tau1,Tau2,freq1]=...
    springanalysis1(D(i),d(j),L0,L1,n,E,G,rho,Dv,h,p1,p2,nm,ncamfac,nne,matp,bldp);
 	 % Scaled objective function
     fobj(j,i) = abs((k-ktarget)/ktarget) + w*abs((freq1-frtarget)/frtarget);
     stiffness(j,i) = k;
     freq(j,i) = freq1;
  end
end

% Contour plot of scaled spring optimization problem
%contour(D, d, fobj,[0:0.05:0.2 0.2:0.1:0.5 0.5:0.5:2 2:5:100])
cc = [0.01 0.02 0.05];
contour(D, d, fobj,[cc 10*cc 100*cc 1000*cc 10000*cc 100000*cc 1000000*cc], "ShowText","on")
xlabel('Coil diameter D (m)'), ylabel('Wire diameter d (m)'), ...
   title('Figure 1: Spring stiffness and frequency optimization problem for w = 1.0')
hold on
contour(D,d,stiffness,[10000 10000], 'r--')
contour(D,d,freq,[300 300], 'g-.')
legend('fobj', ' stiffness', ' freq')
grid

x_q = [0.022 0.004];

a = 4;
S_q1 = a*[0.002 0.0];
S_q2 = a*[0.0 -0.0005];
S_q3 = a*[0.002 -0.0005];

plot(x_q(1), x_q(2), 'k*')
line([x_q(1) x_q(1)+S_q1(1)], [x_q(2) x_q(2)+S_q1(2)]);
line([x_q(1) x_q(1)+S_q2(1)], [x_q(2) x_q(2)+S_q2(2)]);
line([x_q(1) x_q(1)+S_q3(1)], [x_q(2) x_q(2)+S_q3(2)]);

%end 