function [s,t] = calc_length(a, b, y)

% load parameters
load_param;

eq = [sin(a) -sin(b);
    cos(a) cos(b)];
g = [y; ST];
res = linsolve(eq,g);

s = res(1);
t = res(2);
end

