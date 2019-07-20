clear all
close all
clc

syms x_d y_d
x = xlsread('Localization.xlsx','B27:G27');
t = xlsread('Localization.xlsx','P27:Q27');
x = x./100;
dx = sym(zeros(6,1));
v = 5300;
t_1 = t(1)*1e-6;
t_2 = t(2)*1e-6;

for i = 1:3
   dx(2*i-1) = x(2*i-1) - x_d;
   dx(2*i) = x(2*i) - y_d; 
end

eqn1 = sqrt(dx(1).^2 + dx(2).^2) + sqrt(dx(3).^2 + dx(4).^2) == v*t_1;
eqn2 = sqrt(dx(1).^2 + dx(2).^2) + sqrt(dx(5).^2 + dx(6).^2) == v*t_2;
eqns = [eqn1 eqn2];
vars = [x_d y_d];
[solv, solu] = solve(eqns, vars);
round(double(solv)*100)
round(double(solu)*100)