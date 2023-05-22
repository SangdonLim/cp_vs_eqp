# CP vs EQP

This is a class project I did for EDP 380D Applied Psychometrics in Spring 2020.

In psychometrics, a crosswalk table is a table that maps each possible score level in one instrument to corresponding scores in another instrument. Scores can be raw sum scores, T-scores, or theta scores.

The goal of my project was to compare the crosswalk tables produced by 1) calibrated projection and 2) equipercentile equating.

See the report and slides here:
- https://sangdonlim.github.io/cp_vs_eqp/report.html (report)
- https://sangdonlim.github.io/cp_vs_eqp/slides.html (slides)

These are also avilable in the `docs` folder.

The folders contain the following files:
- `data`: includes the input tables used in the report to demonstrate the implementation of calibrated projection method. Also includes item parameters used for the main simulation.
- `demo`: includes scripts used to demonstrate calibrated projection method. These make use of modules contained in the `modules` folder.
- `docs`: contains the report and the slide deck.
- `example`: contains an example script for running calibrated projection.
- `module`: includes an implementation of calibrated projection.
- `results`: includes raw output data from the main simulation.
- `simulation`: includes scripts for the main simulation.

The calibrated projection module used in this project was later implemented into an R package:
> PROsetta 0.2.0 - [CRAN link](https://CRAN.R-project.org/package=PROsetta)

The simulation design in this project also made its way into a publication:

> Schalet, B. D., Lim, S., Cella, D., Choi, S. W. (2021). Linking scores with patient-reported health outcome instruments: A validation study and comparison of three linking methods. *Psychometrika, 86*(3), 717-746. https://doi.org/10.1007/s11336-021-09776-z
