% Initialization
clf, hold off, clear

% Design point for which gradients are computed 
x = [0.020522 0.003520];

% Forward finite diffence gradients of objective function and constraints
hxi = 1e-8;

% Objective function
fx = springobj1(x);
fx1plush = springobj1([x(1)+hxi, x(2)]);
fx2plush = springobj1([x(1), x(2)+hxi]);
dfdx1 = (fx1plush - fx)/hxi;
dfdx2 = (fx2plush - fx)/hxi;

% Constraints 
gx = springcon1(x);
gx1plush = springcon1([x(1)+hxi, x(2)]);
gx2plush = springcon1([x(1), x(2)+hxi]);
dgdx1 = (gx1plush - gx)./hxi;
dgdx2 = (gx2plush - gx)./hxi;

% solve for lagrangian multipliers
dg = [dgdx1(2:4); dgdx2(2:4)];
df = [dfdx1; dfdx2];
mu = linsolve(dg,-df);
mu = [0; mu; 0];

 