using ODE
using PyPlot

function f(t, y)
    c = 0.1
    k = 0
    # s = 1/3
    a = 1.35

    (x1, x2, x3) = y

    x1_prime = c*(1-x1)*((1-k)*x3*(1-x2)^a - (1-x3)*x1*(1-x1)^(a-1))
    x2_prime = c*(1-x2)*((1-k)*(1-x3)*(1-x1)^a - x3*x2*(1-x2)^(a-1))
    x3_prime = 1/x1-1/x2

    return [x1_prime;x2_prime;x3_prime]
end

function simulate()
    starty = [0.6, 0.4, 0.5]
    tspan = [0, 100]
    t, y = ode45(f, starty, tspan)
    x1 = map(y -> y[1], y)
    x2 = map(y -> y[2], y)
    plot(t, sqrt.(x1.^2+x2.^2))
    # plot(x1, x2)
    show()
end

simulate()
