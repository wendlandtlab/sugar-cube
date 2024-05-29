# Simulation data and analysis scripts

### Introduction

This directory contains experimental kinetic data for alpha and beta methyl pyranoside epimerization, as well as scripts used to fit rate constants and analyze the quality of the fit. Python notebooks are provided for approximating catalyst deactivation using multiple reagent dose timecourse data, and for visualizing the predicted timecourse data. Julia scripts are provided for fitting training data with differential evolution followed by local optimization, calculating the loss function against all data, and approximating the sensitivity to parameter changes.

### Experimental data

`expt_data` contains experimental data from the kinetic experiments (determined by NMR analysis). Files contain collated experiments separated by sugar type (alpha vs beta) and whether test data is excluded or included. See SI section 4.2 for experimental details. Each file contains the following columns:

- `Run`: the run number
- `Time` (s): time in seconds
- `Sugar Abbreviation` (mol %): mol % of a given sugar

### Catalyst deactivation

`catalyst_deactivation.ipynb` is a python notebook for approximating catalyst deactivation using multidose timecourse data from `catalyst_deactivation_data.xlsx`. See SI section 4.4 for experimental details. Catalyst deactivation is roughly approximated as an irreversible first order reaction (See notebook for deatails, rate constant approximated as 0.000014).

### Time course fitting

The `fit_alpha.jl` and `fit_beta.jl` scripts fit either the alpha or beta training set data and prints the results to console. The fitting process uses differential evolution for the global search followed by local optimization to minimize a loss function that is the RMSD error between experimental and predicted timecourses. After optimization, the final parameters are printed to console. The results from this study are saved to `alpha_fitting.txt` or `beta_fitting.txt`. 

The loss function is defined as follows:
```julia
function loss_function(paramset)
    network = get_network_cat(paramset, 0.000014)
    errors = []
    for dataset in datasets
        sim = simulate_timecourse(network, dataset[1], (0.0, maximum(dataset[2])), dataset[2]).u
        local_errors = []
        for (idx, timepoint) in enumerate(sim)
            timepoint = [timepoint[1:2]; timepoint[5:end]] # remove catalysts
            push!(local_errors, rmsd(dataset[3][idx], timepoint, 0))
        end
        push!(errors, rmsd(local_errors))
    end
    # return overall rmsd converted to mol%
    return rmsd(errors) / 0.2 * 100
end
```

Initial global optimization is done with differential evolution algorithm as implemented in Metaheurstics.jl. For this process, bounds are set for each parameter limmiting the search space. The bounds are set for the rate to be between 1000 and 30,000 and the selectivity constrained to be between 20:1 and 1:20. This process is parallelized to speed up the optimization process. Function calls were limited to 10M and the tolerance was set to 1e-3. The seed was set to 1 for reproducibility. After global optimization, local optimization was done with LBFGS algorithm as implemented in Optim.jl. No parameter bounds were set for this process, optimization was constrained to 1000 iterations and the tolerance was set to 1e-3.

These scripts can be run in the terminal with the following command (in this case using 128 threads):
```bash
julia --threads 128 fit_alpha.jl
julia --threads 128 fit_beta.jl
```

### Assessing fit quality

`fit_quality.jl` calculates the same loss function against all data (including the test set) and prints the results to console. Additionally, graphs comparing simulated to experimental data are generated and saved to png; by default these graphs plot experimental data as blue dots and simulated data in grey. This script can be run in the terminal with the following command:

```bash
julia fit_quality.jl
```

### Assessing fit sensitivity to parameter changes

`sensitivity_alpha.jl` and `sensitivity_beta.jl` explores the sensitivity of loss function (either the overall RMSD accross all data or the maximum RMSD for a single timecourse) to parameter changes. One parameter pair is systematically varied while keeping the rest constant. The resulting RMSD matrix is plotted and saved as a heatmap. This data was used to approximate selectivity confidences used in Figure 3C. This script can be run in the terminal with the following commands:

```bash
julia sensitivity_alpha.jl
julia sensitivity_beta.jl
```

### Timecourse visualization

`timecourses.ipynb` is a python notebook to visualize predicted timecourse data. This script was used to create timecourses in the format of Figure 4C. In addition, code is provided to run chimeric simulations that mix parameters from the alpha and beta fits (either single substitutions or cumulative substitutions along a steepest descent), which is used to create Figure 4D.
