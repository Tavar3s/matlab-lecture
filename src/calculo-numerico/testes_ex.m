% Dados de entrada
x = [2, 4, -1, 5, 10];
y = [10, 15, -2, 20, 40];

% Vetor para traçar as curvas contínuas
x_plot = linspace(min(x)-1, max(x)+1, 100);

% Equações dos polinômios encontrados
P0 = 16.6 * ones(size(x_plot));
P1 = 3.7878 * x_plot + 1.4485;
P2 = 0.0377 * x_plot.^2 + 3.4380 * x_plot + 1.7462;

% Plotagem
figure;
plot(x, y, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', 'Dados Experimentais'); 
hold on; grid on;
plot(x_plot, P0, 'r--', 'LineWidth', 1.5, 'DisplayName', 'P_0(x) (Média)');
plot(x_plot, P1, 'b-.', 'LineWidth', 1.5, 'DisplayName', 'P_1(x) (Linear)');
plot(x_plot, P2, 'g-', 'LineWidth', 2, 'DisplayName', 'P_2(x) (Quadrático)');

% Formatação visual
legend('Location', 'northwest');
title('Aproximação Polinomial por Mínimos Quadrados');
xlabel('x'); ylabel('y');