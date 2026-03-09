A = [3 1; 0 4];

x = rand(2, 1);

teste_1 = A^100 * x / norm(A^100 * x, 'inf');

% Podemos delimitar o resultado para um erro desejado
erro = 1;

lambda_velho = x'*A*x / (x'*x); % Estimativa inicial do autovalor dominante (Coeficiente de Rayleigh)

figure(1); hold on;
while erro > 1e-10
    x = A * x / norm(A * x, 'inf'); 
    lambda_novo = x'*A*x / (x'*x);
    erro = abs(lambda_novo - lambda_velho);
    lambda_velho = lambda_novo;

    plot(x(1), x(2), '*'); pause(0.1);
end

disp(lambda_velho); % O autovalor gerado é dominante, ou seja, o maior em valor absoluto
disp(x);

if norm(A*x - lambda_velho*x) > 1e-10 % Conferindo se o vetor x é autovetor de A
    disp('Possível erro na convergência');
end

% 3 caso de autovalores
% Se é real e único absoluto -> Converge para o autovetor dominante
% Se é real e não único absoluto -> Converge de maneira errada
% Se é complexo -> Não converge

% para (A + cI)v => (lambda + c)v
% para A^-1v => (1/lambda)v
