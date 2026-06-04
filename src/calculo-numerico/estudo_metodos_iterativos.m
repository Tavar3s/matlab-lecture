clear all; clc

% Método de potência
a = [2 -1; 1 4];
x = [1; 1];

for i = 1:150
    x = a * x;
    x = x / norm(x);
end

mp = x;

% Teorema do Ponto Fixo de Banach
% Este teorema garante a existência e unicidade de um ponto fixo para uma função contrátil em um espaço completo.

% Iteração de Newton-Raphson para encontrar a raiz da função f(x) = x^3 - 2*x^2 + 1
x = 10;

f = @(x) x^3 - 2*x^2 + 1;
df = @(x) 3*x^2 - 4*x;

for i = 1:100
    x = x - f(x) / df(x);
end

figure
fplot(f, [-10 10])
grid on

% Iteração por Secantes

x1 = 10;
x2 = 9;

f = @(x) 6*x - x^3;

while abs(f(x2)) > 1e-6
    x3 = x2 - f(x2) * (x2 - x1) / (f(x2) - f(x1));
    x1 = x2;
    x2 = x3;
end

figure
fplot(f, [-10 10])
grid on

% Método iterativo linear para resolver o sistema de equações x_k+1 = Ax_k + b
% Tem que garantir que |x_n+1 - x_n|^k -> 0 para convergência

f = @(x) x^3 - 2*x^2 + 1;
g = @(x) (2*x^2 - 1)^(1/3);

x = 1.5;

for i = 1:100
    x = g(x);
end

figure
fplot(f, [1/sqrt(2) 3])
hold on
fplot(g, [1/sqrt(2) 3])
grid on

% Metodo de Jacobi para resolver o sistema de equações lineares Ax = b -> x = D^(-1) * (b - (L + U) * x)
A = [5 -1 3; -6 8 -1; 2 -1 4];
b = [15; 10; 10];
x = zeros(3, 1);

D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);

% Iteração de Jacobi
for i = 1:100
    x = D \ (b - (L + U) * x);
end

% Método de Gauss-Seidel para resolver o sistema de equações lineares Ax = b -> x = (D - L)^(-1) * (b - U * x)

for i = 1:100
    x = (D - L) \ (b - U * x);
end

% Método de Picard para PVI (Mesma ideia da Série de Taylor, mas com integração ao invés de derivação)
syms xs t y_prev;

% Defina a ED0: dy/dx = f(x, y)
% Exemplo: dy/dx = x + y
fs(xs, y_prev) = xs + y_prev; 

% Condições Iniciais: y(x0) = y0
x0 = 0;
y0 = 1;

% Número de iterações desejadas
num_iteracoes = 4;

% --- EXECUÇÃO DO MÉTODO DE PICARD ---
% Aproximação inicial (y0)
y(1) = sym(y0); 

fprintf('Aproximação y_0(x) = %s\n', char(y(1)));

% Laço de repetição para as aproximações sucessivas
for n = 1:num_iteracoes
    % Substitui y na função pelo resultado da iteração anterior
    % Mudamos a variável x para t para realizar a integração de x0 a x
    f_sub = subs(fs(t, y_prev), y_prev, subs(y(n), xs, t));
    
    % Aplica a fórmula de recorrência de Picard
    y(n+1) = y0 + int(f_sub, t, x0, xs);
    
    % Simplifica a expressão resultante
    y(n+1) = simplify(y(n+1));
    
    % Exibe o resultado da iteração atual
    fprintf('Aproximação y_%d(x) = %s\n', n, char(y(n+1)));
end
