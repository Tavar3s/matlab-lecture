function valor = funcaoDerivada(f, k)
    h = 0.0001;
    valor = (f(k +h) - f(k))/h;
end