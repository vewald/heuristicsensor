clear all; close all; clc;

for ns = 1:6;
log_iter = [1 5];

for n = 1:length(log_iter)
    tic
    for iter = 1:log_iter(n)
        dist(iter) = Fitness_Call(ns);
    end
    data(n,1) = mean(dist); data(n,2) = max(dist); data(n,3) = std(dist); data(n,4) = toc;
end

%data = reshape(round(data',length(log_iter)),1,[])

end