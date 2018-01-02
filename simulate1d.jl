using ODE
import PyPlot
const plt = PyPlot

function f(t, y)
    c = 0.1
    a = 1.35

    (x, s, alpha) = y

    if x < 0
        x = 0
    end
    if x > 1
        x = 1
    end
    x_prime = c*((1-x)*x^a*s-x*(1-x)^a*(1-s))
    # s_prime = (1/x-1/(1-x))*(1-s)*s
    s_prime = alpha*(1/(x+1) + 1/(x-2))*(1-s)*s
    alpha_prime = 0

    return [x_prime;s_prime;alpha_prime]
end

function simulate()
    alpha0 = 1
    starty = [0.55, 0.45, alpha0]
    tspan = [0, 1000]
    t, y = ode45(f, starty, tspan)
    x = map(y -> y[1], y)
    s = map(y -> y[2], y)
    # plot(t, sqrt.(x1.^2+x2.^2))
    plt.plot(x, s)
    plt.ylabel("s")
    plt.xlabel("x")
    plt.savefig("traj1D2.png")
    plt.show()
end

function bassin()
    x = linspace(0,1,100)
    s = linspace(0,1,100)
    alpha = logspace(-3, 1, 10)
    A = zeros(length(x), length(s))
    tspan = [0,200]
    for (i, alpha0) in enumerate(alpha)
        for (j,s0) in enumerate(s)
            # print((i, j))
            # if ((j==8) && (i<=4))
            #     tspan = [0,150]
            # elseif (j==7) && i<=1
            #     tspan = [0,200]
            # else
            #     tspan = [0,100]
            # end
            t, y = ode45(f, [0.2, s0, alpha0], tspan)
            xsol = map(y -> y[1], y)
            ssol = map(y -> y[2], y)
            # if (j==7) && (i<=3)
            #     @show alpha0
            #     @show s0
            #     @show xsol
            # end

            if (xsol[end] < 1e-3)
                A[i,j] = 1
            elseif xsol[end] > 1-0.01
                A[i,j] = -1
            else
                A[i,j] = 0
            end
        end
    end
    plt.imshow(A)
    plt.ylabel("alpha")
    plt.xlabel("s")
    plt.show()
end

simulate()
# bassin()
