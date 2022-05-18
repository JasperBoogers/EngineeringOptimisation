clear

xq = [0.022 0.004];

kt = 1e4; % N/m
ft = 300; % Hz
w=1;

Sq1 = [0.002 0.0];
Sq2 = [0.0 -0.0005];
Sq3 = [0.002 -0.0005];
sq = [Sq1; Sq2; Sq3];

lb1 = (0.02 - xq(1))/Sq1(1);
lb2 = (0.005 - xq(2))/Sq2(2);
lb3 = (0.02 - xq(1))/Sq3(1);
lb = [lb1, lb2, lb3];

ub1 = (0.04 - xq(1))/Sq1(1);
ub2 = (0.002 - xq(2))/Sq2(2);
ub3 = (0.002 - xq(2))/Sq3(2);
ub = [ub1, ub2, ub3];

a = zeros(3,1);
f = zeros(3,1);
x = zeros(3,2);



for i = 1:3
 a(i) = fminbnd(@(a) springobjw3(a, xq, sq(i,:), kt, ft, w), lb(i), ub(i));
 f(i) = springobjw3(a(i), xq, sq(i,:), kt, ft, w);
 x(i,:) = xq + a(i)*sq(i,:);
end


% rerun for different tolerances
opt1 = optimset('Display', 'iter', 'tolX', 1.0e-4);
opt2 = optimset('Display', 'iter', 'tolX', 1.0e-8);


a_1 = fminbnd(@(a) springobjw3(a, xq, sq(2,:), kt, ft, w), lb(i), ub(2), opt1);
f_1 = springobjw3(a_1, xq, sq(2,:), kt, ft, w);
x_1 = xq + a_1*sq(2,:);

format long;
a_2 = fminbnd(@(a) springobjw3(a, xq, sq(2,:), kt, ft, w), lb(i), ub(2), opt2);
f_2 = springobjw3(a_2, xq, sq(2,:), kt, ft, w);
x_2 = xq + a_2*sq(2,:);

a_res = [a_1; a_2; abs(a_2-a_1)]
f_res = [f_1; f_2; abs(f_2-f_1)]
x_res = [x_1; x_2; abs(x_2-x_1)]'