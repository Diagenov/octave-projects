R1 = 51.94;
R2 = -20.51;
R3 = -103.39;
d1 = 4.5;
d2 = 1.5;

T1 = asin(19.75 / R1);
T2 = asin(17.52 / -R2);
T3 = asin(20.22 / -R3);

t1 = (-T1/2):0.001:(T1/2);
t2 = (-T2/2):0.001:(T2/2);
t3 = (-T3/2):0.001:(T3/2);

X1 = -R1 * cos(t1) + R1;
Y1 = -R1 * sin(t1);
X2 = -R2 * cos(t2) + R2 + d1;
Y2 = -R2 * sin(t2);
X3 = -R3 * cos(t3) + R3 + d1 + d2;
Y3 = -R3 * sin(t3);



S_H1 = 14.67;
S_H2 = 30.38;

S_F1 = -85.33;
S_F2 = 130.38;

S1 = -43.84;
S2 = -110.62;

d = d1 + d2;



clf;
hold on;
grid on;

axis([-120, 145, -60, 60]);
yticks(-100:10:100);
xticks(-150:10:150);

plot([-150, 150], [0, 0], "linewidth", 0.5, "color", 'k');

plot([S_H1, S_H1], [-100, 100], "linewidth", 0.5, "color", 'k');
plot([S_H2, S_H2] + d, [-100, 100], "linewidth", 0.5, "color", 'k');

text(S_H1 + 0.4, 49.85, 'H_{1}', "fontsize", 25);
text(S_H2 + 0.4 + d, 50, 'H_{1}^{*}', "fontsize", 25);

plot([S_F1, S_F1], [-1.5, 1.5], "linewidth", 0.5, "color", 'k');
plot([S_F2, S_F2] + d, [-1.5, 1.5], "linewidth", 0.5, "color", 'k');

text(S_F1 - 0.5, 3.6, 'F_{1}', "fontsize", 25);
text(S_F2 - 0.5 + d, 3.9, 'F_{1}^{*}', "fontsize", 25);

plot([S1, S1], [-1.5, 1.5], "linewidth", 0.5, "color", 'k');
plot([S2, S2] + d, [-1.5, 1.5], "linewidth", 0.5, "color", 'k');

text(S1 - 1.33, -3.5, 'A', "fontsize", 25);
text(S2 + d - 1.31, -3.1, 'A^{*}', "fontsize", 25);

plot([0, 0], [-100, 100], '--', "linewidth", 0.5, "color", 'k');
plot([d, d], [-100, 100], '--', "linewidth", 0.5, "color", 'k');

plot([S_F1, S_F1], [-100, -1.5], '--', "linewidth", 0.5, "color", 'k');
plot([S_F2, S_F2] + d, [-100, -1.5], '--', "linewidth", 0.5, "color", 'k');

plot([S1, S1], [1.5, 100], '--', "linewidth", 0.5, "color", 'k');
plot([S2, S2] + d, [1.5, 100], '--', "linewidth", 0.5, "color", 'k');

annotation("arrow", [0.481, 0.232], [0.313, 0.313], "headlength", 4, "headwidth", 3);
annotation("arrow", [0.481, 0.523], [0.245, 0.245], "headlength", 4, "headwidth", 3);
annotation("arrow", [0.524, 0.232], [0.381, 0.381], "headlength", 4, "headwidth", 3);

text(-63, -27.8, '-S_{F}', "fontsize", 25);
text(7.2, -37.81, 'S_{H}', "fontsize", 25);
text(-62, -17.8, '-f', "fontsize", 25);

annotation("arrow", [0.499, 0.88], [0.313, 0.313], "headlength", 4, "headwidth", 3);
annotation("arrow", [0.499, 0.587], [0.177, 0.177], "headlength", 4, "headwidth", 3);
annotation("arrow", [0.587, 0.88], [0.381, 0.381], "headlength", 4, "headwidth", 3);

text(109, -27.35, 'S_{F}^{*}', "fontsize", 25);
text(27.5, -47.35, 'S_{H}^{*}', "fontsize", 25);
text(109.5, -17.35, 'f^{*}', "fontsize", 25);

annotation("arrow", [0.499, 0.176], [0.857, 0.857], "headlength", 4, "headwidth", 3);
annotation("arrow", [0.587, 0.176], [0.789, 0.789], "headlength", 4, "headwidth", 3);

text(-83, 52.5, '-S^{*}', "fontsize", 25);
text(-83, 42.5, '-\alpha^{*}', "fontsize", 25);

annotation("arrow", [0.481, 0.353], [0.721, 0.721], "headlength", 4, "headwidth", 3);
annotation("arrow", [0.524, 0.353], [0.653, 0.653], "headlength", 4, "headwidth", 3);

text(-33, 32.2, '-S', "fontsize", 25);
text(-33, 21.8, '-\alpha', "fontsize", 25);

plot(X1, Y1, "linewidth", 1.7, "color", 'b');
plot(X2, Y2, "linewidth", 1.7, "color", 'b');
plot(X3, Y3, "linewidth", 1.7, "color", 'b');

plot([0.97, 5.47], [10, 10], "linewidth", 1.7, "color", 'b');
plot([0.97, 5.47], [-10, -10], "linewidth", 1.7, "color", 'b');

annotation("doublearrow", [0.481, 0.498], [0.4, 0.4], "head1length", 4, "head1width", 3, "head2length", 4, "head2width", 3);
text(1.6, -15.1, 'd', "fontsize", 25);

hold off;

