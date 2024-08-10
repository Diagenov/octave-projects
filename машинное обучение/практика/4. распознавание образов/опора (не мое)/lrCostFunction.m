function [J, grad] = lrCostFunction(theta, X, y, lambda)
  
% целевая функция и градиент

m = length(y); 
J = 0;
grad = zeros(size(theta));

 J =1/m*sum(-y.*log(sigmoid(X*theta)) - (1 - y).*log(1 - sigmoid(X*theta))) + lambda/(2*m)*sum(theta(2:end,1).^2);
 temp = theta;
 temp(1) = 0;
 grad = grad + 1/m*(X'*(sigmoid(X*theta)-y) + lambda*temp); 
 
grad = grad(:);

end
