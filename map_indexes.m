function [ new_idx ] = map_indexes( k, idx, centroids, data, classes )
%MAP_INDEXES Mapeia os �ndices do k-means �s classes correspondentes.
% Essa fun��o corrige os �ndices retornados pelo k-means de forma n�o
% supervisionada, para que eles correspondam � classe mais pr�xima do
% dataset.
available_centroids = 1:k;
idx_map = [1:k; 1:k]';
for i=1:k
    km_centroid = centroids(i, :);
    closest_distance = inf;
    closest_centroid = -1;
    for j=available_centroids
        real_centroid = mean(data(classes == j, :));
        dist = sum((real_centroid - km_centroid) .^ 2);
        if dist < closest_distance
            closest_centroid = j;
            closest_distance = dist;
        end
    end
    idx_map(i, 2) = closest_centroid;
    available_centroids(available_centroids == closest_centroid) = [];
end

new_idx = idx;
for i=1:length(idx)
    new_idx(i) = idx_map(idx(i), 2);
end

end

