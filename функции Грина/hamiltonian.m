function [ax, ay, az, tx, ty, tz, H] = hamiltonian(WX, WY, WZ, NX, NY, NZ, U)

  % NX - количество узлов по X
  % NY - количество узлов по Y
  % NZ - количество узлов по Z

  % WX - ширина системы (нм)
  % WY - длина системы (нм)
  % WZ - высота системы (нм)

  % U - потенциальная яма (эВ)

  h = (6.6260755/2/pi) * 10^(-27); % постоянная Планка редуцированная
  me = 9.1093897 * 10^(-28);       % масса электрона (г)
  e = 4.803 * 10^(-10);            % заряд электрона (СГСЭ)
  coef = 1.602564*10^(-12);        % переводной коэфф-т (эрг -> эВ)

  %me*e^4/2/h^2/coef % энергия Ридберга (13.6 эВ) - калибровка констант

  WX *= 10^(-7); % нм -> см
  WY *= 10^(-7);
  WZ *= 10^(-7);

  ax = WX / (NX - 1); % узлов на 1 больше, чем отрезков между узлами
  ay = WY / (NY - 1);
  az = WZ / (NZ - 1);

  tx = h^2/2/me/ax^2/coef; % параметры связи (эрг -> эВ)
  ty = h^2/2/me/ay^2/coef;
  tz = h^2/2/me/az^2/coef;
  
  t = (NX > 1)*tx + (NY > 1)*ty + (NZ > 1)*tz;

  N = NX*NY*NZ;
  H = zeros(N, N); % гамильтониан

  for line=1:N % каждая строка - уравнение на волновую функцию в узле n,m,l

    l = ceil(line/NX/NY);              % индекс подматрицы двумерного гамильтониана в трехмерном гамильтониане
    m = ceil((line - NX*NY*(l-1))/NX); % индекс подматрицы одномерного гамильтониана в двумерном гамильтониане
    n = line - NX*NY*(l-1) - NY*(m-1); % индекс диагонального элемента в одномерном гамильтониане

    for column=1:N % каждый столбец в строке - слагаемое уравнения

      ll = ceil(column/NX/NY);                % аналогично
      mm = ceil((column - NX*NY*(ll-1))/NX);
      nn = column - NX*NY*(ll-1) - NY*(mm-1);

      dX = abs(nn - n);
      dY = abs(mm - m);
      dZ = abs(ll - l);

      switch (dX + dY + dZ) % определяем ближайших соседей
        case 0                % диагональный элемент
          H(line, column) = 2*t + U(n, m, l);
        case 1                % недиагональный элемент
          if (dX == 1)          % сосед по оси X
            H(line, column) = -tx;
          elseif (dY == 1)      % сосед по оси Y
            H(line, column) = -ty;
          else                  % сосед по оси Z
            H(line, column) = -tz;
          endif
      endswitch
    endfor
  endfor

endfunction
