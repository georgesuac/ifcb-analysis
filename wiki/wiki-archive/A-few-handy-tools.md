## Summarize counts by class from manual annotations

Once a set of manual annotation files exist, they can be summarized (in one mat-file) according to the number of targets identified in each class for each time point. 

Start function where user must specify data access locations as input:

/ifcb-analysis/analyze_by_class/countcells_manual_user_training.m

The function **countcells_manual_user_training** takes two inputs: 

1. string specifying location of manual annotation files

1. string specifying location of raw data (*.hdr files)

Default output is stored in 'count_manual_DDDDDDDDD.mat' in the subdirectory called 'summary' in the same location as the manual result files, and where 'DDDDDDDDD' is replaced by a string specifying the date on which the file is saved.

See example call by typing help on the MATLAB command line:

 &gt;&gt; **help countcells_manual_user_training**

## Find the volume sampled in milliliters for one or more IFCB files

Use the function **IFCB_volume_analyzed**, which accepts as input one file name (either full path on disk or web services URL) or a list of file names (in which as the output is a vector of the same length)

For example, like this for one file on your local disk: 

ml = IFCB_volume_analyzed( 'C:\work\IFCB\user_training_test_data\data\2014\D20141118\D20141118T234705_IFCB102.hdr' )

Or like this for a file via web services (try this one if you are on the internet; it will work since ifcb-data.whoi.edu is public): 

ml = IFCB_volume_analyzed( 'http://ifcb-data.whoi.edu/IFCB102_PiscesNov2014\D20141118T234705_IFCB102.hdr' )

Or like this for as many files as you want all at once:

myfiles = { 'http://ifcb-data.whoi.edu/IFCB102_PiscesNov2014/D20141118T234705_IFCB102.hdr'; 'http://ifcb-data.whoi.edu/IFCB102_PiscesNov2014/D20141106T132705_IFCB102.hdr' }

ml = IFCB_volume_analyzed( myfiles )

## Extract the date and time from a sample file name and convert it to MATLAB serial date numbers (for convenient plotting, for instance)

Use the function **IFCB_file2date**, which accepts as input one file name or a list of file names (in which as the output is a vector of the same length)

Like this for one file at a time:

IFCB_file2date( 'D20141118T234705_IFCB102' )

Or input a list of file names:

myfiles = { 'D20141118T234705_IFCB102'; 'D20141106T132705_IFCB102' }

IFCB_file2date( myfiles  )

