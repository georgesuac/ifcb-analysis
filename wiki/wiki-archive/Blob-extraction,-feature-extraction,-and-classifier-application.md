## Overview

This is a quick summary of current steps for IFCB image processing and classification for the case of data being accessed locally (i.e., not from IFCB Dashboard web services), and all processing and products being initiated manually via batch jobs run in MATLAB. 

Prior to following the instructions below, be sure to [get the code](./#how-to-get-the-code) and add all the local clone ifcb-analysis folders to your [MATLAB search path](http://www.mathworks.com/help/matlab/matlab_env/what-is-the-matlab-search-path.html). As indicated in the [requirements](./#requirements) section, some toolboxes are necessary, and these must also be on the MATLAB search path. 

The major processing steps are 

1. [blob extraction](#instructions-for-blob-extraction) 

1. [feature extraction](#instructions-for-feature-extraction)

1. [classifier application](#instructions-for-classifier-application) (presumes a classifier already exists).

These steps must be run in this order. 

You may also find some useful options here:

   [summarize classifier output](#summarize-random-forest-classification-results-by-class)

## Access to test data and products

Any IFCB data can be analyzed following these steps, but these instructions are initially posed for new users analyzing a local copy of the "user_training_test_data" that can be downloaded here:

[Test data](https://www.dropbox.com/s/raketv3gge8z7gr/user_training_test_data.zip?dl=0)

Example products and output are available here:

[Test data with products](https://www.dropbox.com/s/5u30o0ddam2ckhb/user_training_test_data_example_products.zip?dl=0)

NOTE: These links point to relatively large zip files (~1 GB).

## Instructions for blob extraction

Blob images (B&W masks specifying location of target in image) are computed and stored on disk. The results are stored as png format images in zip files (one for each bin or roi file). Once the blob zip files exist, they can be accessed via web service for next steps in the processing or for manual inspection of the masks.

Start function where user must specify data access locations as input:

/ifcb-analysis/feature_extraction/blob_extraction/start_blob_batch_user_training.m

The function **start_blob_batch_user_training** takes three input variables: 

1. string specifying local directory for raw data, 

2. string specifying local directory to store the blob output, 

3. false or true to optionally dis/enable parallel computing (default = false).

See example call by typing help on the MATLAB command line:

 &gt;&gt; **help start_blob_batch_user_training**

## Instructions for feature extraction

For each target a range of features are computed, some from the original images and some from the B&W blob images. Both image types are accessed and features are stored in local directories (currently all files for a year in one folder). Blob extraction must be completed before feature extraction. 

**NOTE:** This step involves one MEX file and the version provided is compiled for 64-bit windows:

/ifcb-analysis/feature_extraction/ModHausdorffDistMex.mexw64

If you are using another operating system, compile the original cpp file available from here:

http://www.mathworks.com/matlabcentral/fileexchange/30108-mex-modified-hausdorff-distance-for-2d-point-sets

Start function where user must specify data access locations as input:

/ifcb-analysis/feature_extraction/batch_features_bins/start_feature_batch_user_training.m

Complete blob extraction first.

The function **start_feature_batch_user_training** takes four input variables: 

1. string specifying local directory for raw data

1. string specifying local directory to find the blob files

1. string specifying local directory to output the feature files

1. false or true to optionally dis/enable parallel computing (default = false).

See example call by typing help on the MATLAB command line:

 &gt;&gt; **help start_feature_batch_user_training**

### Some documentation of feature output file content can be found [here](./feature-file-documentation).

## Instructions for classifier application

We are currently using a random forest algorithm (a supervised machine learning approach described by [Breiman](http://link.springer.com/article/10.1023%2FA%3A1010933404324)). These instructions presume you have already built and evaluated a classifier (as described [here](./make-and-evaluate-a-random-forest-classifier)).

For each image target a set of features is presented to the random forest classifier (created with training set and MATLAB treebagger function) to generate classifications and associated scores. Feature extraction must be completed before classification can be done. The code will currently skip any data for which features do not exist. 

Start function where user must specify data access locations and classifier to apply as input:

/ifcb-analysis/classification/batch_classification/start_classify_batch_user_training.m

Complete feature extraction first.

Produce and store (and evaluate!) a random forest classifier first. See instructions [here](./make-and-evaluate-a-random-forest-classifier) if you need to make a classifier:

The function **start_classify_batch_user_training** takes three inputs: 

1. classifier file (full path)

1. string specifying location of feature files

1. string specifying location of output files from classification.

This function only processes data for which features exist in the specified directory (feapath) and it will skip processing for cases where class files already exist. Hence it can be run repeatedly with no changes and, if new data is available, only it will be processed.

See example call by typing help on the MATLAB command line:

 &gt;&gt; **help start_classify_batch_user_training**


## Summarize random forest classification results by class

Once a set of classifier output files exist, they are summarized (in one mat-file) according to the number of targets identified in each class for each time point. Results are reported counting each target's winning class as the one with the highest score, and also counting only those targets whose highest score exceeds the threshold for maximum accuracy for that class (if not, the target counted as "unclassified").

Start function where user must specify data access locations as input:

/ifcb-analysis/classification/countcells_allTBnew_user_training.m

The function **countcells_allTBnew_user_training** takes three inputs: 

1. string specifying location of class files with 'xxxx' replacing any 4-digit year if not fixed for data set

1. string specifying location of raw data (*.hdr files)

1. year or range of years to summarize

Default output is stored in 'summary_allTB.mat' in the subdirectory called 'summary' in the same location as the input class files.

See example call by typing help on the MATLAB command line:

 &gt;&gt; **help countcells_allTBnew_user_training**