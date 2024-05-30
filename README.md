# Data and fitting code for studying emergent selectivity in complex stereoarrays

### Introduction

This repository contains data and analysis scripts related to our recent study titled *Emergent selectivity in complex stereoarrays.* The `velocity` directory contains core Julia scripts for modeling and simulating timecourse data. A brief tutorial is also included. The `dft_structures` directory contains DFT-optimized structures of reagents, transition states, and intermediates related to Figure 2 and SI section 8.  The `timecourse_fitting` directory contains the experimental kinetic data and analysis scripts that was used to fit network rate constants related to Figure 3, 4d/4e, and SI section 4. The `simulations` directory contains data and analysis code for stochastic simulations with random rate constants related to Figure 5 and SI section 6. The `network_figure` directory contains scripts used to generate the rate scaled ChemDraw network figures in Figure 3.

### Setup

Scripts are written in both Julia and Python. In general, Julia was used, especially where performance was important. Whereas Python was used when visualization was the primary goal. Python scripts are provided as Jupyter notebooks and depend on Python velocity code found at [ekwan/velocity](https://github.com/ekwan/velocity).

#### Julia
The following julia packages are required to run the scripts in this directory:
* *[Plots.jl](https://github.com/JuliaPlots/Plots.jl)* 
* *[Catalyst.jl](https://github.com/SciML/Catalyst.jl)*
* *[DifferentialEquations.jl](https://github.com/SciML/DifferentialEquations.jl)*
* *[DataFrames.jl](https://github.com/JuliaData/DataFrames.jl)*
* *[CSV.jl](https://github.com/JuliaData/CSV.jl)*
* *[Distributions.jl](https://github.com/JuliaStats/Distributions.jl)*
* *[Optim.jl](https://github.com/JuliaNLSolvers/Optim.jl)*
* *[Metaheuristics.jl](https://github.com/jmejia8/Metaheuristics.jl)*
* *[Parameters.jl](https://github.com/mauro3/Parameters.jl)*
* *[Graphs.jl](https://github.com/JuliaGraphs/Graphs.jl)*

These can be installed using the following command in the Julia REPL:
```julia
import Pkg; Pkg.add(["Plots", "Catalyst", "DifferentialEquations", "DataFrames", "CSV", "Distributions", "Optim", "Metaheuristics", "Parameters", "Graphs"])
```

Julia scripts can be run in the REPL or by executing the script in the terminal with the following command:
```bash
julia script.jl
```

For advanced users, a flake.nix file is provided to create a nix environment with all the necessary dependencies for both languages.