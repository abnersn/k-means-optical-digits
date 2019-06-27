function [indexes, centroids] = c_means(data, k)
    % C_MEANS faz a chamada da rotina do MATLAB para execução do algoritmo
    % Fuzzy C-Means com os parâmetros que empiricamente foram considerados
    % bons, e retorna os centróides dos cluster e a qual cluster cada
    % amostra pertence.
    [centroids, U] = fcm(data, k, [1.05, 50, 10^(-3), false]);
    maxU = max(U);
    for i = 1:k
        idx = find(U(i,:) == maxU);
        indexes(idx, 1) = i;
    end
end

