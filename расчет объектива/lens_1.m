R1 = 51.94;
R2 = 20.51;

S_H1 = 1.99;
S_H2 = -0.79;

S_F1 = -23.01;
S_F2 = 24.21;

S1 = -43.84;
S2 = 54.21;

d = 4.5;



T1 = asin(19.75 / R1);
T2 = asin(17.52 / R2);

t1 = (-T1/2):0.005:(T1/2);
t2 = (-T2/2):0.005:(T2/2);

X1 = R1 * cos(t1 + pi) + R1;
Y1 = R1 * sin(t1 + pi);
X2 = R2 * cos(t2) - R2 + d;
Y2 = R2 * sin(t2);



clf;
hold on;
grid on;

axis([-50, 60, -30, 30]);
yticks(-30:5:30);
xticks(-60:5:60);

plot([-100, 100], [0, 0], "linewidth", 0.5, "color", 'k');

plot([S_H1, S_H1], [-30, 30], "linewidth", 0.5, "color", 'k');
plot([S_H2, S_H2] + d, [-30, 30], "linewidth", 0.5, "color", 'k');

text(S_H1 - 2.2, 24.85, 'H_{1}', "fontsize", 25);
text(-S_H2 + 3.3, 25, 'H_{1}^{*}', "fontsize", 25);

plot([S_F1, S_F1], [-1, 1], "linewidth", 0.5, "color", 'k');
plot([S_F2, S_F2] + d, [-1, 1], "linewidth", 0.5, "color", 'k');

text(S_F1, 1.9, 'F_{1}', "fontsize", 25);
text(S_F2 + d, 2.1, 'F_{1}^{*}', "fontsize", 25);

plot([S1, S1], [-1, 1], "linewidth", 0.5, "color", 'k');
plot([S2, S2] + d, [-1, 1], "linewidth", 0.5, "color", 'k');

text(S1 - 0.55, -2.2, 'A', "fontsize", 25);
text(S2 + d - 0.53, -1.9, 'A^{*}', "fontsize", 25);

plot([0, 0], [-30, 18], '--', "linewidth", 0.5, "color", 'k');
plot([d, d], [-30, 18], '--', "linewidth", 0.5, "color", 'k');

plot([S_F1, S_F1], [-30, -1], '--', "linewidth", 0.5, "color", 'k');
plot([S_F2, S_F2] + d, [-30, -1], '--', "linewidth", 0.5, "color", 'k');

plot([S1, S1], [1, 30], '--', "linewidth", 0.5, "color", 'k');
plot([S2, S2] + d, [1, 30], '--', "linewidth", 0.5, "color", 'k');

annotation("arrow", [0.482, 0.32], [0.32, 0.32], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.496, 0.32], [0.24, 0.24], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.482, 0.496], [0.32, 0.32], "headlength", 2.5, "headwidth", 4);

text(-10.85, -13.35, '-S_{F_{1}}', "fontsize", 25);
text(-10.85, -19.3, '-f_{1}', "fontsize", 25);
text(-4.05, -8.75, 'S_{H_{1}}', "fontsize", 25);

plot([0.8, -0.8, -5], [-14.25, -10, -10], "linewidth", 0.35, "color", 'k');

annotation("arrow", [0.514, 0.684], [0.32, 0.32], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.509, 0.684], [0.24, 0.24], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.514, 0.509], [0.32, 0.32], "headlength", 2.5, "headwidth", 4);

text(10.85 + d, -13.15, 'S_{F_{1}}^{*}', "fontsize", 25);
text(10.85 + d, -19.15, 'f_{1}^{*}', "fontsize", 25);
text(6.5, -8.55, '-S_{H_{1}}^{*}', "fontsize", 25);

plot([4.15, 6, 10.2], [-14, -10, -10], "linewidth", 0.35, "color", 'k');

annotation("arrow", [0.482, 0.174], [0.76, 0.76], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.496, 0.174], [0.68, 0.68], "headlength", 2.5, "headwidth", 4);

text(-28, 19.05, '-S_{1}', "fontsize", 25);
text(-28, 12.95, '-\alpha_{1}', "fontsize", 25);

annotation("arrow", [0.514, 0.895], [0.76, 0.76], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.509, 0.895], [0.68, 0.68], "headlength", 2.5, "headwidth", 4);

text(27.5 + d, 19.2, 'S_{1}^{*}', "fontsize", 25);
text(27.5 + d, 13.3, '\alpha_{1}^{*}', "fontsize", 25);

annotation("doublearrow", [0.482, 0.514], [0.22, 0.22], "head1length", 2.5, "head1width", 4, "head2length", 2.5, "head2width", 4);
plot([2.7, 5.7, 9.9], [-22.2, -25, -25], "linewidth", 0.35, "color", 'k');
text(6.85, -23.85, 'd_{1}', "fontsize", 25);

plot(X1, Y1, "linewidth", 1.7, "color", 'b');
plot(X2, Y2, "linewidth", 1.7, "color", 'b');
plot([0.97, 1.9], [10, 10], "linewidth", 1.7, "color", 'b');
plot([0.97, 1.9], [-10, -10], "linewidth", 1.7, "color", 'b');

hold off;

