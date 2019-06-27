clear; close all force; clc;
rng(1);

CLASSES = 10;
ATRIBUTOS = 64;

data = csvread('training.csv');

all_classes = data(:, size(data, 2)) + 1;
all_features = data(:, 1:ATRIBUTOS);

% [C, U] = fcm(all_features, CLASSES);
% maxU = max(U);
% index1 = find(U(1,:) == maxU);
% index2 = find(U(2,:) == maxU);
% index3 = find(U(3,:) == maxU);
% index4 = find(U(4,:) == maxU);
% index5 = find(U(5,:) == maxU);
% index6 = find(U(6,:) == maxU);
% index7 = find(U(7,:) == maxU);
% index8 = find(U(8,:) == maxU);
% index9 = find(U(9,:) == maxU);
% index10 = find(U(10,:) == maxU);
% idx_CM(index1, 1) = all_classes(index1(1));
% idx_CM(index2, 1) = all_classes(index2(1));
% idx_CM(index3, 1) = all_classes(index3(1));
% idx_CM(index4, 1) = all_classes(index4(1));
% idx_CM(index5, 1) = all_classes(index5(1));
% idx_CM(index6, 1) = all_classes(index6(1));
% idx_CM(index7, 1) = all_classes(index7(1));
% idx_CM(index8, 1) = all_classes(index8(1));
% idx_CM(index9, 1) = all_classes(index9(1));
% % idx_CM(index10, 1) = all_classes(index10(1));
% 
% % idx_CM_map = map_indexes(CLASSES, idx_CM, C, all_features, all_classes);
% hits = all_classes == idx_CM;
% fprintf('CM - Acurácia = %.2f%%\n', 100 * nnz(hits) / length(hits));

[idx, centroids] = k_means(all_features, CLASSES);
idx = map_indexes(CLASSES, idx, centroids, all_features, all_classes);
hits = all_classes == idx;
fprintf('KM - Acurácia = %.2f%%\n', 100 * nnz(hits) / length(hits));