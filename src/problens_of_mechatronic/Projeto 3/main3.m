clear all; clc

% Condições iniciais do sistema
syms s real
r = 100; % Raio em metros (m)
n = 76; % Dois números finais do NUSP
v0 = 20 + 0.35*sqrt(n); % Velocidade inicial em metros por segundo (m/s)
at = @(s) 4 + 0.01*n*s - 0.01*s^2 + exp(-s/n); % Aceleração tangencial em metros por segundo ao quadrado (m/s^2)

s_num = 28.5; % Posição para avaliação dos casos 1 e 2
s_num2 = 21.5; % Posição para avaliação do caso 3

% Funções de integração de uma variável disponíveis no MATLAB
% 1. trapz: Método do trapézio
% 2. integral: Integração numérica usando quadratura adaptativa (recom
% 3. int: Integração simbólica

% Calcula a integral indefinida e subtrai o valor dela no ponto 0 
% para representar a integral definida de 0 a s
integral_at = int(at(s), s) - subs(int(at(s), s), s, 0); 

% Nova função da velocidade baseada na cinemática correta
v_s = sqrt(v0^2 + 2 * integral_at); 
v_s_num = matlabFunction(v_s);

figure;
ylim([0, 60]); % Define os limites do eixo y para melhor visualização
fplot(v_s_num, [0, 140], 'LineWidth', 2);
hold on;
plot(s_num, v_s_num(s_num), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'DisplayName', 'Ponto s = 28.5 m');
offset_x = -1.5; % Ajuste fino horizontal
offset_y = -2; % Ajuste fino vertical
text(s_num - offset_x, v_s_num(s_num) + offset_y, sprintf('  v(%.1f) = %.2f m/s', s_num, v_s_num(s_num)), ...
    'VerticalAlignment', 'bottom', ...
    'HorizontalAlignment', 'left', ...
    'FontSize', 10, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', 'w', ... 
    'EdgeColor', 'k');
ylabel('Velocidade v (m/s)');
xlabel('Deslocamento s (m)', 'Interpreter', 'latex', 'FontSize', 12);
grid on;
grid minor; % Adiciona uma grade mais fina, excelente para gráficos de engenharia
box on;

% Cálculo do módulo da aceleração em componentes tangencial e normal e s = 28.5 m
at_num = matlabFunction(at(s)); % Converter a função simbólica para uma função numérica

a = @(x) sqrt(at_num(x)^2 + (v_s_num(x)^2 / r)^2); % Módulo da aceleração

figure; 
fplot(a, [0, 140], 'b-', 'LineWidth', 2, 'DisplayName', 'Aceleração Resultante a(s)');
hold on;
plot(s_num, a(s_num), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'DisplayName', 'Ponto s = 28.5 m');
offset_x = 1.5; % Desloca um pouco para a direita
offset_y = 1.5; % Desloca um pouco para baixo

text(s_num + offset_x, a(s_num) - offset_y, sprintf('a(%.1f) = %.2f m/s^2', s_num, a(s_num)), ...
    'VerticalAlignment', 'top', ...      % Fixa o topo do texto perto do ponto
    'HorizontalAlignment', 'left', ...   % Fixa o lado esquerdo do texto perto do ponto
    'FontSize', 10, ...
    'FontWeight', 'bold', ...
    'BackgroundColor', 'w', ... 
    'EdgeColor', 'k');        
% Configuração de Eixos e Títulos utilizando o interpretador LaTeX
xlabel('Deslocamento s (m)');
ylabel('Aceleração a (m/s²)');
grid on;
grid minor; % Adiciona uma grade mais fina, excelente para gráficos de engenharia
box on;

% Cálculo do tempo gasto para percorrer a distância s = 21.5 m
intervalo = linspace(0, s_num2, 1000); % Cria 1000 pontos de 0 até 21.5
v = v_s_num(intervalo);    % Calcula a velocidade em cada ponto s

% Para achar o TEMPO, integramos 1/v
t = trapz(intervalo, 1./v);
