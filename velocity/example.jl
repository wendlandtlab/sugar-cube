include("./velocity.jl")
using DataFrames

species_A = Species(id="A")
species_B = Species(id="B")
species = (species_A, species_B)

reactions = (
    # A --> B
    # in this case rate constant is a tuple (0.05,0) where the second value is the reverse rate constant
    Reaction(reactants=Dict(species_A => 1), products=Dict(species_B => 1), rate_constant=(0.05, 0), id="A_B"),
)

network = RxnNetwork(species, reactions)

t_span = (0.0, 100.0)
t_eval = Tuple(range(0, 100, length=101))
initial_concentrations = Dict(species_A => 1.0)

# in this case, simulate_timecourse returns an ODESolution object
sol = simulate_timecourse(network, initial_concentrations, t_span, t_eval)

# to convert into an equivalent DataFrame
concentrations_df = DataFrame(permutedims(hcat(sol.u...)), Symbol.([s.id for s in species]))
concentrations_df[!, :time] = sol.t

println(concentrations_df)