using ControlSimTools
using DifferentialEquations
using Plots

function f!(u, u_prev, p, k)
    x, y = u.x
    x_prev, y_prev = u_prev.x

    x[] = x_prev[-1] - y_prev[-2] / (y_prev[-1]^2 + x_prev[-1]^2) - x_prev[-3]*p[1]
    y[] = y_prev[-1] - x_prev[-2] / (y_prev[-1]^2 + x_prev[-1]^2) + x_prev[-3]*p[2]
    return nothing
end

x0 = DiscreteBufferVariable(-3.0, 3)
y0 = DiscreteBufferVariable(0.0, 2)
u0 = ArrayPartition(x0, y0)

sol = DiscreteProblem(f!, u0, (0, 300), (0.3, 0.9)) |> solve

x = map(x->x.x[1][-1], sol.u)
y = map(x->x.x[2][-1], sol.u)

p1 = plot(sol.t, [x, y], line=:steppost)
p2 = plot(x, y, seriestype=:scatter, color=2, markersize=2)

plot(p1, p2, layout=(2,1), size=(700,800))