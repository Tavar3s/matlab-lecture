clear all; clc

f = @(x, y) x.^2 + 3.*y;
x = linspace(-10, 10, 100);
y = linspace(-10, 10, 100);
[X, Y] = meshgrid(x, y);

figure;
surf(X, Y, f(X, Y));
xlabel('x');
ylabel('y');
grid on;

t = linspace(-10, 10, 100);

x_t = t;
y_t = sqrt(abs(t));
f_gama = f(x_t, y_t);

figure;
plot(t, f_gama, 'b-', 'LineWidth', 2.5);
grid on;
