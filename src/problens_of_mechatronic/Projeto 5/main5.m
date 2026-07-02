clear all; clc
addpath('src/problens_of_mechatronic/Projeto 5/functions'); % Adiciona a pasta 'functions' ao caminho do MATLAB

% Parâmetros Iniciais
n = 76; % Últimos dois dígitos do NUSP
m = 2 + n/100; % Massa do corpo (kg)
x_0 = 0; % Posição inicial (m)
dx_0 = 10; % Velocidade inicial (m/s)

% Parâmetros da primeira parte do trabalho
k = 1000; % Constante elástica da mola (N/m)
t = 0:0.01:10; % Intervalo de tempo (s)

% 1. Sem amortecimento e f(t) = 0
c = 0;
F = 0;

[t_out, x_out] = ode45(@(t,x) eq_movimento(t, x, m, c, k, F), t, [x_0; dx_0]);

montagem_graficos(t_out, x_out);

% 2. Amortecimento de 5 N.s/m e f(t) = 0
c = 5;
F = 0;

[t_out, x_out] = ode45(@(t,x) eq_movimento(t, x, m, c, k, F), t, [x_0; dx_0]);

montagem_graficos(t_out, x_out);

% 3. Amortecimento de 5 N.s/m, w = 0.5*sqrt(k/m) e f(t) = 5sin(w*t)
c = 5;
w = 0.5 *sqrt(k/m);

[t_out, x_out] = ode45(@(t,x) eq_movimento(t, x, m, c, k, 5*sin(w*t)), t, [x_0; dx_0]);

montagem_graficos(t_out, x_out);

% 4. Amortecimento de 5 N.s/m, w = sqrt(k/m) e f(t) = 5sin(w*t) 
c = 5;
w = sqrt(k/m);

[t_out, x_out] = ode45(@(t,x) eq_movimento(t, x, m, c, k, 5*sin(w*t)), t, [x_0; dx_0]);

montagem_graficos(t_out, x_out);

% 5. Sem amortecimento, w = sqrt(k/m) e f(t) = 5sin(w*t) 
c = 0;
w = sqrt(k/m);

[t_out, x_out] = ode45(@(t,x) eq_movimento(t, x, m, c, k, 5*sin(w*t)), t, [x_0; dx_0]);

montagem_graficos(t_out, x_out);

% Segunda parte do trabalho - Testes de FFT e FRF
c = 5;
F = 0;
dx_0 = 1/2.76; % Velocidade inicial (m/s)
fs = 100; % Frequência de amostragem (Hz)

[t_out, x_out] = ode45(@(t,x) eq_movimento(t, x, m, c, k, F), t, [x_0; dx_0]);
X_w = fft(x_out(:, 1));
Y_w = abs(X_w);

N = length(X_w);
f = (0:N-1) * (fs/N);

figure;
plot(f, Y_w, 'b', 'LineWidth', 2);
grid on;
xlim([1 10]);
xscale('log');
xlabel('Frequência (Hz)');
ylabel('Magnitude');