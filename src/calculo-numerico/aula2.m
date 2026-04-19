% Aplicação do método de Newton para encontrar raízes de funções e resolver sistemas de equações não lineares.

clear all; clc;

addpath('src\functions');

f = @(x) cos(x) + cos(2*x);
f_derivada = @(x) -sin(x) - 2*sin(2*x);

k_inicial = pi/4;

for i = 1:10 % Método de Newton para interar e achar raiz
    k_inicial = k_inicial - f(k_inicial)/funcaoDerivada(f, k_inicial);
end

disp(k_inicial*180/pi);



g = @(x, y) 20*y + 20*x + x*y - 1000;
h = @(x, y) 1.5*y - x;

vetor_init = [20; 20];

for i = 1:10
    J = [20 + vetor_init(2), 20 + vetor_init(1); -1, 1.5];
    F = [g(vetor_init(1), vetor_init(2)); h(vetor_init(1), vetor_init(2))];
    
    vetor_init = vetor_init - J\F;
end

disp(vetor_init);