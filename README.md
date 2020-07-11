# ControlSimTools

<!--
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jonniedie.github.io/ControlSimTools.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jonniedie.github.io/ControlSimTools.jl/dev)
[![Build Status](https://travis-ci.com/jonniedie/ControlSimTools.jl.svg?branch=master)](https://travis-ci.com/jonniedie/ControlSimTools.jl)
[![Codecov](https://codecov.io/gh/jonniedie/ControlSimTools.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jonniedie/ControlSimTools.jl)
-->
[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

This is package is a way for me to experiment with ultra-flexible control systems simulations using plain [DifferentialEquations.jl](https://github.com/SciML/DifferentialEquations.jl). The driving idea is offer something close to the convenience of a domain-specific language like Simulink without having to give up the flexibility or rich features of DifferentialEquations.jl. If you are looking for a real causal simulation DSL that is built on top of DifferentialEquations.jl, I'd suggest trying out [JuSDL.jl](https://github.com/zekeriyasari/Jusdl.jl) instead. If you are working with purely linear systems, [ControlSystems.jl](https://github.com/JuliaControl/ControlSystems.jl) is probably what you should be using.

The current focus is on discrete/continuous hybrid systems and state-space style (input/output) component composability. While this package provides plenty of tools that don't require [ComponentArrays.jl](https://github.com/jonniedie/ComponentArrays.jl), the intention is mostly to work with that package.

There are also some estimation tools here like online parameter estimation algorithms for adaptive control and kalman filters for state estimation, but those will likely be broken out into a separate package down the road.

Feel free to use anything you see, but there are no guarantees right now on API stability. Actually, I'm going to go ahead and say there *are* guarantees on API *in*stability until some of these ideas are fleshed-out.
