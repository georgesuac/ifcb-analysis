# Running ifcb-analysis on macOS:
Clone the current ifcb-analysis [repository](https://github.com/georgesuac/ifcb-analysis) on your computer.
## Setting up MATLAB
Install MATLAB and the required add-ons in (Home tab -> Add-Ons -> Explore Add-Ons) 
- MATLAB Image Processing Toolbox
- MATLAB Deep Learning Toolbox
- MATLAB Statistics Toolbox
- MATLAB Curve Fitting Toolbox
- MATLAB Parallel Computing Toolbox

- The DIPUM toolbox 3.0.0 (can be downloaded [here](https://github.com/dipum/dipum-toolbox/releases/tag/v3.0.0))

**Compiling ModHausdorffDistMex.cpp**
Download the original ModHausdorffDistMex.cpp file available from [here](http://www.mathworks.com/matlabcentral/fileexchange/30108-mex-modified-hausdorff-distance-for-2d-point-sets). And save it in the ifcb-analysis directory.

Open the ifcb-analysis directory in MATLAB: 
```
cd /path/to/ifcb-analysis
```
and compile MEX file (Apple Silicon / macOS)
```
mex ModHausdorffDistMex.cpp
```
confirm installation
```
which ModHausdorffDistMex
```
*If any trouble, check the troubleshooting notes at the end of this document.*

==You are now ready to start processing data.==

## Create folders, prepare IFCB data, and initialize the MATLAB environment
Create a new project folder in the 'Data' folder. Inside, create a new 'RAW_data' folder containing the IFCB data. Then, create a new project folder in the 'Scripts' folder. Each project should have two important scripts: **blob_extraction.m** and **feature_extraction.m**
Make sure to use the same name in both cases.

Check the 00_template scripts as a reference.

**Initialize the MATLAB environment**
Run setup_ifcb_analysis.m ==at the start of every MATLAB session:==
```
setup_ifcb_analysis
```
If all toolboxes are available and paths are correctly configured, you should see: *'Setup complete.'*
#### Run blob_extraction script 
Edit the path directories in 'blob_extraction.m' as needed:
```
% ==== USER INPUT (select) ====

project_name = '00_template'; % folder name inside 'Data'

enable_parallel = false; % set to true after testing

% ====================================

```

inside the Scripts/your-project-folder, run:
```
blob_extraction
```
The results will be stored in a new 'blob_extraction' folder. If files cannot be found (Processing 0 files), run 'setup_ifcb_analysis' again (see above).
## Run feature_extraction script (edit the path directories as needed)
After blob_extraction.m has been completed, edit the path directories in 'feature_extraction.m' as needed:
```
% ==== USER INPUT (edit only this) ====

project_name = '01_Microcosms_Ishigaki_2023'; % folder name inside 'Data'

enable_parallel = false; % set to true after testing

% ====================================
```


inside the Scripts/project folder, run:
```
feature_extraction
```
The results will be stored in a new 'feature_extraction' folder.



# Troubleshooting
## Folder structure should look like this
Do not change the folder structure. Use this hierarchy based on the '00_template' project:
```
ifcb-analysis/
├── setup_ifcb_analysis.m
├── ModHausdorffDistMex.cpp
├── ModHausdorffDistMex.mexmaca64
├── feature_extraction/
├── Data/
│   └── 00_template/
│       ├── RAW_data/
│       │   └── DYYYYMMDD/
│       │       ├── DYYYYMMDDThhmmss_IFCB108.adc
│       │       ├── DYYYYMMDDThhmmss_IFCB108.hdr
│       │       └── DYYYYMMDDThhmmss_IFCB108.roi
│       ├── blob_output/
│       └── feature_output/
└── Scripts/
    └── 00_template/
        ├── blob_extraction.m
        └── feature_extraction.m
```

## If there is a problem during the installation/compilation of ModHausdorffDistMex
Usually the case in Silicon mac computers:

*symbol(s) not found for architecture arm64 clang++: error: linker command failed with exit code 1 (use -v to see invocation)*

It was a known Apple Clang / Xcode Command Line Tools linker issue on macOS arm64, where the link step fails with missing MEX adapter symbols (_mexCreateMexFunction, _mexDestroyMexFunction, _mexFunctionAdapter). A documented workaround is to force the classic linker by adding -ld_classic to the link flags as follows:

After making sure you are in the correct folder, make sure the C++ MEX toolchain is selected (not just C), run:
```
mex -setup C++
```

Then, compile using the classic linker workaround:
```
mex LINKFLAGS='$LINKFLAGS -ld_classic' ModHausdorffDistMex.cpp
```

If it doesn’t work, try:
```
mex LDFLAGS='$LDFLAGS -ld_classic' ModHausdorffDistMex.cpp
```

After a successful build, verify it compiles:
```
which ModHausdorffDistMex
```

## If files cannot be found during blob or feature extraction (Processing 0 files)
Make sure the files exist, then, from the root ifcb-analysis directory on MATLAB, run:
```
setup_ifcb_analysis
```
If it doesn't work, restart MATLAB and try again.

Alternative:

Make sure that the ifcb-analysis directory and subdirectories are on the path. In the Command Window (MATLAB), run the following commands (*edit the paths accordingly*):
```
restoredefaultpath
rehash toolboxcache

addpath(genpath('/path/to/ifcb-analysis'))
addpath(genpath('/path/to/DIPUM Toolbox'))

savepath
```
If you don't know the **DIPUM Toolbox directory path**, run:
```
fileparts(which('invmoments'))
```
