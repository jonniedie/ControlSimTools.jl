# For dealing with functions as input variables
_maybe_apply(f::Function, args...) = f(args...)
_maybe_apply(f, args...) = f
