function spherical_potential(l)

  clc;

  h = (6.6260755/2/pi) * 10^(-27); % постоянная Планка редуцированная
  m = 9.1093897 * 10^(-28);        % масса электрона (г)
  e = 4.803 * 10^(-10);            % заряд электрона (СГСЭ)
  coef = 1.602564*10^(-12);        % переводной коэфф-т (эрг -> эВ)

  %m*e^4/2/h^2/coef % энергия Ридберга * калибровка констант

  m = 0.205*m; % GaN (?)

  L = 5 * 10^(-7); % ширина ямы (см)
  a = L/1500;      % шаг (см)

  X = a:a:L;     % точки на оси X в яме
  M = length(X); % количество точек

  Veff = l*(l+1)./X.^2; % для электрона в сферической потенциальной яме




  % уравнение: -R'' - (2/r)R' + (l(l+1)/r^2)R = (k^2)R
  %       где: k^2 = 2mE/h^2

  % R ~ R(i) == R(X(i))
  % R' ~ [R(i+1) - R(i)]/a
  % R' ~ [R(i) - R(i-1)]/a
  % R'' ~ [R(i+1) - 2*R(i) + R(i-1)]/a^2

  % для аналитического решения уравнения
  % можно сделать замену R(r) = f(r)/r

  A_D1 = -ones(1, M-1)/a^2;            % нижняя побочная диагональ
  A_D2 = (2/a^2) + (2/a./X) + Veff;    % главная диагональ
  A_D3 = (-1/a^2) - (2/a./X(1:end-1)); % верхняя побочная диагональ

  A = diag(A_D1, -1) + diag(A_D2) + diag(A_D3, +1); % сборка матрицы оператора Гамильтона

  A *= h^2/2/m/coef; % сразу получаем ответ в эВ

  [A, B] = eig(A);        % поиск собственных значений и соответствующих им собственных векторов
  [B, I] = sort(diag(B)); % собственные значения найдены беспорядочно!
  A = A(:, I);            % и соответствующие им собственные вектора..
  A = abs(A).^2;          % плотность вероятности




  Y_wv = A(:, 1:3); % первые три состояния
  X *= 10^(7);      % см --> нм

  x_max = ceil(X(end));
  y_max = max(Y_wv(:));

  figure(1);
  clf;
  hold on;
  grid on;
  set(gca, 'fontsize', 14);
  ylabel('Плотность вероятности', 'fontsize', 18);
  xlabel('Ширина, нм', 'fontsize', 18);
  title(sprintf('Первые три состояния при l = %d', l), 'fontsize', 16);
  axis([0, x_max, 0, y_max]);
  plot(X, Y_wv(:, 1), 'r', "linewidth", 1.2);
  plot(X, Y_wv(:, 2), 'g', "linewidth", 1.2);
  plot(X, Y_wv(:, 3), 'b', "linewidth", 1.2);
  hold off;




  dE = 10^(-3);         % приращение по энергии
  E = dE:dE:(1.3*B(3)); % промежуток сравнения
  E *= coef;            % эВ --> эрг

  k = sqrt(2*m*E/h^2); % k^2 из уравнения на электрон в сферической потенциальной яме
  x = L * k;
  y = j_n(l, x);

  y_min = max([-0.5, min(y)]); % при l > 10 около нуля начинает происходить что-то страшное...
  y_max = min([+0.5, max(y)]);

  E /= coef; % эрг --> эВ

  figure(2);
  clf;
  hold on;
  set(gca, 'fontsize', 14);
  xlabel('Энергия, эВ', 'fontsize', 18);
  title('Сравнение корней/нулей аналитического решения (красная линия) с численным решением (синие кружки)', 'fontsize', 16);
  axis([0, E(end), y_min, y_max]);

  % сравнение численного решения с аналитикой через корни уравнения: jl(k*r0) = 0
  plot(E, y, 'r', "linewidth", 1.2);
  plot(B(1:3), [0, 0, 0], 'ob', "markersize", 10, "linewidth", 1.2);
  for i=1:3
    plot([B(i), B(i)], [y_min, y_max], '--b', "linewidth", 1.2);
    text(B(i) + 0.01, 0.9*y_max, sprintf('E_{%d} = %.4f эВ', i, B(i)), "color", 'b', "fontsize", 16);
  endfor

  plot([0,      E(end)], [0,         0], "linewidth", 0.5, "color", 'k'); % ось абсцисс
  plot([0,      E(end)], [y_max, y_max], "linewidth", 0.5, "color", 'k'); % потолок
  plot([E(end), E(end)], [y_min, y_max], "linewidth", 0.5, "color", 'k'); % правая стенка
  plot([0,           0], [y_min, y_max], "linewidth", 0.5, "color", 'k'); % левая стенка
  plot([0,      E(end)], [y_min, y_min], "linewidth", 0.5, "color", 'k'); % дно
  hold off;

endfunction




function [result] = j_n(n, z) % сферическая функция Бесселя в общем виде (Unmodied Functions)

  z_cs = z - (n*pi/2);

  s = sin(z_cs);
  c = cos(z_cs);

  k_s = floor(n/2);
  k_c = floor((n - 1)/2);

  result_s = 0;
  result_c = 0;

  for k=0:k_s
    result_s += (-1)^k * a_k(2*k, n) ./ z.^(2*k + 1);
  endfor

  for k=0:k_c
    result_c += (-1)^k * a_k(2*k + 1, n) ./ z.^(2*k + 2);
  endfor

  result_s .*= s;
  result_c .*= c;

  result = result_s + result_c;

endfunction




function [result] = a_k(k, n) % вспомогательный коэффициент

  if (k > n)
    result = 0;
    return;
  endif

  result = factorial(n + k) / (2^k * factorial(k) * factorial(n - k));

endfunction
