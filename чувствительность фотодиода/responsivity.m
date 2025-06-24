D = dlmread('измерения.txt');

mkA = D(:, 1); % мкА   -  ток исследуемого фотодиода
mkV = D(:, 2); % мкВт  -  эталонный измеритель оптической мощности

N = length(mkA); % кол-во измерений

dX = 25;                    % нм  -  шаг
X_min = 600;                % нм  -  длина волны первого измерения
X_max = X_min + (N - 1)*dX; % нм  -  длина волны последнего измерения

X = (X_min:dX:X_max)'; % нм    -  длины волн
Y = mkA./mkV;          % А/Вт  -  спектральная чувствительность фотодиода




k = 5; % обобщенный метод МНК

A = zeros(k + 1, k + 1);
B = zeros(k + 1, 1);

for j=(-k):(+k)
  A += diag(sum(X.^(k + j)) * ones(1, k + 1 - abs(j)), j);
endfor

for j=1:(k+1)
  B(j) = sum(Y.*X.^(k + 1 - j));
endfor

Q = inv(A)*B

x = linspace(X_min, X_max, 250)';
y = zeros(length(x), 1);

for j=0:k
  y += Q(j + 1) * x.^j;
endfor




clf;
hold on;
grid on;

set(gca, 'fontsize', 14);
axis([X(1), X(end), 0, max(Y)]);

ylabel('Спектральная чувствительность, А/Вт', 'fontsize', 18);
xlabel('Длины волн, нм', 'fontsize', 18);

plot(X, Y, 'r', "linewidth", 1.5, "displayname", 'Экспериментальные данные', x, y, 'k--', "linewidth", 1.5, "displayname", 'Аппроксимирующая кривая');

legend("location", 'southwest');
legend('fontsize', 18);
legend show;
hold off;





