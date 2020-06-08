function _circular_buffer(A, len)
    buff = CircularBuffer{eltype(A)}(len)
    for val in A
        push!(buff, val)
    end
    return buff
end

"""
    DiscreteVariableBuffer
"""
struct DiscreteVariableBuffer{T} <: AbstractVector{T}
    buffer::OffsetArray{T,1,CircularBuffer{T}}
end
function DiscreteVariableBuffer(x::AbstractVector{<:T}) where T
    len = length(x)
    buff = _circular_buffer(x, len)
    oa = OffsetArray(buff, -length(x)-1)
    return DiscreteVariableBuffer{T}(oa)
end

@inline Base.size(dvb::DiscreteVariableBuffer) = size(dvb.buffer)
@inline Base.length(dvb::DiscreteVariableBuffer) = length(dvb.buffer)

@inline Base.@propagate_inbounds function Base.getindex(dvb::DiscreteVariableBuffer, i)
    return getindex(dvb.buffer, i)
end

@inline Base.@propagate_inbounds function Base.setindex!(dvb::DiscreteVariableBuffer, val, i)
    return setindex!(dvb.buffer, val, i)
end
@inline Base.@propagate_inbounds function Base.setindex!(dvb::DiscreteVariableBuffer, val)
    return push!(dvb, val)
end

Base.axes(dvb::DiscreteVariableBuffer) = axes(dvb.buffer)

# RecursiveArrayTools.recursivecopy(dvb::DiscreteVariableBuffer) = deepcopy(dvb)
Base.copy(dvb::DiscreteVariableBuffer) = DiscreteVariableBuffer(copy(dvb.buffer))
Base.similar(dvb::DiscreteVariableBuffer) = DiscreteVariableBuffer(similar(dvb.buffer))
Base.similar(dvb::DiscreteVariableBuffer, ::Type{T}) where {T} = DiscreteVariableBuffer(similar(dvb.buffer, T))

# Pass through methods to the inner CircularBuffer
for fun in [empty!, pop!, push!, popfirst!, pushfirst!, append!, fill!]
    m = Base.parentmodule(fun)
    f = nameof(fun)
    @eval $m.$f(dvb::DiscreteVariableBuffer, args...; kwargs...) = $m.$f(dvb.buffer, args...; kwargs...)
end