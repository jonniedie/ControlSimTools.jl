"""
    StateSpaceFunction(f!, h; kwargs...)

# Examples
```julia
x = Float64[1, 2]
dx = similar(x)
p = 5

f!(dx, x, p, t; u, err) = (dx .= p*x .+ err)
h(x, p, t; u=1000, err) = x .- 3u
ssf = StateSpaceFunction(f!, h; u=(x,p,t)->cos(t), err=0.0)
```
"""
struct StateSpaceFunction{F,H,NT} <: Function
    f!::F
    h::H
    inputs::NT
end
StateSpaceFunction(f!, h; inputs...) = StateSpaceFunction(f!, h, (;inputs...))

function (ssf::StateSpaceFunction)(dx, args...; kwargs...)
    applied_kwargs = map(f -> _maybe_apply(f, args...), (;ssf.inputs..., kwargs...))
    ssf.f!(dx, args...; applied_kwargs...)
    return ssf.h(args...; applied_kwargs...)
end
