# Data and fitting code for studying a sugar cube kinetic model

[![DOI](https://zenodo.org/badge/807292002.svg)](https://zenodo.org/doi/10.5281/zenodo.11398531)

### Introduction

This repository contains data and analysis scripts related to our recent study titled *The sugar cube: network control and emergence in stereoediting reactions.* 

| Directory | Description | Manuscript/SI Section |
| --- | --- | --- |
| `velocity` | Core Julia scripts for modeling and simulating timecourse data | - |
| `dft_structures` | DFT-optimized structures of reagents, transition states, and intermediates | Figure 2, SI section 8 |
| `timecourse_fitting` | Experimental kinetic data and analysis scripts for fitting network rate constants | Figure 3, 4d/4e, SI section 4 |
| `simulations` | Data and analysis code for stochastic simulations with random rate constants | Figure 5, SI section 6 |
| `network_figure` | Scripts used to generate the rate scaled ChemDraw network figures | Figure 3c/e |

### Setup

Scripts are written in both Julia and Python. In general, Julia was used, especially where performance was important. Whereas Python was used when visualization was the primary goal. Python scripts are provided as Jupyter notebooks and depend on Python velocity code found at [ekwan/velocity](https://github.com/ekwan/velocity). For advanced users, a flake.nix file is provided to create a [nix](https://nixos.org/) environment with all the necessary dependencies for both languages.

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

#### Python
The following python packages are required to run the scripts in this directory:
* *[numpy](https://numpy.org/)*
* *[pandas](https://pandas.pydata.org/)*
* *[matplotlib](https://matplotlib.org/)*
* *[jupyter](https://jupyter.org/)*
* *[ipython](https://ipython.org/)*
* *[lmfit](https://lmfit.github.io/lmfit-py/)*

These can be installed using the following command in the terminal:
```bash
pip install numpy pandas matplotlib jupyter ipython lmfit
```

Python notebooks can be run in the jupyter environment or a suitable editor that supports ipython (e.g. VSCode).
