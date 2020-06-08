function _circular_buffer(A, len=length(A), T=eltype(A))
    buff = CircularBuffer{T}(len)
    for val in A
        push!(buff, val)
    end
    return buff
end

"""
    DiscreteBufferVariable
"""
struct DiscreteBufferVariable{T} <: AbstractVector{T}
    buffer::OffsetArray{T,1,CircularBuffer{T}}
end
function DiscreteBufferVariable(x::AbstractVector{<:T}) where T
    len = length(x)
    buff = _circular_buffer(x, len)
    oa = OffsetArray(buff, -length(x)-1)
    return DiscreteBufferVariable{T}(oa)
end
DiscreteBufferVariable(x, n) = DiscreteBufferVariable(fill(x, n))

@inline Base.getindex(dbv::DiscreteBufferVariable) = getindex(dbv.buffer, -1)

@inline Base.setindex!(dbv::DiscreteBufferVariable, val) = push!(dbv, val)

Base.copy(dbv::DiscreteBufferVariable) = DiscreteBufferVariable(copy(dbv.buffer))

function Base.copyto!(dest::DiscreteBufferVariable, src::AbstractVector{<:T}) where T
    for (i_dest, src_elem) = zip(eachindex(dest), src)
        dest[i_dest] = src_elem
    end
    return dest
end

Base.similar(dbv::DiscreteBufferVariable) = DiscreteBufferVariable(similar(dbv.buffer))
Base.similar(dbv::DiscreteBufferVariable, ::Type{T}) where {T} = DiscreteBufferVariable(similar(dbv.buffer, T))

# Pass through methods to the inner CircularBuffer
for fun in [empty!, pop!, push!, popfirst!, pushfirst!, append!, fill!, size, length, getindex, setindex!, axes]
    m = Base.parentmodule(fun)
    f = nameof(fun)
    @eval $m.$f(dbv::DiscreteBufferVariable, args...; kwargs...) = $m.$f(dbv.buffer, args...; kwargs...)
end