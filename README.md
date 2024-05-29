# Data and fitting code for studying emergent selectivity in complex stereoarrays

### Introduction

This directory contains data and analysis scripts related to support our recent study titled `Emergent selectivity in complex stereoarrays` and contains DFT optimized ground and transition state structures, kinetic modeling, and stochastic simulations.

### Setup

Scripts are written in both julia and python. Where visualization is important, python was used, and where performance is important (particularly in instances of > 1M function calls), julia was used.

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

These can be installed using the following command in the julia REPL:
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

Alternatively, for advanced users, a flake.nix file is provided to create a nix environment with all the necessary dependencies for both languages.

### Velocity

The `velocity` directory contains julia and python code for modeling and simulating timecourse data for chemical reaction networks by numeric integration. These scripts are used for both time course fitting and stochastic simulations. Both the julia and python scripts provide equivalent numerical results and are largely interchangable. Julia was used where parallelization and performance were important. Simple example scripts are included for each language.

### Stochastic simulations

The `simulations` directory contains julia code for generating random rate constants and simulating their behavior in both short term (transient) and steady state (asymptote) regimes. Code for running and analyzing the results of these simulations is provided, along with the data generated by the simulations performed in the study.

### Timecourse fitting

The `timecourse_fitting` directory contains experimental kinetic data for alpha and beta methyl pyranoside epimerization, as well as scripts used to fit rate constants and analyze the quality of the fit. Python notebooks are provided for approximating catalyst deactivation using multiple reagent dose timecourse data, and for visualizing the predicted timecourse data. Julia scripts are provided for fitting training data with differential evolution followed by local optimization, calculating the loss function against all data, and approximating the sensitivity to parameter changes.

### Drawing kinetic networks

The `network_figure` contains a convenient script for displaying sugar cube kinetic models by generating a Chemdraw .cdxml network from a csv of rate constants.

### DFT structures

The `dft_structures` directory contains DFT optimized structures of reagents, transition states, and intermediates. Structures used for method benchmarking and conformational search are also included. Each file contains energies as noted.
