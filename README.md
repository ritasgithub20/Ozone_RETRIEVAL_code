***********************************
README for the new retrieval setup
***********************************

Created by RITA KAJTAR * 10.09.2020 

***********************************

The following files and directories are to be stored in the same parent directory:
(the user creates a working directory named 'MIRA_AOS_Files') 

- the main script 'MIRAaos2oem.m' 

- the two directories containing ECMWF data required by the forward model, 'ECMWF_tfiles'
  and 'ECMWF_zfiles', respectively 

- the directory called 'MIRAaos2oem'. This directory is copied separately by the program for 
  each measurement and pasted under the measurement's own path. 'MIRAaos2oem' 
  contains the following subdirectories: - 'data' with corresponding subdirectories 
                                           'general' (where the line catalogue and retrieval p_grid  
                                            are stored - these are required by the forward model) and 
                                           'profiles' where data needed for simulating different 
                                            atmospheric scenarios are stored - for Ozone both FASCOD 
                                            and MIPAS data are available, whereas for all secondary 
                                            species, only FASCOD data are' available)
                                         - 'output', which initially is an empty directory, but will 
                                            be filled with the retrieval products
                                         -  ARTS control file MIRAaos2oem.arts

- all AOSData***.mat files to be processed 
	OBS1: the program will only process (in alphabetical order) the .mat files
	      that it finds in the parent directory
	OBS2: it is important that these are the only .mat files contained in the parent  
              directory, including all its subdirectories, in order to not confuse the 
              program which at the start creates a list of detected .mat files in the 
              parent directory to be subsequently processed

**********************************

!!! The user will want to adapt the 'read_wrapper_ini.txt' file with the correct paths corresponding 
to their own system before running the program. 

**********************************

The retrieval program creates subdirectories based on the date of each measurements, as follows: 
year -> month -> day -> hour. 
'hour' will contain subdirectories 'data' and 'output', described above, AND 'input', which is created 
while the program is running and contains the files y.xml, f_backend.xml, ecmwf_t.xml and ecmwf_z.xml 
corresponding to the processed measurement and which are all required by the forward model. 

********************************** 

The program creates an L2 structure for each processed measurement and saves all L2 structures
in a directory called OEM2L2_struct which is stored on the same level as the parent directory, 
MIRA_AOS_Files. 

********************************** 

A temporary directory is created on-the-fly for each measurement and can be accessed from Matlab's workspace 
by pausing the program. (this part needs more info :)

********************************** 

All plotting settings can be manipulated in the function 'myO3_profile.m'. 

********************************** 
