clear all; clc
addpath('src/problens_of_mechatronic/Projeto 2/functions'); % Adiciona o diretório 'funcoes' ao caminho do MATLAB

% Condições iniciais
k_min = 30000; % Constante elástica mínima (N/m)
b = 0.15; % Constante para cálculo de k na posição i
delta_k = (70 + 0.2*76)*1000; % Variação da constante elástica (N/m) (70 + dois últimos dígitos do número USP do aluno)

% Caso particular 1 - Força de 50 N aplicada na última posição (N) e nenhuma força aplicada nas outras posições
n_1 = 30; % Número de nós da estrutura


% Montagem da matriz de força para o caso 1
matriz_forca_1 = zeros(n_1, 1);
matriz_forca_1(n_1) = 50; % Força livre aplicada na última posição (N)

[matriz_rigidez_1, k_1] = matriz_de_rigidez(n_1, k_min, delta_k, b); % Matriz de rigidez para o caso 1
deslocamento_1 = matriz_rigidez_1\matriz_forca_1; % Deslocamento calculado para o caso 1

% Caso particular 2 - Força de 100 N aplicada na última posição (N) e força de -50 N aplicada na posição n/2 (N), e nenhuma força aplicada nas outras posições
n_2 = 10; % Número de nós da estrutura

% Montagem da matriz de força para o caso 2
matriz_forca_2 = zeros(n_2, 1);
matriz_forca_2(n_2) = 100; % Força livre aplicada na última posição (N)
matriz_forca_2(n_2/2) = -50; % Força livre aplicada na posição n/2 (N)

[matriz_rigidez_2, k_2] = matriz_de_rigidez(n_2, k_min, delta_k, b); % Matriz de rigidez para o caso 2
deslocamento_2 = matriz_rigidez_2\matriz_forca_2; % Deslocamento calculado para o caso 2

% Montagem dos gráficos de deslocamento para os casos 1 e 2
% Gráfico de deslocamento para o caso 1
figure;
plot(1:n_1, deslocamento_1, '*-', 'LineWidth', 2);
title('Deslocamento - Caso 1');
xlabel('Posição');
ylabel('Deslocamento');

% Gráfico de deslocamento para o caso 2
figure;
plot(1:n_2, deslocamento_2, '*-', 'LineWidth', 2);
title('Deslocamento - Caso 2');
xlabel('Posição');
ylabel('Deslocamento');

% Gráficos de constante elástica para o caso 1
figure;
plot(1:n_1, k_1, '*-', 'LineWidth', 2);
title('Constante Elástica - Caso 1');
xlabel('Posição');
ylabel('Constante Elástica');

% Gráficos de constante elástica para o caso 2
figure;
plot(1:n_2, k_2, '*-', 'LineWidth', 2);
title('Constante Elástica - Caso 2');
xlabel('Posição');
ylabel('Constante Elástica');
