clear; close all force; clc;
rng(3);

%% Escolha da base
BASE = 2;

if BASE == 1
    tam_base = 120;
    centers = [1 1 1; 1 3 2; 3 3 3; 4 4 4];
    data = repmat(centers, 30, 1) + 0.4 * randn(tam_base, 3);
    all_classes = repmat([1; 2; 3; 4], 30, 1);
else
    CLASSES = 10;
    ATRIBUTOS = 64;
    base = csvread('training.csv');
    tam_base = size(base, 1);
    all_classes = base(:, size(base, 2)) + 1;
%     [~, data] = pca(base);
    
end

numTests = 10;
% VRC = zeros(numTests, 1);

for k = 1:numTests
    [~, ~, vrc, ~] = k_means(data, k, false, all_classes);
    
    VRC(k) = vrc;
%     if vrc >= max(VRC)
%         num_cluster = k;
%     end
    fprintf('K = %d, VRC = %.2f\n', k, vrc);
end
[~, num_cluster] = max(VRC);
fprintf('Divisão em %d clusters.', num_cluster);
% Plot dos VRC por iteracao
figure, plot(1:numTests, VRC, '--bo');
hold on, plot(num_cluster, VRC(num_cluster), 'ro', 'MarkerFaceColor', 'red');
title('Valores de VRC');
legend('Valores de VRC', 'Máximo VRC');
xlabel('Valores de K');
ylabel('VRC');

%% Teste
if BASE == 1
    num_cluster = 4;
    [idx, centroid, ~, expected_classes] = k_means(data, num_cluster, true, all_classes);
    figure, scatter3(data(:, 1), data(:, 2), data(:, 3), 10, idx);
else
    num_cluster = 10;
    visualizacao_pca(base(:, 1:ATRIBUTOS), all_classes, CLASSES);
    [idx, centroid, ~, expected_classes] = k_means(data, num_cluster, true, all_classes);
end

hold on, scatter3(centroid(:, 1), centroid(:, 2), centroid(:, 3), 80, 's', 'black', 'MarkerFaceColor', 'green');

% Calculo de acuracia
hits = all_classes == expected_classes;
fprintf('Acurácia = %.2f%%\n', 100 * nnz(hits) / length(hits));