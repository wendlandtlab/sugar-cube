# Simulation data and analysis scripts

### Introduction

This directory contains experimental kinetic data for alpha and beta methyl pyranoside epimerization, as well as scripts used to fit rate constants and analyze the quality of the fit. Python notebooks are provided for approximating catalyst deactivation using multiple reagent dose timecourse data, and for visualizing the predicted timecourse data. Julia scripts are provided for fitting training data with differential evolution followed by local optimization, calculating the loss function against all data, and approximating the sensitivity to parameter changes.

### Experimental data

Data from the kinetic experiments. Files contain collated experiments separated by sugar type (alpha vs beta) and whether test data is excluded or included. See SI section 4.2 for experimental details. Each file contains the following columns:

- `Run`: the run number
- `Time` (s): time in seconds
- `Sugar Abbreviation` (mol %): mol % of a given sugar

### Catalyst deactivation

`catalyst_deactivation.ipynb` python notebook for approximating catalyst deactivation using multidose timecourse data from `catalyst_deactivation_data.xlsx`. See SI section 4.4 for experimental details. Catalyst deactivation is roughly approximated as an irreversible first order reaction.

### fit_alpha/beta.jl

These scripts fit either the alpha or beta training set data and prints the results to console. The fitting process uses differential evolution for the global search followed by local optimization. The final parameters are printed to console. The results from this study are saved to `alpha_fitting.txt` or `beta_fitting.txt`. These scripts can be run in the terminal with the following command (in this case using 128 threads):

```bash
julia --threads 128 fit_alpha.jl
```

```bash
julia --threads 128 fit_beta.jl
```

### fit_quality.jl

This file calculates the loss function against all data and prints the results to console. Additionally, graphs comparing simulated to experimental data are generated and saved to png; by default these graphs plot experimental data as blue dots and simulated data in grey. This script can be run in the terminal with the following command:

```bash
julia fit_quality.jl
```

### sensitivity_(alpha/beta).jl

This file approximates the sensitivity of RMSD (either overall RMSD or the maximum RMSD for each experiment) to parameter changes. One parameter pair is systematically varied while keeping the rest constant. The resulting RMSD matrix is plotted and saved as a heatmap. This data was used to approximate selectivity confidences used in Figure 3C. This script can be run in the terminal with the following command:

```bash
julia sensitivity_alpha.jl
```

```bash
julia sensitivity_beta.jl
```