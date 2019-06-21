function [ indexes, centroids, vrc ] = k_means( data, k )
%K_MEANS Aplica o algoritmo k-means sobre um conjunto de dados.

centroids = data(randsample(size(data, 1), k), :);
new_centroids = ones(k, size(data, 2)) * inf;
indexes = ones(size(data, 1), 1);

centroid_ratio = inf;

% Enquanto os centroides estiverem a uma distancia considerável
while centroid_ratio > 0.001
    % Calcula distância entre os dados e cada um dos centroides
    dists = zeros(size(data, 1), k);
    for i=1:k
        c = centroids(i, :);
        dists(:, i) = sum((data - c) .^ 2, 2);
    end
    
    % Atribui classe de acordo com o centroide mais proximo
    [~, indexes] = min(dists, [], 2);
    for i=1:k
        samples = data(indexes == i, :);
        new_centroids(i, :) = mean(samples);
    end
    
    centroid_ratio = sum(sum((centroids - new_centroids) .^ 2));
    centroids = new_centroids;
end

% Calcula VRC

% Variância entre clusters
B = 0;
for i=1:k
    c = centroids(i, :);
    n = sum(indexes == i);
    d = sum((c - mean(data)) .^ 2);
    B = B + n * d;
end
B = B / (k - 1);

% Variância dentro dos clusters
W = 0;
for i=1:k
    c = centroids(i, :);
    samples = data(indexes == i, :);
    W = W + sum(sum((samples - c) .^ 2));
end
W = W / (size(data, 1) - k);

vrc = B / W;

end

