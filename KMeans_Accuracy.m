clear; close all force; clc;
rng(1);
%% Definições da base
CLASSES = 10;
ATRIBUTOS = 64;

data = csvread('training.csv');

all_classes = data(:, size(data, 2)) + 1;
all_features = data(:, 1:ATRIBUTOS);

%% Encontrando o K (número de cluster) ideal pelo VRC e Largura de Silhueta
range_tests = 5:12;

for i = range_tests
    j = find(range_tests == i);
    
    [idx, c] = k_means(all_features, i);
    VRC_KM(j) = VRC(all_features, c, idx);
    S_KM(j) = mean(silhouette(all_features, idx));
    
    [idx, c] = c_means(all_features, i);
    VRC_CM(j) = VRC(all_features, c, idx);
    S_CM(j) = mean(silhouette(all_features, idx));
end

%% Plotagem dos valores de VRC e SWC para cada número de clusters testado no K-Means e no C-Means
[~, id] = max(VRC_KM);
K_VRC_KM = range_tests(id);
figure, plot(range_tests, VRC_KM, '--bo');
hold on, plot(K_VRC_KM, VRC_KM(id), 'ro', 'MarkerFaceColor', 'red');
title('Valores de VRC do K-Means');
legend('Valores de VRC', 'Máximo VRC');
xlabel('Valores de K');
ylabel('VRC');

[~, id] = max(S_KM);
K_S_KM = range_tests(id);
figure, plot(range_tests, S_KM, '--ro');
hold on, plot(K_S_KM, S_KM(id), 'ko', 'MarkerFaceColor', 'black');
title('Valores de Largura de Silhueta Médio (SWC) do K-Means');
legend('Valores de SWC', 'Máxima SWC', 'Location', 'southeast');
xlabel('Valores de K');
ylabel('SWC');

fprintf('---K-Means:\n');
fprintf('VRC = %d clusters.\nSWC = %d clusters.\n\n', K_VRC_KM, K_S_KM);

[~, id] = max(VRC_CM);
K_VRC_CM = range_tests(id);
figure, plot(range_tests, VRC_CM, '--bo');
hold on, plot(K_VRC_CM, VRC_CM(id), 'ro', 'MarkerFaceColor', 'red');
title('Valores de VRC do C-Means');
legend('Valores de VRC', 'Máximo VRC');
xlabel('Valores de K');
ylabel('VRC');

[~, id] = max(S_CM);
K_S_CM = range_tests(id);
figure, plot(range_tests, S_CM, '--ro');
hold on, plot(K_S_CM, S_CM(id), 'ko', 'MarkerFaceColor', 'black');
title('Valores de Largura de Silhueta Médio (SWC) do C-Means');
legend('Valores de SWC', 'Máxima SWC', 'Location', 'southeast');
xlabel('Valores de K');
ylabel('SWC');

fprintf('---C-Means:\n');
fprintf('VRC = %d clusters.\nSWC = %d clusters.\n', K_VRC_CM, K_S_CM);

%% K-Means e cálculo de acurácia
[idx, centroids] = k_means(all_features, CLASSES);
idx = map_indexes(CLASSES, idx, centroids, all_features, all_classes);

hits = all_classes == idx;
fprintf('K-Means - Acurácia = %.2f%%\n', 100 * nnz(hits) / length(hits));

%% C-Means e cálculo de acurácia
[idx, centroids] = c_means(all_features, CLASSES);
idx = map_indexes(CLASSES, idx, centroids, all_features, all_classes);

hits = all_classes == idx;
fprintf('C-Means - Acurácia = %.2f%%\n', 100 * nnz(hits) / length(hits));