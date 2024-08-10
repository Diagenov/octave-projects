function x = get_x(x1, x2, degree)

  d = size(x1, 1);
  x = [ones(d, 1), x1, x2];

  for i = 2:degree
    for j = 0:i
      x(:, end + 1) = (x1.^(i-j)) .* (x2.^j);
    end
  end

end
