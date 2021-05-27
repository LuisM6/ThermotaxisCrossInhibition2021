----------------------------------------------------------------------------------------
Behavioral sequence classification code for Hernandez-Nunez et al 2021 Science Advances
Author: Luis Hernandez Nunez
Questions: luishernandeznunez@fas.harvard.edu
----------------------------------------------------------------------------------------

Data Collection:

Data was collected in the thermotaxis behavior rig described in Methods, using the control strategy of Supplementary Fig. 8.

The movies were transformed in larval coordinates and contours using MAGAT Analyzer (https://github.com/samuellab/MAGATAnalyzer). 

Dissimilarity matrix construction and dimensinality reduction:

The PreProcessing_And_Dimensinonality_Reduction.m script uses the output of MAGAT Analyzer to compute 8 behavioral metrics over time per animal and then uses the output to compute a dissimilarity matrix. Then dimensinoality reduction is conducted and the output is saved.

The output of the PreProcessing_And_Dimensinonality_Reduction.m script is the input to the iterative denoising trees algorithm, implemented in R. This algorithm was published in Vogelstein, J.T., Park, Y., Ohyama, T., Kerr, R.A., Truman, J.W., Priebe, C.E. and Zlatic, M., 2014. Discovery of brainwide neural-behavioral maps via multiscale unsupervised structure learning. Science, 344(6182), pp.386-392.

Behaviotypes analysis:

The output of the iterative denoising trees is then analyzed and used to plot the Supp Figs 7 and 8, and to make movies of each behaviotype using the script Movies_and_Supp_Analysis_of_Behaviotypes.m

Dynamics of behaviotypes:

The differences in behavioral dynamics of each behaviotype can be clearly observed when plotting the dynamics of their 8 behavioral descriptors over time. The script Dynamics_of_behaviotypes.m recalculates and plots the dynamics of the 8 behavioral descriptors for each behaviotype. 

Since, for space reasons the dynamics of each behaviotype are not shown in the manuscript, they are saved in this folder, the figures are labeled Behaviotype_1.fig to Behaviotype_16.fig and can be openes in any MATLAB release posterior to 2014a.

