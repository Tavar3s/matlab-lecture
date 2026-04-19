% Análise do Teorema de Contração de Banach para k_inicial
% Encontrar os limites máximo e mínimo para k_inicial

clear all; clc;

addpath('src\functions');

% Função original de aula2.m
f = @(x) cos(x) + cos(2*x);

% Derivada de f(x) = cos(x) + cos(2*x)
% f'(x) = -sin(x) - 2*sin(2*x)
f_derivada = @(x) -sin(x) - 2*sin(2*x);

% Para o método de ponto fixo x_{n+1} = g(x_n), a convergência é garantida se:
% |g'(x)| <= k < 1, onde k é a constante de contração

% Vamos analisar em um intervalo razoável
x = linspace(0, 2*pi, 1000);
derivadas = f_derivada(x);
abs_derivadas = abs(derivadas);

% Encontrar máximo e mínimo de |f'(x)|
k_minimo = min(abs_derivadas);
k_maximo = max(abs_derivadas);

fprintf('=== TEOREMA DE CONTRAÇÃO DE BANACH ===\n');
fprintf('Função: f(x) = cos(x) + cos(2*x)\n');
fprintf('Derivada: f''(x) = -sin(x) - 2*sin(2*x)\n\n');

fprintf('ANÁLISE NO INTERVALO [0, 2π]:\n');
fprintf('k_inicial MÍNIMO (menor valor de |f''(x)|): %.6f\n', k_minimo);
fprintf('k_inicial MÁXIMO (maior valor de |f''(x)|): %.6f\n', k_maximo);
fprintf('\n');

% Verificar convergência
fprintf('VALIDAÇÃO PARA CONVERGÊNCIA:\n');
if k_maximo < 1
    fprintf('✓ CONVERGENTE: |f''(x)| < 1 em todo intervalo\n');
    fprintf('  Constante de contração k pode estar em (%.6f, %.6f)\n', k_minimo, k_maximo);
else
    fprintf('✗ NÃO CONVERGENTE em todo intervalo\n');
    fprintf('  |f''(x)| atinge valores >= 1\n');
end

fprintf('\n');

% Encontrar os valores de x onde ocorrem os extremos
[~, idx_max] = max(abs_derivadas);
[~, idx_min] = min(abs_derivadas);

x_maximo = x(idx_max);
x_minimo = x(idx_min);

fprintf('Posições dos extremos:\n');
fprintf('  Máximo ocorre em x ≈ %.6f rad ≈ %.2f°\n', x_maximo, x_maximo*180/pi);
fprintf('  Mínimo ocorre em x ≈ %.6f rad ≈ %.2f°\n', x_minimo, x_minimo*180/pi);

% Visualização
figure();
subplot(2,1,1);
plot(x, derivadas, 'b-', 'LineWidth', 2);
hold on;
plot(x, ones(size(x)), 'r--', 'LineWidth', 2, 'DisplayName', 'k=1 (limite)');
plot(x, -ones(size(x)), 'r--', 'LineWidth', 2);
xlabel('x (radianos)');
ylabel('f''(x)');
title('Derivada de f(x) = cos(x) + cos(2*x)');
legend('f''(x)', 'limites de convergência');
grid on;

subplot(2,1,2);
plot(x, abs_derivadas, 'g-', 'LineWidth', 2);
hold on;
plot(x, ones(size(x)), 'r--', 'LineWidth', 2, 'DisplayName', 'k=1 (limite)');
plot(x_maximo, k_maximo, 'ro', 'MarkerSize', 10, 'DisplayName', sprintf('k_máx = %.4f', k_maximo));
plot(x_minimo, k_minimo, 'bo', 'MarkerSize', 10, 'DisplayName', sprintf('k_mín = %.4f', k_minimo));
xlabel('x (radianos)');
ylabel('|f''(x)|');
title('Valor absoluto da derivada - Região de Convergência');
legend();
grid on;

fprintf('\nGráficos gerados!\n');
