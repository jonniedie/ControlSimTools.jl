maybe_apply(f::Function, args...) = f(args...)
maybe_apply(f, args...) = f

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
struct StateSpaceFunction{F,H} <: Function
  f!::F
  h::H
  
  function StateSpaceFunction(input_f!, input_h; input_kwargs...)
    f!(dx, args...; kwargs...) = input_f!(dx, args...; map(f -> maybe_apply(f, args...), (;input_kwargs...))..., kwargs...)
    h(args...; kwargs...) = input_h(args...; map(f -> maybe_apply(f, args...), (;input_kwargs...))..., kwargs...)
    return new{typeof(f!), typeof(h)}(f!, h)
  end
end

function (ssf::StateSpaceFunction)(dx, args...; kwargs...)
  ssf.f!(dx, args...; kwargs...)
  return ssf.h(args...; kwargs...)
end
