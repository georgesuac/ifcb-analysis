# ifcb-analysis (modified)

This is a modified copy of hsosik/ifcb-analysis, originally developed by Heidi M. Sosik, Joe Futrelle, and contributors.

Modifications:

- Fixed compatibility issue with [**DIPUM 3.0.0**](https://github.com/dipum/dipum-toolbox/releases/tag/v3.0.0) invmoments by converting blob masks to double in bin_features.m (see dev_notes.txt)

- Verified working on MATLAB R2026a (Apple Silicon)

Description:

This is a set of MATLAB routines for analysis of data from Imaging FlowCytobot. There are steps for image processing, segmentation (to separate background image pixels from those that correspond to objects of interest), feature extraction, and classification. There are also tools for manually annotating large numbers of images and for constructing training sets and classifiers. 


Original repository:
https://github.com/hsosik/ifcb-analysis

More details and instructions for analysis can be found here:
https://github.com/hsosik/ifcb-analysis/wiki
