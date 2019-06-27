function [indexes, centroids] = k_means(data, k)
    % K_MEANS Aplica o algoritmo K-Means sobre um conjunto de dados.
    %% K-Means
    % Inicializacao das variaveis
    r = randsample(size(data, 1), k);
    centroids = data(r, :); % Escolhe k centros dentre as amostras da base aleatoriamente
    new_centroids = ones(k, size(data, 2)) * inf;
    indexes = ones(size(data, 1), 1); % Cluster mais proximo de cada amostra da base

    centroid_ratio = inf;

    numIter = 0;
    
    % Enquanto os centroides estiverem a uma distancia consideravel
    while centroid_ratio > 0.001
        % Calcula distancia entre os dados e cada um dos centroides
        dists = zeros(size(data, 1), k);
        for i=1:k
            c = centroids(i, :); % Centroides do cluster i
            dists(:, i) = sqrt(sum((data - c) .^ 2, 2)); % Distancias entre os dados e o centroide do cluster i
        end

        % Atribui classe de acordo com o centroide mais proximo
        [~, indexes] = min(dists, [], 2);
        for i=1:k
            samples = data(indexes == i, :); % Amostras do cluster i
            new_centroids(i, :) = mean(samples); % Nova media do cluster i
        end
        % Diferença entre novos centroides e centroides anteriores
        centroid_ratio = sum(sqrt(sum((centroids - new_centroids) .^ 2)));
        centroids = new_centroids;
        
        numIter = numIter + 1;
    end
%     fprintf('Número de Iterações: %d\n', numIter);
end
