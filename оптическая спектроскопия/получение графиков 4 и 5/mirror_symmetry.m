I = dlmread('I_smooth.txt');
D = dlmread('D_smooth.txt');

Xi = I(:, 1); % длины волн, нм
Yi = I(:, 2); % люминесценция лазером 532 нм (сглаженная)

Xd = D(:, 1); % длины волн, нм
Yd = D(:, 2); % оптическая плотность (сглаженная)



Y_min = min(Yi);  % минимальная люминесценция
if (Y_min < 0)
   Yi -= Y_min;   % долой отрицательные значения!
endif

Y_min = min(Yd);  % минимальная люминесценция
if (Y_min < 0)
   Yd -= Y_min;   % долой отрицательные значения!
endif



c = 3 * 10.^(10);             % скорость света (см/с)
hz_nm = @(x) 10.^7 * c ./ x;  % нм <-> Гц

Xi = hz_nm(Xi); % Гц
Xd = hz_nm(Xd); % Гц

Yi = Yi ./ Xi.^4; % I/v^4
Yd = Yd ./ Xd;    % D/l/v

Yi ./= max(Yi); % нормировка на 1
Yd ./= max(Yd); % нормировка на 1

Xi = hz_nm(Xi); % нм
Xd = hz_nm(Xd); % нм



clf;
hold on;
grid on;

plot([674, 674], [0, 1], "linewidth", 1, "color", 'k', "displayname", "0-0 переход на 674 нм", "linestyle", "--");

[AXIS, PLOT1, PLOT2] = plotyy(Xd, Yd, Xi, Yi);

set(PLOT1, "linewidth", 1, "color", 'b', "displayname", "Спектр поглощения");
set(PLOT2, "linewidth", 1, "color", 'r', "displayname", "Спектр люминисценции");

set(AXIS(1), "ylabel", 'Нормированная оптическая плотность, отн.ед.', 'fontsize', 20, 'ycolor', 'b');
set(AXIS(2), "ylabel", 'Нормированная интенсивность, отн.ед.', 'fontsize', 20, 'ycolor', 'r');

axis([475, 875, 0, 1]);
xticks(AXIS(1), 475:25:875);
xticks(AXIS(2), 0:0:0);
yticks(AXIS(1), 0:0.1:1);
yticks(AXIS(2), 0:0.1:1);

title('Люминесценция раствора красителя метиленового голубого в воде', 'fontsize', 25);
xlabel('Длина волны, нм', 'fontsize', 20);

set(legend("show"), 'fontsize', 20);
hold off;


