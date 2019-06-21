rng(3);

centers = [1 1 1; 1 3 2; 3 3 3; 4 4 4];
data = repmat(centers, 40, 1) + 0.4 * randn(160, 3);

[idx, c, vrc] = k_means(data, 4);

fprintf('VRC = %.2f\n', vrc);

scatter3(data(:, 1), data(:, 2), data(:, 3), 2, idx);
hold on;
scatter3(c(:, 1), c(:, 2), c(:, 3), 'x', 'black');