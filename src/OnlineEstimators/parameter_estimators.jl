# Gradient algorithm
function est_gradient!(dθ, θ, g, t; regressor=[0.0], output=0.0)
    w, y = regressor, output
    e = w'*θ - output
    dθ .= -g*w*e
    return θ
end

gradient_estimator(g) = (dθ, θ, p, t; kwargs...) -> est_gradient!(dθ, θ, g, t; kwargs...)