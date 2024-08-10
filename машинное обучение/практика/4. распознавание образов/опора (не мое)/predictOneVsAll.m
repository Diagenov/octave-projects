function [p, p1] = predictOneVsAll(all_theta, X)

m = size(X, 1);
num_labels = size(all_theta, 1);

p = zeros(size(X, 1), 1);
X = [ones(m, 1), X];

temp = X * all_theta';
[p1, p] = max(temp, [], 2);

end