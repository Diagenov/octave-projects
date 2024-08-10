c = 3 * 10.^(10);   % скорость света (см/с)

D = dlmread('D.txt');                 % пять спектров, D/l (нм)
E = dlmread('e_smooth.txt');          % пять спектров сглаженных, D/l/c (экстинция)

Xnm = D(:, 1);            % нм
Xcm = 10.^(7) ./ Xnm;     % см^-1
Xhz = Xcm * c ./ 10.^12;  % ТГц

Yd = D(:, 2:6);   % оптическая плотность, D(nm)/l = C*e(nm)
Ye = E(:, 2:6);   % экстинция, D/l/C

minXnm = min(Xnm);
maxXnm = max(Xnm);
minXcm = min(Xcm);
maxXcm = max(Xcm);
minXhz = min(Xhz);
maxXhz = max(Xhz);
minYe = min(Ye(:));
maxYe = 90000;
minYd = min(Yd(:));
maxYd = 5.5;




figure(1);
clf;
hold on;
grid on;
axis([minXnm, maxXnm, minYe, maxYe]);
xticks(500:25:725);
yticks(0:10000:90000);
set(gca, 'fontsize', 14);
title('Раствор красителя метиленового голубого в воде', 'fontsize', 20);
xlabel('Длина волны, нм', 'fontsize', 18);
ylabel('Экстинция, отн.ед.', 'fontsize', 18);

plot(Xnm, Ye(:, 1), "linewidth", 1, "color", '#d63636', "displayname", 'C = 10^{-4} моль/литр');
plot(Xnm, Ye(:, 2), "linewidth", 1, "color", '#36d66e', "displayname", 'C = 3 \cdot 10^{-5} моль/литр');
plot(Xnm, Ye(:, 3), "linewidth", 1, "color", '#36d6b9', "displayname", 'C = 10^{-5} моль/литр');
plot(Xnm, Ye(:, 4), "linewidth", 1, "color", '#3648d6', "displayname", 'C = 3 \cdot 10^{-6} моль/литр');
plot(Xnm, Ye(:, 5), "linewidth", 1, "color", '#a136d6', "displayname", 'C = 10^{-6} моль/литр');

set(legend("show"), 'fontsize', 16);
hold off;




figure(2);
clf;
hold on;
grid on;
axis([minXhz, maxXhz, minYe, maxYe]);
xticks(400:25:600);
yticks(0:10000:90000);
set(gca, 'fontsize', 14);
title('Раствор красителя метиленового голубого в воде', 'fontsize', 20);
xlabel('Частота, ТГц', 'fontsize', 18);
ylabel('Экстинция, отн.ед.', 'fontsize', 18);

plot(Xhz, Ye(:, 1), "linewidth", 1, "color", '#d63636', "displayname", 'C = 10^{-4} моль/литр');
plot(Xhz, Ye(:, 2), "linewidth", 1, "color", '#36d66e', "displayname", 'C = 3 \cdot 10^{-5} моль/литр');
plot(Xhz, Ye(:, 3), "linewidth", 1, "color", '#36d6b9', "displayname", 'C = 10^{-5} моль/литр');
plot(Xhz, Ye(:, 4), "linewidth", 1, "color", '#3648d6', "displayname", 'C = 3 \cdot 10^{-6} моль/литр');
plot(Xhz, Ye(:, 5), "linewidth", 1, "color", '#a136d6', "displayname", 'C = 10^{-6} моль/литр');

set(legend("show"), 'fontsize', 16);
hold off;




figure(3);
clf;
hold on;
grid on;
axis([minXcm, maxXcm, minYe, maxYe]);
xticks(13000:1000:20000);
yticks(0:10000:90000);
set(gca, 'fontsize', 14);
title('Раствор красителя метиленового голубого в воде', 'fontsize', 20);
xlabel('Волновые числа, см^{-1}', 'fontsize', 18);
ylabel('Экстинция, отн.ед.', 'fontsize', 18);

plot(Xcm, Ye(:, 1), "linewidth", 1, "color", '#d63636', "displayname", 'C = 10^{-4} моль/литр');
plot(Xcm, Ye(:, 2), "linewidth", 1, "color", '#36d66e', "displayname", 'C = 3 \cdot 10^{-5} моль/литр');
plot(Xcm, Ye(:, 3), "linewidth", 1, "color", '#36d6b9', "displayname", 'C = 10^{-5} моль/литр');
plot(Xcm, Ye(:, 4), "linewidth", 1, "color", '#3648d6', "displayname", 'C = 3 \cdot 10^{-6} моль/литр');
plot(Xcm, Ye(:, 5), "linewidth", 1, "color", '#a136d6', "displayname", 'C = 10^{-6} моль/литр');

set(legend("show"), 'fontsize', 16);
hold off;




figure(4);
clf;
hold on;
grid on;
axis([minXnm, maxXnm, minYd, maxYd]);
xticks(500:25:725);
yticks(0:0.5:5.5);
set(gca, 'fontsize', 14);
title('Раствор красителя метиленового голубого в воде', 'fontsize', 20);
xlabel('Длина волны, нм', 'fontsize', 18);
ylabel('Оптическая плотность, отн.ед.', 'fontsize', 18);

plot(Xnm, Yd(:, 1), "linewidth", 1, "color", '#d63636', "displayname", 'C = 10^{-4} моль/литр');
plot(Xnm, Yd(:, 2), "linewidth", 1, "color", '#36d66e', "displayname", 'C = 3 \cdot 10^{-5} моль/литр');
plot(Xnm, Yd(:, 3), "linewidth", 1, "color", '#36d6b9', "displayname", 'C = 10^{-5} моль/литр');
plot(Xnm, Yd(:, 4), "linewidth", 1, "color", '#3648d6', "displayname", 'C = 3 \cdot 10^{-6} моль/литр');
plot(Xnm, Yd(:, 5), "linewidth", 1, "color", '#a136d6', "displayname", 'C = 10^{-6} моль/литр');

set(legend("show"), 'fontsize', 16);
hold off;




figure(5);
clf;
hold on;
grid on;
axis([minXhz, maxXhz, minYd, maxYd]);
xticks(400:25:600);
yticks(0:0.5:5.5);
set(gca, 'fontsize', 14);
title('Раствор красителя метиленового голубого в воде', 'fontsize', 20);
xlabel('Частота, ТГц', 'fontsize', 18);
ylabel('Оптическая плотность, отн.ед.', 'fontsize', 18);

plot(Xhz, Yd(:, 1), "linewidth", 1, "color", '#d63636', "displayname", 'C = 10^{-4} моль/литр');
plot(Xhz, Yd(:, 2), "linewidth", 1, "color", '#36d66e', "displayname", 'C = 3 \cdot 10^{-5} моль/литр');
plot(Xhz, Yd(:, 3), "linewidth", 1, "color", '#36d6b9', "displayname", 'C = 10^{-5} моль/литр');
plot(Xhz, Yd(:, 4), "linewidth", 1, "color", '#3648d6', "displayname", 'C = 3 \cdot 10^{-6} моль/литр');
plot(Xhz, Yd(:, 5), "linewidth", 1, "color", '#a136d6', "displayname", 'C = 10^{-6} моль/литр');

set(legend("show"), 'fontsize', 16);
hold off;




figure(6);
clf;
hold on;
grid on;
axis([minXcm, maxXcm, minYd, maxYd]);
xticks(13000:1000:20000);
yticks(0:0.5:5.5);
set(gca, 'fontsize', 14);
title('Раствор красителя метиленового голубого в воде', 'fontsize', 20);
xlabel('Волновые числа, см^{-1}', 'fontsize', 18);
ylabel('Оптическая плотность, отн.ед.', 'fontsize', 18);

plot(Xcm, Yd(:, 1), "linewidth", 1, "color", '#d63636', "displayname", 'C = 10^{-4} моль/литр');
plot(Xcm, Yd(:, 2), "linewidth", 1, "color", '#36d66e', "displayname", 'C = 3 \cdot 10^{-5} моль/литр');
plot(Xcm, Yd(:, 3), "linewidth", 1, "color", '#36d6b9', "displayname", 'C = 10^{-5} моль/литр');
plot(Xcm, Yd(:, 4), "linewidth", 1, "color", '#3648d6', "displayname", 'C = 3 \cdot 10^{-6} моль/литр');
plot(Xcm, Yd(:, 5), "linewidth", 1, "color", '#a136d6', "displayname", 'C = 10^{-6} моль/литр');

set(legend("show"), 'fontsize', 16);
hold off;
