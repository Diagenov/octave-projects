C = [100, 30, 10, 3, 1] * 10.^(-6);   % пять конц-ций, моль/литр
D = dlmread('D.txt');                 % пять спектров, D/l (нм)

Xnm = D(:, 1);          % нм
Xcm = 10.^(7) ./ Xnm;   % см^-1

Yd = D(:, 2:6); % оптическая плотность, D(nm)/l = C*e(nm)
Ye = Yd ./ C;   % экстинция, D/l/C

span = 9;
Ye(:, 1) = smooth(Xcm, Ye(:, 1), span);
Ye(:, 2) = smooth(Xcm, Ye(:, 2), span);
Ye(:, 3) = smooth(Xcm, Ye(:, 3), span);
Ye(:, 4) = smooth(Xcm, Ye(:, 4), span);
Ye(:, 5) = smooth(Xcm, Ye(:, 5), span);

S = [Xnm, Ye];
save e_smooth.txt S;

plot(Xnm, Ye);

% выгружать через dlmread('e_smooth.txt')
% перед выгрузкой вручную убрать первые пять строчек (#...)
