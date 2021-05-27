--------------------------------------------------------------------------
Calcium imaging analysis for Hernandez-Nunez et al 2021 Science Advances
Author: Luis Hernandez Nunez
Questions: luishernandeznunez@fas.harvard.edu
--------------------------------------------------------------------------

Data Collection:

Data was collected using a spinning disk confocal microscope, using Nikon software and storing time lapse volumes using the .nd2 format.

The data processing scripts work in MATLAB 2016b with all toolboxes installed and likely also works with posterior MATLAB versions. 

Data Extraction and Motion Correction:

Script 1 is a matlab script that reads the microscope .nd2 files transforms them into matrices and saves them as a .tiff volume in a format that can be read by the Motion Correction package (MoCo) (Dubbs, A., Guevara, J. and Yuste, R., 2016. moco: Fast motion correction for calcium imaging. Frontiers in neuroinformatics, 10, p.6.) 

Functional Image Analysis:

Script 2 is a matlab script that with the output of the motion-corrected data uses the CNMF algorithm to denoise and demix neural activity. This script requires setting tha MATLAB path to the CNMF toolbox published by the Paninski lab (Pnevmatikakis, E.A., Soudry, D., Gao, Y., Machado, T.A., Merel, J., Pfau, D., Reardon, T., Mu, Y., Lacefield, C., Yang, W. and Ahrens, M., 2016. Simultaneous denoising, deconvolution, and demixing of calcium imaging data. Neuron, 89(2), pp.285-299.).

Plotting results:

Script 3 plots the preprocessed calcium responses of WCs and CCs that appear in Figs. 1,2,4 and 8 in the manuscript.


