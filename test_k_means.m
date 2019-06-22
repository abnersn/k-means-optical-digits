rng(3);

centers = [1 1 1; 1 3 2; 3 3 3; 4 4 4];
data = repmat(centers, 40, 1) + 0.4 * randn(160, 3);
numTests = 10;
cluster = 0;
VRC = zeros(numTests, 1);

for k = 1:numTests
    [idx, c, vrc] = k_means(data, k);
    
    VRC(k) = vrc;
    if vrc >= max(VRC)
        centroide = c;
        indices = idx;
        cluster = k;
    end
    fprintf('K = %d, VRC = %.2f\n', k, vrc);
end

figure, scatter3(data(:, 1), data(:, 2), data(:, 3), 2, indices);
hold on, scatter3(centroide(:, 1), centroide(:, 2), centroide(:, 3), 'x', 'black');
title("Divisão em " + cluster + " clusters.");


figure, plot(1:numTests, VRC, '--bo');
hold on, plot(cluster, VRC(cluster), 'ro', 'MarkerFaceColor', 'red');
title('Valores de VRC');
legend('Valores de VRC', 'Máximo VRC');
