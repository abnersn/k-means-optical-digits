function [vrc] = VRC(data, centroids, indexes)
    % VRC calcula o Variance Ratio Criterion dos clusters gerados, para
    % avaliacao posterior de qualidade do agrupamento.
    
    % Referencias
    % http://datamining.rutgers.edu/publication/internalmeasures.pdf
    % https://www.mathworks.com/help/stats/clustering.evaluation.calinskiharabaszevaluation-class.html
    
    %% VRC
    k = size(centroids, 1);
    
    % Variancia entre clusters
    B = 0;
    for i=1:k
        c = centroids(i, :); % Centroide do cluster i
        n = sum(indexes == i); % Numero de amostras no cluster i
        d = sqrt(sum((c - mean(data)) .^ 2)); % Distancia do centroide do cluster i para a media dos dados
        B = B + n * d;
    end
    B = B / (k - 1);

    % Variancia dentro dos clusters
    W = 0;
    for i=1:k
        c = centroids(i, :); % Centroide do cluster i
        samples = data(indexes == i, :); % Amostras do cluster i
        W = W + sum(sqrt(sum((samples - c) .^ 2)));
    end
    W = W / (size(data, 1) - k);

    % Calculo do VRC
    vrc = B / W;
end
