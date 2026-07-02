function dxdt = eq_movimento(t, x, m, c, k, F)
    dxdt = zeros(2,1); % Cria o vetor coluna vazio
    dxdt(1) = x(2);    % A derivada da posição (dx1) é a velocidade (x2)
    dxdt(2) = (F - c * x(2) - k * x(1)) / m; % A derivada da velocidade (dx2) é a aceleração
end