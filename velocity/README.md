# Data and fitting code for studying emergent selectivity in complex stereoarrays

### Introduction

This directory contains julia and python code for modeling and simulating timecourse data for chemical reaction networks by numeric integration. These scripts are used for both time course fitting and stochastic simulations. Both the julia and python scripts provide equivalent numerical results and are largely interchangable. Julia was used where parallelization and performance were important. Example python and julia scripts are provided for the following quickstart examples showing how to setup a simple A --> B reaction network and simulate the timecourse across 100 seconds starting with 1.0 for the concentration of species A (example.py and example.jl). These scripts can be run in the terminal with the following commands and should produce equivalent results:

```bash
julia example.jl
python example.py
```

### Python Quickstart

More complete documentation can be found at [ekwan/velocity](https://github.com/ekwan/velocity/).

The script is included into a python file by using an `import` statement after adding the parent directory to PYTHONPATH. 

```python
import sys
sys.path.append("../")
import velocity
from velocity.chemistry import Species, Reaction, Network
```

Here's how to setup a simple A --> B reaction network:

```python
species_A = Species("A")
species_B = Species("B")
    
reaction1 = Reaction(species_A, species_B)

reactions_dict = {
    reaction1 : 0.05,  # rate constant
}

network = Network(reactions_dict, fixed_concentrations=None)
```

And then simulate the timecourse of the network across 100 seconds starting with 1.0 for the concentration of species A:

```python
t_span = (0.0, 100.0)
t_eval = np.linspace(0,100,101)
initial_concentrations_dict = { species_A : 1.0 }
concentrations_df = network.simulate_timecourse(initial_concentrations_dict, t_span, t_eval)
```

`concentrations_df` will contain the abbreviations for Species as the column headings and `t_eval` as the index:

```
              A         B
time
0.0    1.000000  0.000000
1.0    0.951229  0.048771
2.0    0.904837  0.095163
3.0    0.860704  0.139296
...         ...       ...
100.0  0.006756  0.993244
```

### Julia Quickstart

The julia code is conceptually identical but syntactically different. 

The script is included into a julia file by using the `include` function. 

```julia
include("./velocity.jl")
```

Here's how to setup the same A --> B reaction network:

```julia
species_A = Species(id = "A")
species_B = Species(id = "B")
species = (species_A, species_B)

reactions = (
    # A --> B
    # in this case rate constant is a tuple (0.05,0) where the second value is the reverse rate constant
    Reaction(reactants=[species_A], products=[species_B], rate_constant=(0.05,0), id="A_B")
)

network = RxnNetwork(species, reactions)
# or equivalently
network = RxnNetwork(reactions) # species are inferred from reactions alphabetically by id
```

And then simulate the timecourse of the network across 100 seconds starting with 1.0 for the concentration of species A:

```julia
t_span = (0.0, 100.0)
# note that we use Tuple instead of Array for t_eval
t_eval = Tuple(range(0,100,length=101))
initial_concentrations = Dict(species_A => 1.0)

# in this case, simulate_timecourse returns an ODESolution object
sol = simulate_timecourse(network, initial_concentrations, t_span, t_eval)

# to convert into an equivalent DataFrame
concentrations_df = DataFrame(permutedims(hcat(sol.u...)), Symbol.([s.id for s in species]))
concentrations_df[!,:time] = sol.t
```

The resulting DataFrame will look like this:
```
 Row │ A           B          time    
     │ Float64     Float64    Float64 
─────┼────────────────────────────────
   1 │ 1.0         0.0            0.0
   2 │ 0.951229    0.0487706      1.0
   3 │ 0.904837    0.0951626      2.0
   4 │ 0.860708    0.139292       3.0
 ... | ...         ...            ...
 101 │ 0.00673858  0.993261     100.0
```