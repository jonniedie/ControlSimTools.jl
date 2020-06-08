module ControlSimTools

using ComponentArrays
using DataStructures: CircularBuffer, DataStructures
using DiffEqBase: DEProblem, AbstractDiffEqFunction, AbstractTimeseriesSolution, isinplace
using DiffEqCallbacks: PeriodicCallback, SavedValues
using OffsetArrays: OffsetArray
using RecursiveArrayTools: RecursiveArrayTools, DiffEqArray, VectorOfArray
using UnPack

include("input_handling.jl")
include("ContinuousDiscreteSystems/hybrid_systems.jl")
include("ContinuousDiscreteSystems/discrete_buffer_variable.jl")

export apply_inputs
export ContinuousDiscreteProblem, DiscreteBufferVariable, DiscreteVariableCallback


end # module
