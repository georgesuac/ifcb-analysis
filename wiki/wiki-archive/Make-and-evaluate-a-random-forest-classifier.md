For IFCB image classification, we currently using a random forest algorithm (a supervised machine learning approach described by [Breiman](http://link.springer.com/article/10.1023%2FA%3A1010933404324)). Because this is a supervised approach, it requires a training set of example images for each class. The classifier is constructed on the basis of "features" or properties of the images (not the images themselves). Steps for prerequisite image processing and feature extraction are described [here](./Blob-extraction,-feature-extraction,-and-classifier-application#Overview). 

## Create a training set of annotated (labeled by class) IFCB images

Manual identification of images into desired classes can be done with the "Manual Classify" interface developed in the Sosik laboratory. A tutorial for its use will be forthcoming; in the meantime, please contact us for instructions to get started; send email to hsosik@whoi.edu. If the whole ifcb-analysis repository has been cloned locally, manual classify interface should be ready to use. 

Start function for manual annotation of images:

/ifcb-analysis/manualclassify/startMC.m

This system produces output files that should be stored in a centralized, shared location for everyone contributing annotations for a data set (do not produce separate files in different locations as they will be difficult to integrate later if multiple annotators are working on the same sample files). A useful convention is to save them in a folder named 'manual' located as a project or data set subfolder.

**NOTE:** If you have trouble initiating startMC with your most recent configuration, try resetting with default (and then load your config from the menu and correct any errors):

**startMC('default')**

## Compile features for the training set

Once manual annotation is complete for an adequate number of images for each class, features must be compiled to produce the training data. Note: this presumes standard feature files have already been produced for the data set. This step is compiling feature results for the selected training images into one matrix.  

Start function where user must specify data access locations and parameters as input:

/ifcb-analysis/classification/compile_train_features_user_training.m

The function **compile_train_features_user_training** takes four to six input variables: 

1. string specifying local directory for manual annotation results from Manual Classify, 

2. string specifying local directory to access feature files, 

3. maximum number of example images to include for a class, 

4. minimum number of example images that must exist for a class to be included in the classifier, 

5. (optional) cell array containing a list of any classes that should not be included (use empty cell {} if none and case where class grouping option is used),

6. (optional) nested cell array containing list of any sets of classes that should be grouped together for the purposes of automated classification.

See example call by typing help on the MATLAB command line:

 &gt;&gt; **help compile_train_features_user_training**

**Note:** This function uses the simplest possible approach - random selection of maxn images from all manually annotated images in each class. Once a complex data set (or long time series) is available, more complicated approaches for selection will likely provide better results. [There are other scripts in the code base for stratified random over time, for instance.]

**Note:** If any classes are grouped, the resulting new (grouped) class label must be added to the list of classes to display in Manual Classify if there is a need to display results starting from classifier output, including the grouped class (otherwise images in the group class will be diverted to the default class for display). 

## Train (make) the classifier

Once features are compiled, it is simple to construct a classifier. 

Start function where user must specify data access locations and number of trees as input:

/ifcb-analysis/classification/make_TreeBaggerClassifier_user_training.m

The function **make_TreeBaggerClassifier_user_training** takes four input variables: 

1. string specifying local directory for compiled training set (features) and classifier output, 

2. string specifying name of file that contains your training features, 

3. string specifying leading characters of the file name for the saved classifier (the leading characters will be automatically appended with current date), 

4. number of decision trees to include in the assemblage (forest). 

See example call by typing help on the MATLAB command line:

 &gt;&gt; **help make_TreeBaggerClassifier_user_training**

**Note:** Construct enough trees to ensure that the "out-of-bag" error rate is approaching the asymptotic value (see Figure 1 produced by classifier_oob_analysis described below). But avoid more than needed to avoid excessively large classifier files on disk and unnecessarily slow application to unknowns.

## Evaluate the classifier

At the end of making you classifier with make_TreeBaggerClassifier_user_training.m, a series of evaluation graphs and statistics are displayed. Those can be recreated at any time by running this function:

/ifcb-analysis/classification/classifier_oob_analysis.m

The function **classifier_oob_analysis** takes one input variable: 

1. string specifying complete location of classifier (directory and filename)

See example call by typing help on the MATLAB command line:

 &gt;&gt; **help classifier_oob_analysis**