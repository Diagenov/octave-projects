R1 = -20.51;
R2 = -103.39;

S_H1 = -0.22;
S_H2 = -1.1;

S_F1 = 36.14;
S_F2 = -37.46;

d = 1.5;



T1 = asin(17.52 / -R1);
T2 = asin(20.22 / -R2);

t1 = (-T1/2):0.001:(T1/2);
t2 = (-T2/2):0.001:(T2/2);

X1 = -R1 * cos(t1) + R1;
Y1 = -R1 * sin(t1);
X2 = -R2 * cos(t2) + R2 + d;
Y2 = -R2 * sin(t2);


clf;
hold on;
grid on;

axis([-40, 40, -25, 25]);
yticks(-50:5:50);
xticks(-115:5:60);

plot([-150, 150], [0, 0], "linewidth", 0.5, "color", 'k');

plot([S_H1, S_H1], [-50, 50], "linewidth", 0.5, "color", 'k');
plot([S_H2, S_H2] + d, [-50, 50], "linewidth", 0.5, "color", 'k');

text(-1.87, 19.9, 'H_{2}', "fontsize", 25);
text(0.7, 20, 'H_{2}^{*}', "fontsize", 25);

plot([S_F1, S_F1], [-1, 1], "linewidth", 0.5, "color", 'k');
plot([S_F2, S_F2] + d, [-1, 1], "linewidth", 0.5, "color", 'k');

text(S_F1 + 0.25, 1.1, 'F_{2}', "fontsize", 25);
text(S_F2 + d + 0.25, 1.3, 'F_{2}^{*}', "fontsize", 25);

plot([0, 0], [-50, 1], '--', "linewidth", 0.5, "color", 'k');
plot([d, d], [-50, 1], '--', "linewidth", 0.5, "color", 'k');

plot([S_F1, S_F1], [-50, 50], '--', "linewidth", 0.5, "color", 'k');
plot([S_F2, S_F2] + d, [-50, 50], '--', "linewidth", 0.5, "color", 'k');

annotation("arrow", [0.522, 0.17], [0.715, 0.715], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.532, 0.17], [0.235, 0.235], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.532, 0.522], [0.275, 0.275], "headlength", 2.5, "headwidth", 4);

text(-18.7, -16.1, '-S_{F_{2}}^{*}', "fontsize", 25);
text(-18.7, 13.2, '-f_{2}^{*}', "fontsize", 25);
text(-4.65, -12.3, '-S_{H_{2}}', "fontsize", 25);

plot([-0.14, -1.4, -5.6], [-15.5, -13.4, -13.4], "linewidth", 0.35, "color", 'k');

annotation("arrow", [0.515, 0.867], [0.7, 0.7], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.518, 0.867], [0.22, 0.22], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.518, 0.515], [0.26, 0.26], "headlength", 2.5, "headwidth", 4);

text(18.7, -17.2, 'S_{F_{2}}', "fontsize", 25);
text(18.7, 12.2, 'f_{2}', "fontsize", 25);
text(3.1, -9.75, '-S_{H_{2}}^{*}', "fontsize", 25);

plot([0.94, 2.2, 6.4], [-14.6, -11, -11], "linewidth", 0.35, "color", 'k');

annotation("doublearrow", [0.518, 0.532], [0.18, 0.18], "head1length", 2.5, "head1width", 4, "head2length", 2.5, "head2width", 4);
plot([0.8, 2.6, 6.8], [-20.45, -16.6, -16.6], "linewidth", 0.35, "color", 'k');
text(4, -15.45, 'd_{2}', "fontsize", 25);

plot(X1, Y1, "linewidth", 1.7, "color", 'b');
plot(X2, Y2, "linewidth", 1.7, "color", 'b');
plot([-2.65, 0.98], [10, 10], "linewidth", 1.7, "color", 'b');
plot([-2.65, 0.98], [-10, -10], "linewidth", 1.7, "color", 'b');

hold off;

