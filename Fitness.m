%clear all; close all; clc

function sum_score = Fitness(x, n_sensor)
m = 120; n = 80;
[i j] = meshgrid(1:m,1:n);

% Define attenuation coefficient beta
beta = 0.5*0.08686; % Assume 1 Np/m = 0.08686 dB/cm

% For PZT

% For greedy, activate line 13-14 ; deactivate line 18-31
%x = [m n];
n_sensor = length(x)/2;

% For random search, activate line 18 to 31; deactivate line 1
% For GA/SA/PSO/PS, activate line 3,14,18 ; deactivate line 1, and 93-100
global ns; ns = n_sensor;
%n_sensor = 1;
%x_sensor = randi([1 m],1,n_sensor); y_sensor = randi([1 n],1,n_sensor);

for u = 1:n_sensor
    %x(2*u-1) = x_sensor(u); x(2*u) = y_sensor(u);
end

for S = 1:n_sensor
    r_pzt{S} = sqrt((i-x(2*S-1)).^2 + (j-x(2*S)).^2);
    alpha_{S} = 1./sqrt(r_pzt{S});
    r1_pzt{S} = alpha_{S}.*r_pzt{S}.*exp(-beta.*r_pzt{S});
end

rsum_pzt = sum(cat(3,r1_pzt{:}),3);

% Hotspot

r_hotspot = [45 40 80 40];

for H = 1:(length(r_hotspot)/2)
    r2_pzt{H} = sqrt((i-r_hotspot(2*H-1)).^2 + (j-r_hotspot(2*H)).^2);
    alpha2_{H} = 1./sqrt(r2_pzt{H});
    r3_pzt{H} = alpha2_{H}.*r2_pzt{H}.*exp(-beta.*r2_pzt{H});
end

rsum_hotspot = sum(cat(3,r3_pzt{:}),3);
rsum_hotspot = 0;

% Boundaries

b = [70 30 70 40 70 50];
n_boundaries = length(b)/2;

for B = 1:n_boundaries
    r_boundaries{B} = sqrt((i-b(2*B-1)).^2 + (j-b(2*B)).^2);
    for S = 1:n_sensor
        if rsum_hotspot == 0
            r_boundaries{B} = r_pzt{S} + r_boundaries{B};
        else
            r_boundaries{B} = r_pzt{S} + r2_pzt{H} + r_boundaries{B};
        end
    end
    alpha_b{B} = 1./sqrt(r_boundaries{B});
    r1_boundaries{B} = alpha_b{B}.*r_boundaries{B}.*exp(-beta.*r_boundaries{B});
end

rsum_boundaries = sum(cat(3,r1_boundaries{:}),3);

for B = 1:n_boundaries
    rsum_boundaries(b(2*B),b(2*B-1)) = 0;
end

% Total score

%rsum_boundaries = 0; rsum_pzt = 0;
%rsum_hotspot = 0; % Activate for global SHM only, deactivate for integrated approach
total_score = rsum_pzt + rsum_boundaries + rsum_hotspot;

if rsum_boundaries >= 0
    for B = 1:n_boundaries
        total_score(b(2*B),b(2*B-1)) = 0;
    end
end

if rsum_hotspot ~= 0
    for H = 1:(length(r_hotspot)/2)
        total_score(r_hotspot(2*H),r_hotspot(2*H-1)) = 0;
    end
end

total_score(isnan(total_score)) = 0;
total_score = mat2gray(total_score);
sum_score = -100.*sum(total_score(:))./(m*n);

% Figure

%fig = imagesc(1:m,1:n,total_score); caxis([0 1]);
%fig = surfc(1:m,1:n,total_score); caxis([0 1]);
%fig = gcf; fig.Color = [1 1 1]; fig.Position = [500, 250, 900, 600];
%colormap(flipud(jet)) ; set(colorbar,'Fontsize',16) ; axis xy ; axis equal tight;
%title({['Network Score: ', num2str(1*sum_score)]},'FontSize',24);
%xlabel('X-Coordinate [cm]','FontSize',16) ; ylabel('Y-Coordinate [cm]','FontSize',16);

end