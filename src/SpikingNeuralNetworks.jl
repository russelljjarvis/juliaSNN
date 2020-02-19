
module SpikingNeuralNetworks

const SNN = SpikingNeuralNetworks

using SparseArrays
using Pkg
Pkg.add("Reexport")
Pkg.add("Requires")
using Reexport
# Pkg.add("Utils")
# @reexport using Utils

const SNNInt = Int32
const SNNFloat = Float32

include("utils.jl")
@reexport using utils
include("plot.jl")
#using Parameters
# using Requires
using Unitful
using Unitful.DefaultSymbols


srand(1000)

include("units.jl")
include("main.jl")
include("neuron/hh.jl")
end

#include("neuron/if.jl")
#include("neuron/if2.jl")
#include("neuron/noisy_if.jl")
#include("neuron/poisson.jl")
include("neuron/iz.jl")
include("neuron/rate.jl")

include("synapse/spiking_synapse.jl")
include("synapse/rate_synapse.jl")
include("synapse/pinning_full_synapse.jl")
# include("synapse/pinning_synapse.jl")
include("synapse/fl_full_synapse.jl")
# include("synapse/fl_synapse.jl")

function __init__()
    @require Plots="91a5bcdd-55d7-5caf-9e0b-520d859cae80" include("plot.jl")
end

