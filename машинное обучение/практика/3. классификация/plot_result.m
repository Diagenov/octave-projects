function plot_result(x, c, degree)

  if size(x, 2) <= 3

    x = [-1, 1];
    y = -(C(2) .* x + C(1)) ./ C(3);
    plot(x, y, 'LineWidth', 4);

  else

    u = linspace(-1, 1, 50);
    v = linspace(-1, 1, 50);
    u_l = length(u);
    v_l = length(v);
    z = zeros(u_l, v_l);

    for i = 1:u_l
      for j = 1:v_l
        z(i,j) = get_x(u(i), v(j), degree) * c;
      end
    end

    contour(u, v, z', [0, 0], 'LineWidth', 4);

  end

end
