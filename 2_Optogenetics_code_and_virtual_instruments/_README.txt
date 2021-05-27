--------------------------------------------------------------------------
Optogenetics setup VI and code for Hernandez-Nunez et al 2021 Science Advances
Author: Luis Hernandez Nunez
Questions: luishernandeznunez@fas.harvard.edu
--------------------------------------------------------------------------

The software released here requires the hardware specified in the Methods and Extended Methods
of the manuscript, with previous installation of the drivers of the CCD camera, LabJackU3, and 
NIDAQs.

The Labview VIs also require opencv and the NI Development Module to be installed previously.

The code functions in LabVIEW 2014 and likely also in later versions.

Most of the image acquisition code is modified from an earlier version published by the Samuel Lab in (Gershow, M., Berck, M., Mathew, D., Luo, L., Kane, E.A., Carlson, J.R. and Samuel, A.D., 2012. Controlling airborne cues to study small animal navigation. Nature methods, 9(3), pp.290-296.) 

The most susbstantial updates we made here are to control a panel of red LEDs and generate waveforms and white noise of red light intensity.

The LED_CONTROL_2.vi calls all other functions/code/subVIs in this folder. 

Within LED_CONTROL_2 separate user friendly modules allow image acquisition and synchronous red light stimulus delivery.


