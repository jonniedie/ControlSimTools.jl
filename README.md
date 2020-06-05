# ControlSimTools

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jonniedie.github.io/ControlSimTools.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jonniedie.github.io/ControlSimTools.jl/dev)
[![Build Status](https://travis-ci.com/jonniedie/ControlSimTools.jl.svg?branch=master)](https://travis-ci.com/jonniedie/ControlSimTools.jl)
[![Codecov](https://codecov.io/gh/jonniedie/ControlSimTools.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jonniedie/ControlSimTools.jl)

This is package is a way for me to experiment with different methods of simulating control systems in plain [DifferentialEquations.jl](https://github.com/SciML/DifferentialEquations.jl). The current focus is on discrete/continuous hybrid systems and state-space style (input/output) component composability. While this package provides plenty of tools that don't require [ComponentArrays.jl](https://github.com/jonniedie/ComponentArrays.jl), the intention is mostly to work with that package. For purely linear systems, [ControlSystems.jl](https://github.com/JuliaControl/ControlSystems.jl) is probably what you should be using.

There are also some estimation tools here like online parameter estimation algorithms for adaptive control and kalman filters for state estimation, but those will likely be broken out into a separate package down the road.

Feel free to use anything you see, but there are no guarantees right now on API stability. Actually, I'm going to go ahead and say there *are* guarantees on API *in*stability until some of these ideas are fleshed-out.
