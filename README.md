# NN_MPC
Neural network-based (NN) Model Predictive Control (MPC) algorithm to control a multi-agent system (MAS) with stochastic communication topology.

## Algorithm folder
Folder includes the NN-based MPC algorithm to achieve consensus in MAS for linear system, system with disturbances and nonlinear system.

### How to run algorithm
The main file is "WW20onlineMPC.m". In order to run uncomment line:

* Line 17 - "start_WW20_Fig1" to run linear system (based on Wang et al. (2018));
* Line 18 - "start_GL20_Fig3" to run system with disturbances (based on Gao et al. (2020));
* Line 19 - "start_ZH15" to run nonlinear system (motivated by Zhong et al. (2015)).

The output is the evolution of the system's states over time.

## Results folder
Includes the data (.mat) and the code to generate the graphs and tables.

### How to verify the results
The subfolder "results" contain all the data (.mat) shown in the Results section. It is organized according to the folder's names as follows:

* WW20: refers to the results of the linear system
* GL20: refers to the results of the system with disturbances
* ZH15: refers to the results of the nonlinear system

* Crossval: refers to the crossvalidation results
* Horizon: refers to the results for different horizons
* Pi_x: refers to the results with the transition matrix \Pi_x

To generate the graphics of state's progression over time, run "analysis.m". To generate the crossvalidation and horizon graphics, run "analysis_crossval.m".
