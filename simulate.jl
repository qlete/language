using ODE
using PyPlot

function f(t, y)
    c = 1
    k = 0.8
    # s = 1/3
    a = 1.31
    alpha = 1

    (x1, x2, x3) = y

    if x1 < 0
        x1 = 0
    end
    if x1 > 1
        x1 = 1
    end

    if x2 < 0
        x2 = 0
    end
    if x2 > 1
        x2 = 1
    end

    x1_prime = c*(1-x1)*((1-k)*x3*(1-x2)^a - (1-x3)*x1*(1-x1)^(a-1))
    x2_prime = c*(1-x2)*((1-k)*(1-x3)*(1-x1)^a - x3*x2*(1-x2)^(a-1))
    x3_prime = alpha*(1/(x1+1)-1/(x2+2))*x3*(1-x3)

    return [x1_prime;x2_prime;x3_prime]
end

function simulate()
    starty = [0.4, 0.4, 0.5]
    tspan = [0, 100]
    t, y = ode45(f, starty, tspan)
    x1 = map(y -> y[1], y)
    x2 = map(y -> y[2], y)
    s = map(y -> y[3], y)
    plot(t, s)
    show()
    # plot(t, sqrt.(x1.^2+x2.^2))
    plot(x1, x2)
    show()
end

simulate()
