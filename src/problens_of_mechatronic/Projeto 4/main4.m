clear all; clc;

% Informações iniciais do sistema
m = 1; % Massa da partícula (kg)
n = 76; % Final do Número USP
r_theta = @(theta) 0.3 .* (2 + cos(theta)); % Raio como função do ângulo
v = @(t) 0.025*(155 + n)*(175 - t)*1e-3; % Velocidade como função do tempo (m/s)

% Derivadas para a ODE

dr_theta = @(theta) -0.3 .* sin(theta); % Derivada do raio em relação ao ângulo
dtheta_dt = @(t, theta) v(t) ./ sqrt(r_theta(theta).^2 + dr_theta(theta).^2); % Derivada do ângulo em relação ao tempo

[t_res, theta_res] = ode45(dtheta_dt, [0, 100], 0); % Resolvendo a ODE para obter theta(t)
r_res = r_theta(theta_res); % Calculando o raio correspondente a cada theta

% Apresentar a Tragetória da Partícula

theta_trajetoria = linspace(0, 2*pi, 5000); % Criando o vetor de ângulos para a trajetória (0 a 2*pi com 500 pontos)
r_trajetoria = r_theta(theta_trajetoria); % Calculando o raio específico para essa trajetória geométrica

% Convertendo para coordenadas cartesianas (X e Y)
x_traj = r_trajetoria .* cos(theta_trajetoria);
y_traj = r_trajetoria .* sin(theta_trajetoria);

% Resgatando tempo em que a partícula completa 3 voltas (6*pi radianos)

indice_3_voltas = find(theta_res >= 6*pi, 1);
tempo_3_voltas = t_res(indice_3_voltas);

%---------------------------------------------------- FIGURAS ----------------------------------------------------

figure;
% 'b-' cria uma linha azul contínua; LineWidth aumenta a espessura
plot(t_res, theta_res, 'b-', 'LineWidth', 2.5); 
grid on;
% Nomeando os eixos e o título do gráfico
xlabel('Tempo t (s)'); 
ylabel('\theta (rad)'); % O MATLAB entende comandos como \theta para criar a letra grega

figure;
% 'b-' cria uma linha azul contínua; LineWidth aumenta a espessura
plot(t_res, dtheta_dt(t_res, theta_res), 'b-', 'LineWidth', 2.5); 
grid on;
% Nomeando os eixos e o título do gráfico
xlabel('Tempo t (s)'); 
ylabel('d\theta/dt (rad/s)'); % O MATLAB entende comandos como \theta para criar a letra grega

figure;
% 'b-' cria uma linha azul contínua; LineWidth aumenta a espessura
plot(t_res, r_res, 'b-', 'LineWidth', 2.5); 
grid on;
ylim([0.2, 1]);
% Nomeando os eixos e o título do gráfico
xlabel('Tempo t (s)'); 
ylabel('r (m)'); % O MATLAB entende comandos como \theta para criar a letra grega

figure;
% 'b-' cria uma linha azul contínua; LineWidth aumenta a espessura
plot(t_res, v(t_res), 'b-', 'LineWidth', 2.5); 
grid on;
% Nomeando os eixos e o título do gráfico
xlabel('Tempo t (s)'); 
ylabel('v (m/s)'); % O MATLAB entende comandos como \theta para criar a letra grega

figure;
% 'b-' cria uma linha azul contínua; LineWidth aumenta a espessura
plot(theta_res, dtheta_dt(t_res, theta_res), 'b-', 'LineWidth', 2.5); 
grid on;
% Nomeando os eixos e o título do gráfico
xlabel('\theta (rad)'); 
ylabel('d\theta/dt (rad/s)'); % O MATLAB entende comandos como \theta para criar a letra grega

% Plotando a trajetória limpa
figure;
plot(x_traj, y_traj, 'b-', 'LineWidth', 2.5);
grid on;
axis equal; % Mantém a proporção real do limaçon
ylim([-0.8, 0.8]);
xlabel('Posição X (m)');
ylabel('Posição Y (m)');
