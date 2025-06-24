D1 = dlmread('ferrum950.txt');
D2 = dlmread('copper950.txt');
D3 = dlmread('iodine950.txt');

D = [D1(:, 3); D2(:, 3); D3(:, 3)];

x_min = D1(1, 1);
x_max = D1(end, 1);

y_min = min(D);
y_max = max(D);



L = length(D3(:, 3));
Q = zeros(L, 1);

for j=1:L
  for k=max(1, j-4):min(L, j+4)
    Q(j) += D3(k, 3);
  endfor
  Q(j) /= 9;
endfor



clf;
hold on;
grid on;
set(gca, 'fontsize', 14);

axis([x_min, x_max, y_min, y_max]);
xticks(0:500:5000);

ylabel('Интенсивность, отн.ед.', 'fontsize', 18);
xlabel('Длины волн, отн.ед.', 'fontsize', 18);

plot(
  D1(:, 1), D1(:, 3), 'r', "linewidth", 0.7, "displayname", 'Спектр железа',
  D2(:, 1), D2(:, 3), 'g', "linewidth", 0.7, "displayname", 'Спектр меди',
  D3(5:end-5, 1), Q(5:end-5), 'b', "linewidth", 1.5, "displayname", 'Спектр йода');

text(2130, 6000, '5105.54 Å', "color", 'k', "fontsize", 14, 'rotation', 90);
text(2950, 5500, '5153.24 Å', "color", 'k', "fontsize", 14, 'rotation', 90);

text(1180, 1200, '5049.83 Å', "color", 'k', "fontsize", 14, 'rotation', 90);
text(2715, 4200, '5139.48 Å', "color", 'k', "fontsize", 14, 'rotation', 90);
text(3195, 6500, '5167.49 Å', "color", 'k', "fontsize", 14, 'rotation', 90);
text(3265, 3800, '5171.6 Å',  "color", 'k', "fontsize", 14, 'rotation', 90);

L = 5139.48 - (2743 - 385)*(5167.49 - 5139.48)/(3224 - 2743);
text(360, 2000, sprintf('%.2f Å', L), "color", 'k', "fontsize", 14, 'rotation', 90);

L = 5139.48 - (2743 - 457)*(5167.49 - 5139.48)/(3224 - 2743);
text(430, 2800, sprintf('%.2f Å', L), "color", 'k', "fontsize", 14, 'rotation', 90);

L = 5139.48 - (2743 - 560)*(5167.49 - 5139.48)/(3224 - 2743);
text(530, 1500, sprintf('%.2f Å', L), "color", 'k', "fontsize", 14, 'rotation', 90);

legend("location", 'northwest'); %northeastoutside
legend('fontsize', 18);
legend show;
legend ("autoupdate", "off");

L = 5139.48 - (2743 - 697)*(5167.49 - 5139.48)/(3224 - 2743);
E = 1240/0.1/L;
plot([697, 697], [y_min, y_max], 'k--', "linewidth", 0.7);
text(670, 10900, sprintf('%.2f эВ', E), "color", 'k', "fontsize", 14, 'rotation', 90);

plot(D3(:, 1), D3(:, 3), 'b--', "linewidth", 0.35);

plot([x_min, x_max], [y_min, y_min], "linewidth", 0.5, "color", 'k'); % дно
plot([x_min, x_max], [y_max, y_max], "linewidth", 0.5, "color", 'k'); % потолок
plot([x_max, x_max], [y_min, y_max], "linewidth", 0.5, "color", 'k'); % правая стенка
plot([x_min, x_min], [y_min, y_max], "linewidth", 0.5, "color", 'k'); % левая стенка
hold off;

% страница 116
