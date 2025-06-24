clc;
clear;

NX = 100;
NY = 100;
N = NX*NY;

U = @(jx, jy, jz) -0.05 + (jx-1)*(0.1/(NX-1)); % потенциальная яма

[ax, ay, az, tx, ty, tz, H] = hamiltonian(10, 10, 10, NX, NY, 1, U);




%m = 0.25*m;                         % эффективная масса электрона
mu = 0.25;                          % электрохимический потенциал (эВ)
kT = 0.025;                         % тепловая энергия (эВ)
f = @(B) 1./(1 + exp((B - mu)/kT)); % функция Ферми




NE = 250;                    % кол-во узлов
E = linspace(-0.1, 0.4, NE); % 'сетка по энергиям'
dE = E(2) - E(1);            % приращение по энергии
i0 = i*1e-12;                % мнимая положительная бесконечно малая

sigmaR = zeros(N, N); % правый контакт = полубесконечная проволока справа
sigmaL = zeros(N, N); % левый контакт = полубесконечная проволока слева
n = zeros(N, 1);      % электронная плотность

ka = @(B, jx, jy) acos(1 - ((B - U(jx, jy) + i0)/2/tx)); % из дисперсионного соотношения E = Ec + 2*t0*(1 - cos(ka))

for k=1:NE
  B = E(k); % варьируемая энергия

  for jy=1:NY
    iL = jy*NX;
    iR = iL - NX + 1;

    sigmaR(iR, iR) = -tx * exp(i*ka(B, 1, jy));  % правый контакт * путаница с обозначением лево-право
    sigmaL(iL, iL) = -tx * exp(i*ka(B, NX, jy)); % левый контакт
  endfor

  G = inv(((B + i0) * eye(N)) - H - sigmaR - sigmaL); % функция Грина
  A = i*(G - G');                                     % спектральная функция
  n += f(B) * (dE * diag(A)/2/pi);                    % электронная плотность
endfor




Z = zeros(NX, NY);
X = 1:NX;
Y = 1:NY;
[X, Y] = meshgrid((X-1)*ax*10^7, (Y-1)*ay*10^7);

for jy=1:NY
  n1 = (jy - 1)*NX + 1;
  n2 = jy * NX;;
  Z(jy, 1:NX) = n(n1:n2); % <--------- ????????????
endfor

Z /= ax*ay;

figure(1);
clf;
hold on;
grid on;
set(gca, 'fontsize', 14);

title('Электронная плотность, см^{-2}', 'fontsize', 18);
ylabel('Длина, нм', 'fontsize', 18);
xlabel('Ширина, нм', 'fontsize', 18);

surface(X, Y, Z);

shading flat;
hold off;




if (0)
  figure(2);
  clf;
  hold on;
  grid on;
  set(gca, 'fontsize', 14);

  title('Линия вдоль оси абсцисс (y_m = y_1)', 'fontsize', 18);
  ylabel('Электронная плотность, см^{-2}', 'fontsize', 18);
  xlabel('Ширина, нм', 'fontsize', 18);

  plot((Y-1)*ay*10^7, Z(1, :), 'r', "linewidth", 1);
  hold off;
endif




if (0)
  figure(3);
  clf;
  hold on;
  grid on;
  set(gca, 'fontsize', 14);

  title('Линия вдоль оси ординат (x_n = x_1)', 'fontsize', 18);
  ylabel('Электронная плотность, см^{-2}', 'fontsize', 18);
  xlabel('Длина, нм', 'fontsize', 18);

  plot((X-1)*ax*10^7, Z(:, 1), 'r', "linewidth", 1);
  hold off;
endif




for jy=1:NY
  for jx=1:NX
    Z(jy, jx) = U(jx, jy, 1);
  endfor
endfor

figure(4);
clf;
hold on;
grid on;
set(gca, 'fontsize', 14);

title('Потенциальное поле, эВ', 'fontsize', 18);
ylabel('Длина, нм', 'fontsize', 18);
xlabel('Ширина, нм', 'fontsize', 18);

surface(X, Y, Z);

shading flat;
hold off;








