function [ indexes, centroids, vrc ] = k_means( data, k )
    % K_MEANS Aplica o algoritmo k-means sobre um conjunto de dados.
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
            dists(:, i) = sum((data - c) .^ 2, 2); % Distancias entre os dados e o centroide do cluster i
        end

        % Atribui classe de acordo com o centroide mais proximo
        [~, indexes] = min(dists, [], 2);
        for i=1:k
            samples = data(indexes == i, :); % Amostras do cluster i
            new_centroids(i, :) = mean(samples); % Nova media do cluster i
        end
        % Diferença entre novos centroides e centroides anteriores
        centroid_ratio = sum(sum((centroids - new_centroids) .^ 2));
        centroids = new_centroids;
        
        numIter = numIter + 1;
    end
    fprintf('Número de Iterações: %d\n', numIter);
    
    %% VRC

    % Variancia entre clusters
    B = 0;
    for i=1:k
        c = centroids(i, :); % Centroide do cluster i
        n = sum(indexes == i); % Numero de amostras no cluster i
        d = sum((c - mean(data)) .^ 2); % Distancia do centroide do cluster i para a media dos dados
        B = B + n * d;
    end
    B = B / (k - 1);

    % Variancia dentro dos clusters
    W = 0;
    for i=1:k
        c = centroids(i, :); % Centroide do cluster i
        samples = data(indexes == i, :); % Amostras do cluster i
        W = W + sum(sum((samples - c) .^ 2));
    end
    W = W / (size(data, 1) - k);

    % Calculo do VRC
    vrc = B / W;
end
