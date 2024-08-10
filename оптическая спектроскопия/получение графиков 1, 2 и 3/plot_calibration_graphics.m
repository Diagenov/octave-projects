X = [100, 30, 10, 3, 1];
Ymax = 5.5;

Y1 = [5.22, 1.88, 0.63, 0.23, 0.08];
Y2 = [3.72, 1.03, 0.34, 0.13, 0.05];
Y3 = [2.02, 0.48, 0.15, 0.05, 0.02];

K1 = sum(X.*Y1) ./ sum(X.^2)
K2 = sum(X.*Y2) ./ sum(X.^2)
K3 = sum(X.*Y3) ./ sum(X.^2)



Y1_what = [0.389, 0.631];
Y2_what = [0.214, 0.358];
Y3_what = [0.097, 0.149];

C1_what = Y1_what ./ K1
C2_what = Y2_what ./ K2
C3_what = Y3_what ./ K3
C_what = (C1_what + C2_what + C3_what) ./ 3


Y1_text = 80.*K1 / Ymax;
Y2_text = 80.*K2 / Ymax;
Y3_text = 80.*K3 / Ymax;

Y1_text -= 0.06;
Y3_text += 0.06;



clf;
hold on;
grid on;
axis([0, 100, 0, Ymax]);
yticks(0:0.5:Ymax);
xticks(0:10:100);
set(gca, 'fontsize', 14);

title('Раствор красителя метиленового голубого в воде', 'fontsize', 20);
ylabel('Оптическая плотность, отн.ед.', 'fontsize', 18);
xlabel('Концентрация, 10^{-6} \cdot моль/литр', 'fontsize', 18);

plot(X, K1 * X, '-', "linewidth", 1, "color", 'r');
plot(X, Y1, 'o', "linewidth", 1, "color", 'r');

plot(X, K2 * X, '-', "linewidth", 1, "color", 'g');
plot(X, Y2, 'o', "linewidth", 1, "color", 'g');

plot(X, K3 * X, '-', "linewidth", 1, "color", 'b');
plot(X, Y3, 'o', "linewidth", 1, "color", 'b');

text1 = '\lambda_{max} = 662.77 нм';
text2 = '\lambda_{max} = 621.47 нм';
text3 = '\lambda_{max} = 579.88 нм';

annotation('textbox', [0.72, Y1_text, 0.7, 0.7], 'string', text1, 'FitBoxToText', 'on', 'fontsize', 18, "color", 'r', "backgroundcolor", 'w');
annotation('textbox', [0.72, Y2_text, 0.7, 0.7], 'string', text2, 'FitBoxToText', 'on', 'fontsize', 18, "color", 'g', "backgroundcolor", 'w');
annotation('textbox', [0.72, Y3_text, 0.7, 0.7], 'string', text3, 'FitBoxToText', 'on', 'fontsize', 18, "color", 'b', "backgroundcolor", 'w');
hold off;



