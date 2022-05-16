xq = [0.022 0.004];
Sq1 = [0.002 0.0];
Sq2 = [0.0 -0.0005];
Sq3 = [0.002 -0.0005];
kt = 1e4; % N/m
ft = 300; % Hz
w=1;
lb = [0.02 0.002];
ub = [0.04 0.005];

lb1 = (0.02 - xq(1))/Sq1(1);
ub1 = (0.04 - xq(1))/Sq1(1);
a1 = fminbnd(@(a) springobjw3(a, xq, Sq1, kt, ft, w), lb1, ub1);
f1 = springobjw3(a1, xq, Sq1, kt, ft, w)

lb2 = (0.002 - xq(2))/Sq2(2);
ub2 = (0.005 - xq(2))/Sq2(2);
a2 = fminbnd(@(a) springobjw3(a, xq, Sq2, kt, ft, w), ub2, lb2);
f2 = springobjw3(a2, xq, Sq2, kt, ft, w)

lb3 = (0.002 - xq(2))/Sq3(2);
ub3 = (0.02 - xq(1))/Sq3(1);

a3 = fminbnd(@(a) springobjw3(a, xq, Sq3, kt, ft, w), ub3, lb3);
f2 = springobjw3(a3, xq, Sq3, kt, ft, w)