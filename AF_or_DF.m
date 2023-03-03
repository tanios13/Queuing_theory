%% AF or DF
p =linspace(0.05,0.95,1000);
r = 4;

%% Lambda max
%% System 1
lbd_max_1 = 2*(1-p).^(r+1);

figure(1)
plot(p, lbd_max_1)
hold on;

%% System 2
lbd_max_2 = zeros(size(p));
for i = 1:length(p)
    lbd_max_2(i) = lbd_2(r,p(i));
end
plot(p, lbd_max_2)

%% System 3
lbd_max_3 = 1 - p;
plot(p, lbd_max_3)
hold off;


%% System 1
p_e2e = 1 - (1-p).^(r+1);

T = (r+1)./(2 * (1 - p_e2e) - 0.5*lbd_max_1);

figure(2)
plot(p,T)
hold on;

%% System 2
% compute lbd_1 for each x (x being lambda)
lbd_1_values = zeros(size(p));
for i = 1:length(p)
    lbd_1_values(i) = lbd_1(lbd_max_2(i) * 0.5,r,p(i));
end

average_delay_values = zeros(size(p));
for i = 1:length(p)
    average_delay_values(i) = average_delay(lbd_max_2(i)*0.5,lbd_1_values(i),r,p(i));
end

plot(p,average_delay_values)

%% System 3
lbd_1_h = (0.5*lbd_max_3)./(1-p);
avg_n_1 = lbd_1_h./(1-lbd_1_h);

lbd_j_h = (0.5*lbd_max_3)./(1-p);
avg_n_j = lbd_j_h./(1-lbd_j_h);
total_avg_n_j = avg_n_j * (r-2);

lbd_r_1_h = (0.5*lbd_max_3)./(1-p);
avg_r_1_h = lbd_r_1_h./(2-lbd_r_1_h);

T_h = (1./(0.5*lbd_max_3)) .* (avg_n_1 + total_avg_n_j + avg_r_1_h);

plot(p, T_h)
ylim([0,200])
hold off;

%% Functions
% lambda max with end-to-end-arq
function lbd_max = lbd_2(r,p)
    lbd_max = 1;
    for j = 1:(r+1)
        lbd_max = lbd_max - p*(1 - p)^(j-1);
    end
end

% functions for System 2 average delay
function result = lbd_1(x,r,p)
    denominator = 1;
    for j = 1:r+1
        denominator = denominator - p * (1-p)^(j-1);
    end
    result = x/denominator;
end

function result = average_delay(x,lbd_1,r,p)
    result = 0;
    for j=1:r
        lbd_j = lbd_1*(1-p)^(j-1);
        result = result + lbd_j/(1-lbd_j);
    end
    lbd_r_1 = lbd_1*(1-p)^(r+1);
    result = result + lbd_r_1/(2-lbd_r_1);
    result = result/x;
end