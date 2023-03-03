% number of relay server
r = [1 2 3 4 5 6 7 8];

%figure(1)
%plot(r, lbd, 'o')
% lambda max if the relay server are all AF
%lbd = 2*0.9.^(r+1);



lbd_max = zeros(size(r));
for i = 1:length(r)
    lbd_max(i) = lbd_2(r(i));
end

figure(2)
plot(r, lbd_max, 'o')
ylim([0,2])

% lambda max with hop-by-hop ARQ
figure(3)
lbd_max_hop = 0.9;
plot(r, lbd_max_hop, 'o')

% lambda max with end-to-end-arq
function lbd_max = lbd_2(r)
    lbd_max = 1;
    for j = 1:(r+1)
        lbd_max = lbd_max - 0.1*(0.9)^(j-1);
    end
end



