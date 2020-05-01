

maybe_apply(f::Function, x, p, t) = f(x, p, t)
maybe_apply(f, x, p, t) = f


"""
    f = simulator(func; kwargs...)

Creates functions for use in ODEProblems that allow functions of type ```(x,p,t)->{...}```
    to be passed in through keyword arguments and applied before passing their result into
    the main ODE function. Creates methods for both in-place and out-of-place use.

# Examples

```jldoctest
julia> using ControlSimTools, OrdinaryDiffEq

julia> function eom!(dx, x, m, t; F=0) # <--Note the input F
       dx[1] = x[2]
       dx[2] = F/m
       return nothing
       end
eom! (generic function with 1 method)

julia> prob = ODEProblem(simulator(eom!, F=(x,p,t)->sin(t)), [0.0, 0.0], (0.0, 10.0), 100.0);

julia> sol = solve(prob, Tsit5());

julia> sol.u[end]
2-element Array{Float64,1}:
 0.105440211435822
 0.01839060375124582
```
"""
function simulator(func; kwargs...)
    simfun(dx, x, p, t) = func(dx, x, p, t; map(f->maybe_apply(f, x, p, t), (;kwargs...))...)
    simfun(x, p, t) = func(x, p, t; map(f->maybe_apply(f, x, p, t), (;kwargs...))...)
    return simfun
end