clear all; clc
%addpath("src\problens_of_mechatronic\Projeto 1\functions") % Acabou nem sendo usado

% Condições iniciais
l1_inicial = 0.5; % Comprimento da mola 1 (m)
k_inicial = 15000; % Constante elástica (N/m)
m = 200 + 76; % Massa total (kg) (200 + dois ´ultimos d´ıgitos do n´umero USP do aluno)
d = 0.2; % Distância horizontal entre as molas (m)
g = 9.81; % Aceleração da gravidade (m/s^2)

% l1 = sqrt(d^2 + h^2)
% l2 = sqrt((2*d)^2 + h^2)

% Primeira parte: Analisar pontos de equilíbrio do sistema a partir da função fy, com fzero

h_inicial = sqrt(l1_inicial^2 - d^2); % Altura inicial do sistema (m)
l2_inicial = sqrt((2*d)^2 + h_inicial^2); % Comprimento da mola 2 (m)

l1 = @(u) sqrt(d^2 + (h_inicial - u)^2); % Comprimento da mola 1 em função de u
forca_mola1 = @(u, k) k * (l1_inicial - l1(u))*(h_inicial - u)/l1(u); % Força da mola 1

l2 = @(u) sqrt((2*d)^2 + (h_inicial - u)^2); % Comprimento da mola 2 em função de u
forca_mola2 = @(u, k) k * (l2_inicial - l2(u))*(h_inicial - u)/l2(u); % Força da mola 2

fy = @(u, k) 2* forca_mola1(u, k) + 2*forca_mola2(u, k) - m * g;

% Gera o gráfico da função fy e marca os pontos onde fy é zero
figure
fplot(@(u) fy(u, k_inicial), [-0.4, 1.2], 'LineWidth', 2); % Gera gráfico da função fy
hold on;
plot(fzero(@(u) fy(u, k_inicial), 0.1), 0, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 7); % Marca o ponto onde fy é zero próximo de 0.1
text(fzero(@(u) fy(u, k_inicial), 0.1) + 0.02, -1000, 'Ponto 1', 'Color', 'r');
hold on;
plot(fzero(@(u) fy(u, k_inicial), 0.4), 0, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 7); % Marca o ponto onde fy é zero próximo de 0.4
text(fzero(@(u) fy(u, k_inicial), 0.4) + 0.02, 1000, 'Ponto 2', 'Color', 'r');
hold on;
plot(fzero(@(u) fy(u, k_inicial), 1.0), 0, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 7); % Marca o ponto onde fy é zero próximo de 1.0
text(fzero(@(u) fy(u, k_inicial), 1.0) + 0.02, -1000, 'Ponto 3', 'Color', 'r');
hold on;
yline(0, 'r--', 'LineWidth', 1.5);
% Configurações do gráfico 1
xlabel('Deslocamento da variável u (m)');
ylabel('Força Resultante (N)');
grid on;

% Encontrar os pontos onde fy é zero usando fzero
raizes = [fzero(@(u) fy(u, k_inicial), 0.1), fzero(@(u) fy(u, k_inicial), 0.4), fzero(@(u) fy(u, k_inicial), 1.0)];

% Segunda parte do trabalho: Determinar a equação analítica de keq e verificar 
% os valores próximos aos pontos de equilíbrio encontrados

% Declarando u como variável simbólica
syms u_sym;

% Reescrevendo os comprimentos 
l1_sym = sqrt(d^2 + (h_inicial - u_sym)^2);
l2_sym = sqrt((2*d)^2 + (h_inicial - u_sym)^2);

% Forças simbólicas das molas
F1y_sym = k_inicial * (l1_inicial - l1_sym) * (h_inicial - u_sym) / l1_sym;
F2y_sym = k_inicial * (l2_inicial - l2_sym) * (h_inicial - u_sym) / l2_sym;

% Força restauradora total das molas
F_molas_sym = 2 * F1y_sym + 2 * F2y_sym;

% Derivando para encontrar a equação analítica de keq
keq_equacao = diff(F_molas_sym, u_sym);
keq_simplidicado = simplify(keq_equacao);
keq_simplidicado = simplify(keq_simplidicado);

% Converte a expressão simbólica em uma função que o MATLAB pode calcular e plotar
keq_plotavel = matlabFunction(keq_equacao);

k_1 = double(subs(keq_equacao, u_sym, raizes(1))); % Substituindo o valor de u próximo ao ponto de equilíbrio encontrado
k_2 = double(subs(keq_equacao, u_sym, raizes(2))); % Substituindo o valor de u próximo ao ponto de equilíbrio encontrado
k_3 = double(subs(keq_equacao, u_sym, raizes(3))); % Substituindo o valor de u próximo ao ponto de equilíbrio encontrado

k_eq_nas_raizes = [k_1, k_2, k_3]; % Organizando os valores de keq próximos aos pontos de equilíbrio encontrados

% Gerar o gráfico da rigidez efetiva keq em função de u
figure;
fplot(keq_plotavel, [0, 1.2], 'LineWidth', 2, 'Color', 'b');
hold on;
plot(raizes, k_eq_nas_raizes, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 7); % Marca os pontos de equilíbrio encontrados
grid on;
xlabel('Deslocamento u (m)');
ylabel('Rigidez Efetiva k_{eq} (N/m)');

% Para a parte 3, vamos investigar a influência de k
% se seu valor é aumentado ou diminuído em 50%
k_aumentado = 1.5 * k_inicial; % 22500 N/m
k_diminuido = 0.5 * k_inicial; % 7500 N/m

% Gerar gráficos para k aumentado e diminuído
figure
fplot(@(u) fy(u, k_aumentado), [-0.4, 1.2], 'LineWidth', 2, 'Color', 'y'); % Gráfico para k aumentado
hold on;
fplot(@(u) fy(u, k_diminuido), [-0.4, 1.2], 'LineWidth', 2, 'Color', 'g'); % Gráfico para k diminuído
hold on;
fplot(@(u) fy(u, k_inicial), [-0.4, 1.2], 'LineWidth', 2, 'Color', 'b'); % Gráfico para k inicial
yline(0, 'r--', 'LineWidth', 1.5); % Linha em y = 0
text(-0.39, 1250, 'y = 0', 'Color', 'r','FontSize', 9);
yline(-m*g, 'k--', 'LineWidth', 1.5); % Linha em y = -m*g
text(-0.39, -m*g*0.5, 'y = -m*g', 'Color', 'k','FontSize', 9);
plot(0, -m*g, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 7); % Marca o ponto onde u = 0 e fy = -m*g
hold on;
plot(h_inicial, -m*g, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 7); % Marca o ponto onde u = h_inicial e fy = -m*g
hold on;
plot(2*h_inicial, -m*g, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 7); % Marca o ponto onde u = 2*h_inicial e fy = -m*g
% Configurações do gráfico 2
grid on;
xlabel('Deslocamento da variável u (m)');
ylabel('Força Resultante (N)');
legend('k aumentado (22,5 kN/m)', 'k diminuído (7,5 kN/m)', 'k inicial (15 kN/m)');

% Encontrar os pontos onde fy é zero usando fzero
raizes_k_aumentado = [fzero(@(u) fy(u, k_aumentado), 0.1), fzero(@(u) fy(u, k_aumentado), 0.4), fzero(@(u) fy(u, k_aumentado), 1.0)];

% Encontrar os pontos onde fy é zero usando fzero
raizes_k_diminuido = [fzero(@(u) fy(u, k_diminuido), 0.1), fzero(@(u) fy(u, k_diminuido), 0.4), fzero(@(u) fy(u, k_diminuido), 1.0)];
