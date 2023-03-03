% values for the 3 systems
x= linspace(0,0.9,1000);

r = 4;
p = 0.1;

%% AF end-to-end ARQ
% for p = 0.5
p_e2e = 0.96875;

T = (r+1)./(2 * (1 - p_e2e) - x);

%plot(x,T)
%xlim([0,0.6])

%% DF end-to-end ARQ

% compute lbd_1 for each x (x being lambda)
lbd_1_values = zeros(size(x));
for i = 1:length(x)
    lbd_1_values(i) = lbd_1(x(i),r,p);
end

average_delay_values = zeros(size(x));
for i = 1:length(x)
    average_delay_values(i) = average_delay(x(i),lbd_1_values(i),r,p);
end

%plot(x,average_delay_values)
%xlim([0,0.03])
%ylim([0,1000])

%% DF hop-by-hop
lbd_1_h = x./(1-p);
avg_n_1 = lbd_1_h./(1-lbd_1_h);

lbd_j_h = x./(1-p);
avg_n_j = lbd_j_h./(1-lbd_j_h);
total_avg_n_j = avg_n_j * (r-2);

lbd_r_1_h = x./(1-p);
avg_r_1_h = lbd_r_1_h./(2-lbd_r_1_h);

T_h = 1./x .* (avg_n_1 + total_avg_n_j + avg_r_1_h);

plot(x, T_h)
%xlim([0,0.2455])
ylim([0,200])

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