function montagem_graficos(t_out, x_out)
    % Monta os gráficos de posição, velocidade e fase
    figure;
    plot(t_out, x_out(:,1), 'b', 'LineWidth', 2);
    grid on;
    xlabel('Tempo (s)');
    ylabel('Posição (m)');
    
    figure;
    plot(t_out, x_out(:,2), 'b', 'LineWidth', 2);
    grid on;
    xlabel('Tempo (s)');
    ylabel('Velocidade (m/s)');
    
    figure;
    plot(x_out(:,1), x_out(:,2), 'b', 'LineWidth', 2);
    grid on;
    xlabel('Posição (m)');
    ylabel('Velocidade (m/s)');
end