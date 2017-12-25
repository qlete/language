using ODE
using MAT
using PyPlot
using PyCall
@pyimport matplotlib.animation as anim

function linear(i, j, m)
    return i+(j-1)*m
end

function subplus(x)
    if x >= 0
        return x
    else
        return 0
    end
end

function f_spatial(t, y)
    c = 1
    a = 1.35
    s = 1/2

    m = 135
    n = 135


    dy = zeros(m*n)
    for i = 1:m
        for j = 1:n
            nb = 1
            x = 0
            this_x = y[linear(i,j,m)]
            x += this_x
            if i >= 2
                x += y[linear(i-1, j, m)]
                nb += 1
            end
            if i <= m-1
                x += y[linear(i+1, j, m)]
                nb += 1
            end
            if j >= 2
                x += y[linear(i, j-1, m)]
                nb += 1
            end
            if j <= n-1
                x += y[linear(i, j+1, m)]
                nb += 1
            end
            x = x/nb
            dy[linear(i,j,m)] = c*((1-this_x)*subplus(x)^a*s-this_x*subplus((1-x))^a*(1-s))
        end
    end
    return dy
end

function simulate()
    m = 4
    n = 4
    starty = rand(m*n)
    # starty = [0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 0.1, 0.1,  0.1,  0.1,  0.1,  0.1,  0.1,  0.1]
    println(typeof(starty))
    tspan = [0,1000]
    t, y = ode45(f_spatial, starty, tspan)
    sol = zeros(n,m)
    init = zeros(n,m)
    for i = 1:m
        for j = 1:n
            sol[i,j] = y[end][linear(i,j,m)]
            init[i,j] = starty[linear(i,j,m)]
        end
    end
    subplot(1, 2, 1)
    imshow(init, vmin=0.0, vmax=1.0)
    subplot(1, 2, 2)
    imshow(sol, vmin=0.0, vmax=1.0)
    show()
end

function ireland()
    db = matopen("ireland.mat")
    starty = read(db, "ir")
    starty = starty/100
    keep = (floor(sqrt(length(starty))))^2
    keep = Int(keep)
    starty = starty[1:keep]
    m = Int(sqrt(keep))
    n = Int(sqrt(keep))

    println(typeof(starty))
    tspan = [0,200]
    t, y = ode45(f_spatial, starty, tspan)
    return y
    # sol = zeros(n,m)
    # init = zeros(n,m)
    # for i = 1:m
    #     for j = 1:n
    #         sol[i,j] = y[end][linear(i,j,m)]
    #         init[i,j] = starty[linear(i,j,m)]
    #     end
    # end
    # subplot(1, 2, 1)
    # imshow(init, vmin=0.0, vmax=1.0)
    # subplot(1, 2, 2)
    # imshow(sol, vmin=0.0, vmax=1.0)
    # show()

end

y = ireland()

function make_frame(i)
    println(i)
    m = 135
    n = 135
    sol = zeros(m,n)
    for k = 1:m
        for j = 1:n
            sol[k,j] = y[i][linear(k,j,m)]
        end
    end
    imshow(sol)
end

fig = figure()

myanim = anim.FuncAnimation(fig, make_frame, frames=1:size(y)[1], interval=40)
myanim[:save]("iranim.mp4", bitrate=-1, extra_args=["-vcodec", "libx264", "-pix_fmt", "yuv420p"])

# simulate()
# ireland()
