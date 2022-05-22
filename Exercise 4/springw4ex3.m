% Two variable valve spring problem - Exercise 4.1
% 1. Visualization of UNCONSTRAINED spring stiffnes and frequency
% optimization problem
% 2. Computation of steepest descent search direction
% 3. Line search using this search direction: hand controlled optimization cycles,
% including visualization.

% Initialization
clf, hold off
clear, clc
format long

% 1. Problem visualization
% Constant parameter values
springparams1;
w=1;
ktarget=10000;
frtarget=300;

% Matrix of output values for combinations of design variables D and d
D = 0.020:0.0005:0.040;
d = 0.002:0.00004:0.005;
for j=1:1:length(d)
    for i=1:1:length(D)
        %   Analysis of valve spring.
        [svol,smass,bvol,matc,manc,Lmin,L2,k,F1,F2,Tau1,Tau2,freq1]=...
            springanalysis1(D(i),d(j),L0,L1,n,E,G,rho,Dv,h,p1,p2,nm,ncamfac,nne,matp,bldp);
    	 % Scaled objective function
         fobj(j,i) = ((k-ktarget)/ktarget)^2 + w*((freq1-frtarget)/frtarget)^2;
         stiffness(j,i) = k;
         freq(j,i) = freq1;
    end
end

% Contour plot of scaled spring optimization problem
%contour(D, d, fobj,[0:0.05:0.2 0.2:0.1:0.5 0.5:0.5:2 2:5:100])
cc = [0.01 0.02 0.05];
contour(D, d, fobj,[cc 10*cc 100*cc 1000*cc 10000*cc 100000*cc 1000000*cc])
xlabel('Coil diameter D (m)'), ylabel('Wire diameter d (m)'), ...
    title('Exercise 4.3     Spring stiffness and frequency optimization problem (w = 1.0)')
hold on
contour(D,d,stiffness,[10000 10000], 'r--')
contour(D,d,freq,[300 300], 'g-.')
grid


% Initial design point:
x0 = [0.022  0.0035];
LB = [0.02 0.002];
UB = [0.04 0.005];
opt1 = optimset('Display', 'iter', 'HessUpdate', 'bfgs');
opt2 = optimset('Display', 'iter', 'HessUpdate', 'steepdesc', 'MaxFunEval', 1e4, DiffMinChange=1e-6);
% opt2 = optimset('Display', 'iter', 'HessUpdate', 'steepdesc', 'MaxFunEval', 1e4, 'FiniteDifferenceStepSize', 1e-6);


[x1, f1] = fminunc(@(x) s_objw43(x, ktarget, frtarget, w), x0, opt1);
[x2, f2] = fminunc(@(x) s_objw43(x, ktarget, frtarget, w), x0, opt2);
 
% Visualisation of line search in problem contour plot:
plot(x0(1),x0(2),'o');
plot([x0(1) x1(1)],[x0(2) x1(2)],x1(1),x1(2),'o');
plot([x0(1) x2(1)],[x0(2) x2(2)],x2(1),x2(2),'o');

legend('f_{obj}', 'stiffness', 'frequency', 'x_0', 'BFGS direction', 'BFGS minimum', 'steepdesc direction', 'steepdesc minimum')


