%выбор коэффициентов
path = '2.txt';
alpha = 0.5;  %'скорость' спуска
lyambda = 0;  %регуляризация (недоработана)
degree = 6;   %степень кривой (линейное уравнение, квадратное, кубическое и т.д...)

%получение данных
D = load(path);
X1 = D(:, 1);
X2 = D(:, 2);
Y = D(:, 3);

X = get_x(X1, X2, degree); %получить столбики иксов с разными степенями
%X = X ./ mean(X);  %масштабирование на единицу
%X = X - mean(X);   %центрирование на нуль

n = size(X, 2);
C = zeros(n, 1);

%метод градиентного спуска (и много матричной алгебры..)
H = @(C) 1 ./ (1 + exp(-X * C)); %сигмоида
h1 = [Y; 1 - Y].';
h2 = @(C) [log(H(C)); log(1 - H(C))];
S = @(C) (-1 / n) * h1 * h2(C);

s1 = S(C);
s2 = s1 + 1;
num = 0;

%использование метода градиентного спуска
while (abs(s2 - s1) > 0.01) && (num < 1000)

  a = (Y - H(C)).'.*alpha;
  l = alpha*lyambda;

  %итеративный поиск коэффициентов C при разных степенях X
  C(1, 1) = C(1, 1) + a*X(:, 1);
  for i = 2:n
    C(i, 1) = C(i, 1) + a*X(:, i) - C(i, 1).*l;
  end

  s2 = s1;
  s1 = S(C);
  num = num + 1;

end

%рисование графиков
figure;
hold on;
pos = find(Y == 1);
neg = find(Y == 0);

%коробка с текстом
text(-0.95, -0.5, sprintf('\\alpha = %.2f\n\\lambda = %.2f\nстепень = %d', alpha, lyambda, degree),
  "fontsize", 18,
  "interpreter", "tex",
  "backgroundcolor", 'w',
  "edgecolor", 'k',
  "linewidth", 1,
  "margin", 5,
  "horizontalalignment", 'left',
  "verticalalignment", 'top');

%наши данные
plot(X(pos, 2), X(pos, 3), 'k+', 'LineWidth', 2, 'MarkerSize', 7);
plot(X(neg, 2), X(neg, 3), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);

%наша кривая для классификации данных
plot_result(X, C, degree); %сами разберитесь...
hold off;
