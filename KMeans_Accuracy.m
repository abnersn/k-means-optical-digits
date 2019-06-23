clear; close all force; clc;
rng(1);

CLASSES = 10;
ATRIBUTOS = 64;

data = csvread('training.csv');

all_classes = data(:, size(data, 2)) + 1;
all_features = data(:, 1:ATRIBUTOS);
% all_features = PCA(data(:, 1:ATRIBUTOS), 0.8);
% all_features = zscore(data(:, 1:ATRIBUTOS));

[idx, centroids] = k_means(all_features, CLASSES, false, all_classes);
idx = map_indexes(CLASSES, idx, centroids, all_features, all_classes);
hits = all_classes == idx;
fprintf('Acurácia = %.2f%%\n', 100 * nnz(hits) / length(hits));
