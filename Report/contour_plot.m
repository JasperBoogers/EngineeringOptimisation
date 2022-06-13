%% init
clear
clf
clc
load_param

%% Decision variables
nd = 2;
max_v = 0.3;
min_v = 0.01;
p2y_r = linspace(min_v,max_v,nd);
p2y_l = linspace(min_v,max_v,nd);

p3y_r = linspace(min_v,max_v,nd);
p3y_l = linspace(min_v,max_v,nd);

c = zeros(nd,nd,nd,nd);

%% calculate beam lengts
tic
parfor i1=1:nd
    for i2=1:nd
        for i3=1:nd
            for i4=1:nd
                p2r = [nan, p2y_r(i1)];
                p3r = [p3x_r, p3y_r(i3)];
                
                p2l = [nan, p2y_l(i2)];
                p3l = [p3x_l, p3y_l(i4)];
                
                n = 5;
                st_f = linspace(0,1,n+2);
                st_f = st_f(2:end-1);
                [s_r, t_r, a0_r, b0_r, p2r] = calc_length(p2r, p3r, d_r_rt);
                [s_l, t_l, a0_l, b0_l, p2l] = calc_length(p2l, p3l, d_l_rt);
                a_r = [a0_r, zeros(1,n)];
                b_r = [b0_r, zeros(1,n)];
                a_l = [a0_l, zeros(1,n)];
                b_l = [b0_l, zeros(1,n)];
                
                for i = 1:n
                    [a_r(i+1), b_r(i+1)] = calc_angles(s_r,t_r, a_r(i), b_r(i), p2r, p3r, st_f(i));
                    [a_l(i+1), b_l(i+1)] = calc_angles(s_l,t_l, a_l(i), b_l(i), p2l, p3l, -st_f(i));
                end
                
                delta_r = abs(a_r(2:end) - a_r(1));
                delta_l = abs(a_l(2:end) - a_l(1));
                
                c(i1,i2,i3,i4) = obj_func(delta_r, delta_l,'right');
            end
        end
    end
    disp(i1)
end
toc
save('data_contour_2')

%% plot contour data
load('data_contour_2.mat')

figure(1); clf; hold on;
subplot(2,2,1)
contour(p2y_r, p2y_l, c(:,:,6,6), 'ShowText', 'on')
xlabel('p2y_r')
ylabel('p2y_l')

subplot(2,2,2)
contour(p3y_r, p2y_l, reshape(c(6,:,:,6),[12,12]), 'ShowText', 'on')
xlabel('p3y_r')
ylabel('p2y_l')

subplot(2,2,3)
contour(p2y_r, p3y_l, reshape(c(:,6,6,:),[12,12]), 'ShowText', 'on')
xlabel('p2y_r')
ylabel('p3y_l')

subplot(2,2,4)
contour(p3y_r, p3y_l, reshape(c(6,6,:,:),[12,12]), 'ShowText', 'on')
xlabel('p3y_r')
ylabel('p3y_l')

it = [1,2,3,4,5,6,7,8,9,10,11,12];

figure(2); clf; hold on;
subplot(2,2,1);
for i=it
    semilogy(p2y_l, c(i,:,i,i)); hold on
end
title('p2y_l')
legend(split(num2str(it)))

subplot(2,2,2);
for i=it
    semilogy(p2y_r, c(:,i,i,i)); hold on
end
title('p2y_r')

subplot(2,2,3);
for i=it
    semilogy(p3y_l, reshape(c(i,i,i,:),[1,nd])); hold on
end
title('p3y_l')

subplot(2,2,4);
for i=it
    semilogy(p3y_r, reshape(c(i,i,:,i),[1,nd])); hold on
end
title('p3y_r')
