addpath('src\functions');

% Exercício 3.1 do roteiro

u = 0; %input('Digite o valor de u: ');
v = 1; %input('Digite o valor de v: ');

resultado31 = funcaoEx1(u, v);

fprintf('O resultado da função 1 é: %.4f\n', resultado31);

% Exercício 3.2 do roteiro

b = 1; %input('Digite o valor de b: ');
g = 1; %input('Digite o valor de g: ');
n = pi; %input('Digite o valor de n: ');

resultado32 = funcaoEx2(b, g, n);

fprintf('O resultado da função 2 é: %.4f\n\n', resultado32);

% Exercício 3.5 do roteiro

matriz = [3 5 6 7 2 3 5 6 7 10 0];

matriz_t = matriz';

disp(max(matriz_t));
disp(min(matriz_t));
disp(sum(matriz_t)/(length(matriz_t)-1));
disp(sum(matriz_t));

% Exercício 3.6 do roteiro

A = [2 3; 4 -1];
B = [5; 7];

solucoes = A \ B;

x = solucoes(1);
y = solucoes(2);

produto = x * y;

fprintf('O produto de x e y é: %.4f\n', produto);
fprintf('O valor de x é: %.4f\n', x);
fprintf('O valor de y é: %.4f\n', y);

% Exercício 3.10 do roteiro

x = 0:10;
k = 10;

mola_linear = k * x;
mola_nao_linear = k * (x + x.^3);

figure;
plot(x, mola_linear, 'b-', 'LineWidth', 2);
hold on;
plot(x, mola_nao_linear, 'r--', 'LineWidth', 2);
xlabel('Deslocamento (x)');
ylabel('Força (F)');
title('Comparação entre mola linear e não linear');
