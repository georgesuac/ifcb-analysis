# ifcb-analysis (modified)

This is a modified copy of hsosik/ifcb-analysis, originally developed by Heidi M. Sosik, Joe Futrelle, and contributors.

Original repository:

https://github.com/hsosik/ifcb-analysis

Modifications:

- Fixed compatibility issue with DIPUM invmoments by converting blob masks to double in bin_features.m

- Verified working on MATLAB R2026a (Apple Silicon)

Description:

This is a set of MATLAB routines for analysis of data from Imaging FlowCytobot. There are steps for image processing, segmentation (to separate background image pixels from those that correspond to objects of interest), feature extraction, and classification. There are also tools for manually annotating large numbers of images and for constructing training sets and classifiers. 

More details and instructions for analysis can be found here:

https://github.com/hsosik/ifcb-analysis/wiki
