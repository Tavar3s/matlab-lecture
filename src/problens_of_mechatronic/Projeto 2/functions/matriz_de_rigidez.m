function [K, k] = matriz_de_rigidez(n, k_min, delta_k, b)
    % Inicializa a matriz de rigidez
    K = zeros(n, n);
    k = zeros(n, 1); % Inicializa a matriz de constantes elásticas

    for i = 1:n
        k(i) = k_min + delta_k*exp(-b*i); % Calcula a constante elástica para cada posição i
    end

    for i = 1:n
        if i == n
            K(i, i) = k(i); % Último elemento da diagonal
        else
            K(i, i) = k(i) + k(i+1); % Elemento da diagonal
            K(i, i+1) = -k(i+1); % Elemento acima da diagonal
            K(i+1, i) = -k(i+1); % Elemento abaixo da diagonal
        end
    end
end