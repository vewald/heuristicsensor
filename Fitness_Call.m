%clear all; close all; clc

function fval = Fitness_Call(ns)
%ns = 4;
m = 120; n = 80; nvars = 2.*ns;
A = []; b = []; Aeq = []; beq = [];
LB = ones(1,nvars); UB = diag(repmat([m n],nvars));
nonlcon = []; IntCon = 1:nvars;
ObjectiveFunction = @Fitness;

tic
% Genetic Algorithm
[x,fval] = ga(ObjectiveFunction,nvars,A,b,Aeq,beq,LB,UB,nonlcon,IntCon);
options = optimoptions('ga', 'CrossoverFcn', 'crossoversinglepoint', 'MigrationDirection', 'both', 'MaxStallGenerations', 800, 'PopulationSize', 1600, 'ConstraintTolerance', 1e-24, 'FunctionTolerance', 1e-36);

% Particle Swarm
%[x,fval] = particleswarm(ObjectiveFunction,nvars,LB,UB)

% SA and Pattern Search (Note: activate x0 as well)
%x_sensor = randi([1 m],1,ns); y_sensor = randi([1 n],1,ns);
for u = 1:ns
    %x0(2*u-1) = x_sensor(u); x0(2*u) = y_sensor(u);
end

%[x,fval] = simulannealbnd(ObjectiveFunction,x0,LB,UB)
%[x,fval] = patternsearch(ObjectiveFunction,x0,A,b,Aeq,beq,LB,UB,nonlcon)

%c = toc;

sol = [-1.*fval toc round(x)]
end