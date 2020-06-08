using ControlSimTools
using DifferentialEquations
using Plots

function f!(u, u_prev, p, k)
    x, y = u.x
    x_prev, y_prev = u_prev.x

    x[] =  x_prev[-1] + x_prev[-3] / (y_prev[-1]^2 + x_prev[-1]^2) - x_prev[-2]/p
    y[] =  y_prev[-1] - x_prev[-3] / (y_prev[-1]^2 + x_prev[-1]^2) - y_prev[-2]
    return nothing
end

x0 = DiscreteBufferVariable(1.0, 3)
y0 = DiscreteBufferVariable(-1.0, 2)
u0 = ArrayPartition(x0, y0)

sol = DiscreteProblem(f!, u0, (0, 100), 3) |> solve

plot(sol.t, map(x->x.x[1][-1], sol.u), line=:steppost)
plot!(sol.t, map(x->x.x[2][-1], sol.u), line=:steppost)