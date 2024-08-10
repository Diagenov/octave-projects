C = [-2; -1; 1; 2];
X = [ones(5,1) reshape(1:15,5,3)/10];
Y = ([1;0;1;0;1] >= 0.5);
[J, grad] = lrCostFunction(C, X, Y, 3)
