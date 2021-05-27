--------------------------------------------------------------------------
Temperature control VI and code for Hernandez-Nunez et al 2021 Science Advances
Author: Luis Hernandez Nunez
Questions: luishernandeznunez@fas.harvard.edu
--------------------------------------------------------------------------

The software released here requires the hardware specified in the Methods and Extended Methods
of the manuscript, with previous installation of the drivers of the PID controllers, CCD camera, LabJackU3, and NIDAQs.

The Labview VIs also require opencv and the NI Development Module to be installed previously.

The code functions in LabVIEW 2014 and likely also in later versions.

The VI used for image acquisition is the same one used in the 2_Optogenetics_code_and_virtual_instruments folder.

The LabVIEW virtual instruments used for temperature control are an updated version of the ones introduced in Klein, M., Afonso, B., Vonner, A.J., Hernandez-Nunez, L., Berck, M., Tabone, C.J., Kane, E.A., Pieribone, V.A., Nitabach, M.N., Cardona,A. Zlatic, M., and Samuel A.D.T. 2015. Sensory determinants of behavioral dynamics in Drosophila thermotaxis. Proceedings of the National Academy of Sciences, 112(2), pp.E220-E229..

The Temperature_Control_07092019 calls all other functions/code/subVIs in this folder. 

Within Temperature_Control_07092019 different modes of temperature control are possible. As described in the Supplementary Material, here we use the 'from file' function to input custom created inputs. The inputs are created using an ARMAX model fitted to the temperature input-output of the control system as described in Supplementary Fig.6. An example on how to fit an ARMAX model can be found in the script Script_ARMAX_example.m


