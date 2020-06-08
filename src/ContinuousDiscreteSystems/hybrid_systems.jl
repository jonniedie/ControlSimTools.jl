
# struct HybridProblem{uType,tType,iip,P<:AbstractODEProblem{uType,tType,iip},C} <: AbstractODEProblem{uType,tType,iip}
#     problem::P
#     callbacks::C
#     function HybridProblem(prob::AbstractODEProblem{uType,tType,iip}, cb) where {uType,tType,iip}
#         new{uType, tType, iip, typeof(prob), typeof(cb)}(prob, cb)
#     end
# end

# function HybridProblem(cont_prob::AbstractODEProblem{Tu,Tt,iip}, d_f, d_u0, Δt) where {Tu,Tt,iip}
#     saved_values = SavedValues(typeof(Δt), typeof(d_u0))

#     cb_affect! = function ()
#     end

#     p_cb = PeriodicCallback(d_f, Δt; initial_affect=false)
#     s_cb = SavingCallback(d_f, saved_values, saveat=Δt)
#     return HybridProblem(cont_prob, cb)
# end
# function HybridProblem{iip}(cont_f, disc_f, cont_u0, disc_u0, Δt, args...; kwargs...) where {iip}
#     prob = ODEProblem{iip}(cont_f, cont_u0, args...; kwargs...)
#     return HybridProblem(prob, disc_f, disc_u0, Δt)
# end
# HybridProblem(c_f, args...; kwargs...) = HybridProblem{isinplace(c_f, 5)}(c_f, args...; kwargs...)


# struct HybridFunction{iip, recompile, FC<:AbstractODEFunction{iip}, FD} <: AbstractODEFunction{iip}
#     f_cont::FC
#     f_disc::FD
# end


# hybrid_call(f!, du, cont_u, (disc_u, p), t) = f!(du, cont_u, disc_u, p, t)
# hybrid_call(f, cont_u, (disc_u, p), t) = f(cont_u, disc_u, p, t)



function DiscreteVariableCallback(f, saved_values, Δt; initial_affect=false, kwargs...)
    callback_fun! = function (integrator)
        @unpack p, t = integrator
        u_discrete = saved_values.u[end]
        push!(saved_values.t, t)
        push!(saved_values.u, f(integrator.u, u_discrete, p, t))
        return nothing
    end
    
    return PeriodicCallback(
        callback_fun!,
        Δt;
        initial_affect=initial_affect,
        save_positions=(false, true),
        kwargs...
    )
end



"""
    ContinuousDiscreteProblem
"""
struct ContinuousDiscreteProblem

end



"""
    ContinuousDiscreteSolution(cont_sol::AbstractTimeseriesSolution, disc_sol::DiffEqArray)
"""
struct ContinuousDiscreteSolution{C<:AbstractTimeseriesSolution, D<:DiffEqArray}
    continuous::C
    discrete::D
end

(sol::ContinuousDiscreteSolution)(t) = (continuous=sol.continuous(t), discrete=zoh_interp(sol.discrete, t))

function Base.getindex(sol::ContinuousDiscreteSolution, k_cont)
    cont = sol.continuous
    return (continuous=cont[k_cont], discrete=zoh_interp(sol.discrete, cont.t[k_cont]))
end

zoh_interp(dea::DiffEqArray, t) = dea.u[max(1,searchsortedlast(dea.t, t))]




# function myfun!(dx, x, x_disc, p, t)

# end