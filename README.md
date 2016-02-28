# Getting-and-Cleaning-Data-Course-Project
README
=================================

This file provides a step-by-step guide for the run_analysis.R program used to construct the “average” dataset from raw files provided by the Human Activity Recognition study.

Lines 1 - 9: 
Remove currently existing objects in the environment and set the work directory.  Note that the file path for the work directory must be updated when the code is re-run on a different computer.

Lines 11 - 12:
Read the complete list of feature names included in the X_train and X_test datasets.

Lines 14 - 21:
Read in the raw files to construct the train dataset.  The code combines the X_train, y_train, and subject_train dataset to create one dataset named “training_set” with 7,352 observations and 564 variables.  The variables are renamed according to the feature names constructed in lines 11 - 12, changed to lower case.  The code also constructs a variable that identifies the source of the observations as the training dataset.

Lines 23 - 30:
Perform the same operations as lines 14 - 21 to create the “test_set” dataset with 2,947 observations and 564 variables.  The code also constructs a variable that identifies the source of the observations as the test dataset.

Lines 32 - 36:
The code stacks the training set and the test set to create a “stacked” dataset with 10,299 observations and 564 variables.  The variable names are then renamed again to ensure compliance with the feature names constructed in lines 11 - 12, changed to lower case.

Lines 38 - 49:
Use the feature names constructed in lines 11 - 12 to identify variables that pertain only to mean and standard deviation and limit the stacked dataset to only these variables.  The code uses the grepl function to identify whether a variable name contains the word “mean” or “std”.  The limited dataset is named “stacked2”.

Lines 51 - 57:
Import the “activity_labels.txt” dataset and merge it with the “stacked2” dataset to create the “stacked3” dataset, which contains descriptive activity names instead of a simple activity code included in the “stacked2” dataset.

Lines 68 - 75:
Use the aggregate function to calculate the average of each variable for each Subject ID and Activity included in the study.  The final dataset is named “average” and is exported to a cvs file with the same name.












