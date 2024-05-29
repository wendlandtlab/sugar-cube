import sys
sys.path.append("../")

from velocity.chemistry import Species, Reaction, Network

import numpy as np
import pandas as pd

species_A = Species("A")
species_B = Species("B")
    
reaction1 = Reaction(species_A, species_B)

reactions_dict = {
    reaction1 : 0.05,  # rate constant
}

network = Network(reactions_dict, fixed_concentrations=None)

t_span = (0.0, 100.0)
t_eval = np.linspace(0,100,101)
initial_concentrations_dict = { species_A : 1.0 }
concentrations_df = network.simulate_timecourse(initial_concentrations_dict, t_span, t_eval)

print(concentrations_df)