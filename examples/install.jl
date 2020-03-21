import Pkg; Pkg.add("Plots")
import Pkg; Pkg.add("UnicodePlots")
Pkg.add("OrderedCollections")

include("../src/SpikingNeuralNetworks.jl")
include("../src/units.jl")
include("../src/plot.jl")
try
    using UnicodePlots
    using PyCall
    using NSGAIII
catch
    using Pkg
    Pkg.add("PyCall")
    Pkg.add("UnicodePlots")
    #Pkg.add("Conda")
    #using Conda
    #Conda.add("matplotlib")
    Pkg.build("PyCall")
    Pkg.clone("https://github.com/gsoleilhac/NSGAIII.jl")
    using PyCall
    using UnicodePlots
end
SNN = SpikingNeuralNetworks.SNN

py"""
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
matplotlib.get_backend()
import sys
import os
sys.path.append(os.getcwd())
"""
py"""
from neuronunit import tests
from neuronunit.tests import fi
from simple_with_injection import SimpleModel
from neo import AnalogSignal
import quantities as pq
try:
   from julia import Main
except:
   import julia
   julia.install()
   from julia import Main


"""
simple = py"SimpleModel()"

py"""
import pickle
from neuronunit.tests.fi import RheobaseTestP

cell_tests = pickle.load(open('multicellular_constraints.p','rb'))
for test in cell_tests.values():
    if "Rheobase test" in test.keys():
        temp_test = {k:v for k,v in test.items()}
        break
rt = temp_test["Rheobase test"]

rtest = RheobaseTestP(observation=rt.observation)
#                        name='RheobaseTest')
JHH = {
'Vr': -68.9346,
'Cm': 0.0002,
'gl': 1.0 * 1e-5,
'El': -65.0,
'EK': -90.0,
'ENa': 50.0,
'gNa': 0.02,
'gK': 0.006,
'Vt': -63.0
}
JHH1 = {k:(v-0.01*v) for k,v in JHH.items()}
JHH2 = {k:(v+0.01*v) for k,v in JHH.items()}
ranges = {k:[v-0.01*v,v+0.01*v] for k,v in JHH.items()}


"""
#
using OrderedCollections
ranges = OrderedDict(py"ranges")
H1=[values(ranges)]

current_params = py"rt.params"
print(current_params)
simple.attrs = py"JHH"
