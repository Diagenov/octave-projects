R1 = -20.51;
R2 = -103.39;

S_H1 = -0.22;
S_H2 = -1.1;

S_F1 = 36.14;
S_F2 = -37.46;

S1 = 54.21;
S2 = -110.62;

d = 1.5;



T1 = asin(17.52 / -R1);
T2 = asin(20.25 / -R2);

t1 = (-T1/2):0.001:(T1/2);
t2 = (-T2/2):0.001:(T2/2);

X1 = -R1 * cos(t1) + R1;
Y1 = -R1 * sin(t1);
X2 = -R2 * cos(t2) + R2 + d;
Y2 = -R2 * sin(t2);


clf;
hold on;
grid on;

axis([-115, 60, -45, 45]);
yticks(-50:5:50);
xticks(-115:5:60);

plot([-150, 150], [0, 0], "linewidth", 0.5, "color", 'k');

plot([S_H1, S_H1], [-50, 50], "linewidth", 0.5, "color", 'k');
plot([S_H2, S_H2] + d, [-50, 50], "linewidth", 0.5, "color", 'k');

text(-3.9, 29.85, 'H_{2}', "fontsize", 25);
text(0.75, 30, 'H_{2}^{*}', "fontsize", 25);

plot([S_F1, S_F1], [-1, 1], "linewidth", 0.5, "color", 'k');
plot([S_F2, S_F2] + d, [-1, 1], "linewidth", 0.5, "color", 'k');

text(S_F1, 2.1, 'F_{2}', "fontsize", 25);
text(S_F2 + d, 2.4, 'F_{2}^{*}', "fontsize", 25);

plot([S1, S1], [-1, 1], "linewidth", 0.5, "color", 'k');
plot([S2, S2] + d, [-1, 1], "linewidth", 0.5, "color", 'k');

text(S1 + 0.72, -2.2, 'A', "fontsize", 25);
text(S2 + d + 0.7, -1.9, 'A^{*}', "fontsize", 25);

plot([0, 0], [-50, 1], '--', "linewidth", 0.5, "color", 'k');
plot([d, d], [-50, 1], '--', "linewidth", 0.5, "color", 'k');

plot([S1, S1], [-50, 50], '--', "linewidth", 0.5, "color", 'k');
plot([S2, S2] + d, [-50, 50], '--', "linewidth", 0.5, "color", 'k');

annotation("arrow", [0.638, 0.879], [0.675, 0.675], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.639, 0.879], [0.33, 0.33], "headlength", 2.5, "headwidth", 4);

text(-60.5, -16.9, '-S_{2}^{*}', "fontsize", 25);
text(-60.5, 21.1, '-\alpha_{2}^{*}', "fontsize", 25);

annotation("arrow", [0.641, 0.157], [0.69, 0.69], "headlength", 2.5, "headwidth", 4);
annotation("arrow", [0.646, 0.157], [0.345, 0.345], "headlength", 2.5, "headwidth", 4);

text(27, -18.9, 'S_{2}', "fontsize", 25);
text(27, 18.9, '\alpha_{2}', "fontsize", 25);

plot(X1, Y1, "linewidth", 1.7, "color", 'b');
plot(X2, Y2, "linewidth", 1.7, "color", 'b');
plot([-2.65, 0.98], [10, 10], "linewidth", 1.7, "color", 'b');
plot([-2.65, 0.98], [-10, -10], "linewidth", 1.7, "color", 'b');

hold off;

