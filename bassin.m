function bassin()
    x = linspace(0,1,10);
    s = linspace(0,1,10);
    alpha = logspace(-3,1,10);
    A = zeros(length(x), length(s));
    tspan = [0 100];
    for i = 1:length(alpha)
        for j = 1:length(s)
            alpha0 = alpha(i);
            s0 = s(i);
            [~, y] = ode45(@f, tspan, [0.8, s0, alpha0]);
            if (y(end, 1) < 1e-3) || (y(end, 1) > 1-1e-3)
                A(i,j) = 1;
            else
                A(i,j) = 0;
            end
        end
    end
    imshow(A)
end