function [SIGMA] = plot_three_gauss(C, X, Y, Yo, Xc, W, A, dY_text, x_tics)

  if (exist("x_tics") == 0)
    x_tics = 500:25:725;
  endif

  if (exist("dY_text") == 0)
    dY_text = 0.06;
  endif

  Xc1 = Xc(1, 1);
  Xc2 = Xc(1, 2);
  Xc3 = Xc(1, 3);

  gaussian = @(x, Xc, W, A) A * exp(-2 * ((x - Xc)./W).^2) ./ W ./ sqrt(pi./2) + Yo;

  Y1 = gaussian(X, Xc1, W(1, 1), A(1, 1));
  Y2 = gaussian(X, Xc2, W(1, 2), A(1, 2));
  Y3 = gaussian(X, Xc3, W(1, 3), A(1, 3));
  Ys = Y1 + Y2 + Y3 - 2*Yo;

  Xmax = max(X);
  Xmin = min(X);
  Ymax = 90000;
  Y1max = max(Y1);
  Y2max = max(Y2);
  Y3max = max(Y3);

  Y1_text = [(Xc1 - Xmin) / (Xmax - Xmin), (Y1max - Yo) / (Ymax - Yo)];
  Y2_text = [(Xc2 - Xmin) / (Xmax - Xmin), (Y2max - Yo) / (Ymax - Yo)];
  Y3_text = [(Xc3 - Xmin) / (Xmax - Xmin), (Y3max - Yo) / (Ymax - Yo)];

  Y1_text -= dY_text;
  Y3_text += dY_text;


  C_text = '';
  if (size(C, 2) > 1)
    C_text = sprintf('C = %d \\cdot 10^{%d} моль/литр', C)
  else
    C_text = sprintf('C = 10^{%d} моль/литр', C)
  endif


  c = 3 * 10.^(10);   % скорость света (см/с)
  N = 6.022 * 10.^(23);  % число Авагадро (безразмер., 1/моль)

  Xc_nm = Xc                  % пики, нм
  Xc_cm = 10.^7 ./ Xc       % пики, см^-1
  Xc_hz = Xc_cm * c ./ 10.^12 % пики, ТГц

  W_nm = W                                      % полуширины, нм
  W_cm = Xc_cm - (10.^7 ./ (Xc + W))          % полуширины, см^-1
  W_hz = Xc_hz - ((Xc_cm - W_cm) * c ./ 10.^12) % полуширины, ТГц


  sigma = @(y) 10.^3 * log(10) * y / N;
  sigma1 = sigma(Y1max);  % сечение поглощение 1 пика
  sigma2 = sigma(Y2max);  % сечение поглощение 2 пика
  sigma3 = sigma(Y3max);  % сечение поглощение 3 пика

  SIGMA = [
    sigma1,
    sigma2,
    sigma3
  ]


  clf;
  hold on;
  grid on;
  axis([Xmin, Xmax, Yo, Ymax]);
  xticks(x_tics);
  yticks(0:10000:Ymax);
  set(gca, 'fontsize', 14);
  title('Раствор красителя метиленового голубого в воде', 'fontsize', 20);
  xlabel('Длина волны, нм', 'fontsize', 18);
  ylabel('Экстинция, отн.ед.', 'fontsize', 18);

  plot(X, Y, "linewidth", 1, "color", 'k', "displayname", 'Спектр поглощения');
  plot(X, Y1, "linewidth", 1, "color", 'r', "displayname", 'Первый гауссиан');
  plot(X, Y2, "linewidth", 1, "color", 'g', "displayname", 'Второй гауссиан');
  plot(X, Y3, "linewidth", 1, "color", 'b', "displayname", 'Третий гауссиан');
  plot(X, Ys, "linestyle", '--', "linewidth", 1, "color", 'k', "displayname", "Аппроксимирующая кривая,\nт.е. сумма гауссианов");
  set(legend("show"), 'fontsize', 16);

  text1 = sprintf('\\lambda_{max} = %.2f нм', Xc1);
  text2 = sprintf('\\lambda_{max} = %.2f нм', Xc2);
  text3 = sprintf('\\lambda_{max} = %.2f нм', Xc3);

  annotation('textbox', [Y1_text, 0.7, 0.7], 'string', text1, 'FitBoxToText', 'on', 'fontsize', 18, "color", 'r', "backgroundcolor", 'w');
  annotation('textbox', [Y2_text, 0.7, 0.7], 'string', text2, 'FitBoxToText', 'on', 'fontsize', 18, "color", 'g', "backgroundcolor", 'w');
  annotation('textbox', [Y3_text, 0.7, 0.7], 'string', text3, 'FitBoxToText', 'on', 'fontsize', 18, "color", 'b', "backgroundcolor", 'w');
  annotation('textbox', [0.15, 0.85, 0.7, 0.7], 'string', C_text, 'FitBoxToText', 'on', 'fontsize', 18, "color", 'k', "backgroundcolor", 'w');

  hold off;

end
