clear all; clc;

funcao = @(x) sin(x).^2 - cos(x).^2 - tan(x/2);
x = 0:0.01:10;

x1 = fzero(funcao, 0);
x2 = fzero(funcao, 1);

fprintf('A raiz da função é aproximadamente: %.4f\n', x1);
fprintf('A raiz da função é aproximadamente: %.4f\n', x2);

figure;
plot(x, funcao(x), 'b-', 'LineWidth', 2);
xlim([0 10]);
ylim([-2 2]);
