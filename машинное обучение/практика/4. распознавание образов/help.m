function [J, S] = help(C, X, Y, lyambda)

  G = C;
  G(1) = 0;

  m = length(Y);
  a = (-1.0 / m);           %'скорость' спуска
  b = lyambda / (2.0 * m);  %коэффициент регуляризации

  J = 0;
  S = zeros(size(C));
  H = 1 ./ (1 + exp(-X * C)); %сигмоида

  h1 = [Y; 1 - Y].';
  h2 = [log(H); log(1 - H)];

  J = J + a * h1 * h2 + b * sum(G.^2);        %а это частная производная по C от S(C)..
  S = S + a * X' * (Y - H) + 2 * lyambda * G; %правило, по которому мы вычисляем (целевую?) функцию S(C)..
  S = S(:);

end
