function [indexes, centroids] = c_means(data, k)
    [centroids, U] = fcm(data, k, [1.05, 50, 10^(-3), false]);
    maxU = max(U);
    for i = 1:k
        idx = find(U(i,:) == maxU);
        indexes(idx, 1) = i;
    end
end

