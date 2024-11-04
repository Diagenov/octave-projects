clc;

h = (6.6260755/2/pi) * 10^(-27); % постоянная Планка редуцированная
m = 9.1093897 * 10^(-28);        % масса электрона (г)
e = 4.803 * 10^(-10);            % заряд электрона (СГСЭ)
coef = 1.602564*10^(-12);        % переводной коэфф-т, заряд электрона (эрг -> эВ)
a0 = h^2/m/e^2;                  % боровский радиус

%m*e^4/2/h^2/coef % энергия Ридберга * калибровка констант

L = 2 * 10^(-7);  % ширина ямы (см)
a = L/1500;       % шаг (см)
t0 = h^2/2/m/a^2; % коэфф-т в уравнении Шредингера (конечно-разностный метод)

X = a:a:L;     % точки на оси X в яме
M = length(X); % количество точек


l = 0; % орбитальное квантовое число (0 = s-орбиталь, 1 = p-орбиталь, ...)
Z = 1; % зарядовое число (?)

V = -Z*e^2./X;
Veff = V + (l*(l + 1)*h^2 ./ (2*m*X.^2)); % эффективный потенциал водорода


A_D1 = 2 * t0 * ones(1, M) + Veff;               % диагональ главная
A_D2 = -t0 * ones(1, M - 1);                     % диагонали 1 и -1 от главной
A = diag(A_D1) + diag(A_D2, -1) + diag(A_D2, 1); % матрица оператора Гамильтона (которая умножается на вектор-столбец значений волновой функции в точках)

[A, B] = eig(A);  % A - собственные функции (каждый столбец - отдельная функция), B - собственные значения (диагональная матрица, значения на диагонали)
B = diag(B)/coef; % переводим эрг в эВ (?)
A = abs(A).^2;    % плотность состояний (квадрат модуля волновой функции, уже нормированы на единицу)



N = 10;

n = (0:1:min([M, N] - 1)) + l + 1; % главное квантовое число = сумма радиального (0, 1, ...) и орбитального (0, 1, ...) квантовых чисел + единица

analitic_energy = -(Z*e)^2/2/a0./n.^2/coef;
numeric_energy  = B(1:N);

min_max = [numeric_energy; analitic_energy']; % чтобы графики занимали весь рисунок

y_min = ceil(min(min_max) - 1);
y_max = ceil(max(min_max));

txt = sprintf("Количество узлов сетки = %d\nШаг сетки = %.5f Å\nРазмер сетки = %.2f Å", M, a*10^(8), L*10^(8));

figure(1);
clf;
hold on;
grid on;
set(gca, 'fontsize', 14);
ylabel('Энергетический уровень, эВ', 'fontsize', 18);
xlabel('Главное квантовое число', 'fontsize', 18);
axis([1, N, y_min, y_max]);
yticks(y_min:1:y_max);
xticks(1:1:N);
plot(numeric_energy, 'r', "linewidth", 1.75, analitic_energy, 'k--', "linewidth", 1.75); % сравнение энергий
text(0.6*N, 0.2*(y_max - y_min) + y_min, txt,
  "fontsize", 18,
  "backgroundcolor", 'w',
  "edgecolor", 'k',
  "linewidth", 1,
  "margin", 5,
  "horizontalalignment", 'left',
  "verticalalignment", 'top');
hold off;



if (l == 0)
  Q = Z*X/a0; % замена переменных

  analitic_1s = a * (4*Z*Q.^2/a0) .* exp(-2*Q);
  numeric_1s  = A(:, 1);

  analitic_2s = a * (Z*Q.^2/8/a0) .* (2 - Q).^2 .* exp(-Q);
  numeric_2s  = A(:, 2);

  analitic_3s = a * (4*Z*Q.^2/81^2/3/a0) .* (21 - 18*Q + 2*Q.^2).^2 .* exp(-2*Q/3);
  numeric_3s  = A(:, 3);

  y_max = max([numeric_1s; analitic_1s']); % ориентируемся на пиковую плотность вероятности основного состояния

  txt = "{\\color[rgb]{1 0 0} 1s-состояние}\n{\\color[rgb]{0 1 0} 2s-состояние}\n{\\color[rgb]{0 0 1} 3s-состояние}";

  figure(2);
  clf;
  hold on;
  grid on;
  set(gca, 'fontsize', 14);
  ylabel('Плотность вероятности', 'fontsize', 18);
  xlabel('Номер узла сетки', 'fontsize', 18);
  axis([0, M, 0, y_max]);
  plot(numeric_1s, 'r', "linewidth", 1.75, analitic_1s, 'k--', "linewidth", 1.75); %сравнение для 1s-состояния
  plot(numeric_2s, 'g', "linewidth", 1.75, analitic_2s, 'k--', "linewidth", 1.75); %сравнение для 2s-состояния
  plot(numeric_3s, 'b', "linewidth", 1.75, analitic_3s, 'k--', "linewidth", 1.75); %сравнение для 3s-состояния
  text(0.6*M, 0.9*y_max, txt,
    "fontsize", 18,
    "backgroundcolor", 'w',
    "edgecolor", 'k',
    "linewidth", 1,
    "margin", 5,
    "horizontalalignment", 'left',
    "verticalalignment", 'top');
  hold off;
endif;



N = 3;



Y_wv = A(:, 1:N);
Y_en = B(1:N);

Y_wv /= max(Y_wv(:))/(Y_en(end) - Y_en(1) - 1)/0.45; % чтобы было видно плотности состояний (с учетом масштаба..)
Y_wv += Y_en';                                       % размещение на энергетических уровнях

Y_en *= ones(1, 2); % нужны две точки, чтобы нарисовать прямую
X *= 10^(8);        % см --> ангстрем

x_max = ceil(X(end));
y_max = max(Y_wv(:));
y_min = ceil(min(Y_wv(:)) - 2);



figure(3);
clf;
hold on;
grid on;

set(gca, 'fontsize', 14);

ylabel('Энергия, эВ', 'fontsize', 18);
xlabel('Модуль радиус-вектора, Å', 'fontsize', 18);

axis([0, x_max, y_min, y_max]);

yticks(-100:1:100);
xticks(0:1:100);

plot(X, V/coef, 'k', "linewidth", 0.5);
plot([0, x_max], Y_en, 'k--', "linewidth", 0.75);
plot(X, Y_wv, 'r', "linewidth", 0.75);

for i=1:N
  text(0.75*x_max, B(i) - 0.03*(y_max - y_min), sprintf('E_{%d} = %.2f эВ', i, B(i)), "color", 'b', "fontsize", 16);
endfor

plot([x_max, x_max], [y_min, y_max], "linewidth", 0.5, "color", 'k'); % правая стенка
plot([0,         0], [y_min, y_max], "linewidth", 0.5, "color", 'k'); % левая стенка
plot([0,     x_max], [y_min, y_min], "linewidth", 0.5, "color", 'k'); % дно
hold off;


% ортиентировать настройку осей X и Y на разный масштаб...
% можно сделать этот файл функцией с аргументами ширины сетки, орбитального квантового числа и зарядового числа
% расписать задачу трехмерной потенциальной ямы с возможностью разделить переменные








