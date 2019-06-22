clear; close all force; clc;
rng(3);

BASE = 2;

if BASE == 1
    centers = [1 1 1; 1 3 2; 3 3 3; 4 4 4];
    data = repmat(centers, 40, 1) + 0.4 * randn(160, 3);
    all_classes = repmat([1; 2; 3; 4], 40, 1);
else
    CLASSES = 10;
    ATRIBUTOS = 64;
    base = csvread('training.csv');
    all_classes = base(:, size(base, 2)) + 1;
    [~, data] = pca(base);
end

numTests = 10;
cluster = 0;
VRC = zeros(numTests, 1);

for k = 1:numTests
    [idx, c, vrc] = k_means(data, k);
    
    VRC(k) = vrc;
    if vrc >= max(VRC)
        centroid = c;
        indexes = idx;
        cluster = k;
    end
    fprintf('K = %d, VRC = %.2f\n', k, vrc);
end

if BASE == 1
    figure, scatter3(data(:, 1), data(:, 2), data(:, 3), 10, indexes);
    title("Divisão em " + cluster + " clusters.");
else
    visualizacao_pca(base(:, 1:ATRIBUTOS), all_classes, CLASSES);
end

hold on, scatter3(centroid(:, 1), centroid(:, 2), centroid(:, 3), 80, 's', 'black', 'MarkerFaceColor', 'green');

% Plot dos VRC por iteracao
figure, plot(1:numTests, VRC, '--bo');
hold on, plot(cluster, VRC(cluster), 'ro', 'MarkerFaceColor', 'red');
title('Valores de VRC');
legend('Valores de VRC', 'Máximo VRC');
xlabel('Valores de K');
ylabel('VRC');

% Calculo de acuracia
hits = all_classes == indexes;
fprintf('Acurácia = %.2f%%\n', 100 * nnz(hits) / length(hits));