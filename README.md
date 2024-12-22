# MATLAB code for Bluetooth Low Energy Separate Channel Fingerprinting dataset with Frequency-Scanned Antennas and Monopole

Matlab code for generating the .mat files and the figures for the calibration and test files from Open Dataset https://zenodo.org/records/10721783
These Matlab files allow the generation of the different figures and the .mat files with the calibration and test matrix to be employed later in Fingerprinting techniques. 
The files generate the matrix for the calibration and test procedure, employing the Frequency-Scanned Leaky Wave Antennas (FSLWA) and Monopole Antenna systems deployed. 

## Usage of the Matlab files
There are two main .m files
  - a_generate_calibration_matrix.m: for generating the .mat with the calibration files and for plotting the RSSI distribution figures of FSLWA and Monopoles acquired during the calibration day
  - b_generate_text_matrix.m: for generation of the .mat with the test files. It also plots the RSSI distribution figures of FSLWA and Monopoles acquired during each test day.

The .m files must be in the same folder as the downloaded folders with the data from the Zenodo repository.

  

