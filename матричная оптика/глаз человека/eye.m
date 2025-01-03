M_int = @(l) [1, -l; 0, 1];                         % оптический промежуток
M_flt = @(n1, n2) [1, 0; 0, n1/n2];                 % плоская поверхность
M_sph = @(n1, n2, R) [1, 0; (n2-n1)/(n2*R), n1/n2]; % сферическая поверхность

M_sph_int_sph = @(n1, n2, n3, r1, r2, l) M_sph(n2, n3, r2) * M_int(l) * M_sph(n1, n2, r1); % толстая линза

f = @(n1, n2, C) -n1/n2/C;                    % положение передней фокальной плоскости относительно передней главной плоскости
Sf = @(C, D) -D/C;                            % положение передней фокальной плоскости относительно передней преломляющей поверхности
Sh = @(n1, n2, C, D) Sf(C, D) - f(n1, n2, C); % положение передней главной плоскости относительно передней преломляющей поверхности

_f = @(C) 1/C;                   % положение задней фокальной плоскости относительно задней главной плоскости
_Sf = @(A, C) A/C;               % положение задней фокальной плоскости относительно задней преломляющей поверхности
_Sh = @(A, C) _Sf(A, C) - _f(C); % положение задней главной плоскости относительно задней преломляющей поверхности



% Параметры оптической системы глаза
r1 = 7.70;  % радиус передней преломляющей поверхности роговицы
r2 = 6.80;  % радиус задней преломляющей поверхности роговицы
r3 = 10.0;  % радиус (1) преломляющей поверхности хрусталика(радиус зрачка)
r4 = 7.91;  % радиус (2,3) преломляющей поверхности хрусталика
r5 = -5.76; % радиус (4,5) преломляющей поверхности хрусталика
r6 = -6.00; % радиус (6) преломляющей поверхности хрусталика

n1 = 1;     % воздух (вход)
n2 = 1.376; % роговица
n3 = 1.336; % полость с водянистой влагой
n4 = 1.386; % хрусталик (1)
n5 = 1.406; % хрусталик (2)
n6 = 1.386; % хрусталик (3)
n7 = 1.336; % стекловидное тело (выход)

d1 = 0.5;  % оптический промежуток роговицы
d2 = 3.1;  % оптический промежуток полости
d3 = 0.55; % оптический промежуток хрусталика (1)
d4 = 2.42; % оптический промежуток хрусталика (2)
d5 = 0.64; % оптический промежуток хрусталика (3)



% Получение матрицы с учетом сложного строения хрусталика
M1 = M_sph_int_sph(n1, n2, n3, r1, r2, d1); % роговица
M2 = M_int(d2);                             % водянистая влага
M3 = M_sph_int_sph(n3, n4, n5, r3, r4, d3); % хрусталик (1)
M4 = M_int(d4);                             % хрусталик (2)
M5 = M_sph_int_sph(n5, n6, n7, r5, r6, d5); % хрусталик (3)

M = M5*M4*M3*M2*M1;

A = M(1, 1);
B = M(1, 2);
C = M(2, 1);
D = M(2, 2);



% Расчет кардинальных точек оптической системы глаза
_Sf(A, C)
Sf(C, D)
_f(C)
f(n1, n7, C)
Sh(n1, n7, C, D)
_Sh(A, C)

% Оптическая сила: насколько сильно оптическая система преломляет падающие лучи (как сильно различаются оптические плотности сред по обе стороны преломляющей поверхности)
1000/_f(C)

% Положение изображения по формуле Гаусса (сопряженных отрезков, для тонкой линзы)
% (f/S) + (_f/_S) = 1







