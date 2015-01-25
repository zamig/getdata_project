Getting and Cleaning Data Course Project 
========================================

In this project we use data from the "Human Activity Recognition Using Smartphones Dataset" to prepare tidy data that can be used for later analysis. That dataset is based on an experiments that have been carried out with 30 volunteers performing six activities, while wearing a smartphone on the waist. Using the smartphone's embedded accelerometer and gyroscope, various signals were captured and recorded. 

The dataset and full description of the of the experiments are available at the following site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The project includes the following files:

- 'README.md'
- 'run_analysis.R': The script that reads the data and prepares the tidy data.
- 'CodeBook.ms': Describtion of the variables in the tidy data.


## The run_analysis.R file

This is the R script that creates and writes to file the tidy dataset as per the project's requierments.

The script does the following according the the project's requirmenrs:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Replaces the labels of the activities with their names.
4. Relabels the data set with descriptive variable names. 
5. Creates a tidy data set with the average of each variable for each activity and each subject.


### Usage

The run_analysis.R is an R script and should be run without any arguments.


### Requiremnts to run the run_analysis.R script:

1. The reshape2 package needs to be installed.
2. The source data should be placed in the working directoy and should include the following files:

* ./train/X_train.txt: The features of the train set.
* ./test/X_test.txt: The features of the test set.
* ./features.txt: The list of features.
* ./train/subject_train.txt: The list of the subjects in the train set.
* ./test/subject_test.txt: The list of subjects in the test set.
* ./train/y_train.txt: The list of activity labels for the train set.
* ./test/y_test.txt: The list of activity labels for the test set.
* ./activity_labels.txt: Links the activity labels with their name.


## The output dataset

The avgDataSet dataset, which is written to file as "final_ds.txt", created in
the provided script contains the average of selected features from the
original data set. The averages are for each activity and each subject. Due to the length of the variable names, camelCase convention is used to make them more readible. The variables in the dataset are described in the CodeBook.md file. 

The dataset is in a wide form and meets the tidy data principle of [1]:
	
1. Each variable forms a column: The columns/variables of the dataset are the subjects, the activities of the subjects while carring out the experiment and 66 averages of 66 selected features measured in the experiment.

2. Each observation forms a row: Each row represents an observation, the averages of selected features that were derived from the sensor signals for one subject performing one of the six activities.

[1] Wickham, H., 2014. Tidy Data. Journal of Statistical Software, VV(II). Available at:
http://vita.had.co.nz/papers/tidy-data.pdf. 

### The selected features from the original data set

The features that were selected are only the measurements on the mean and standard deviation for each measurement in the experiment. These features where identified as having "mean()" or "std()" in their names, and all such variables were selected. 

Additional variables in the experiment were obtained by averaging the signals (such as gravityMean), but those variables were used to calculate the angle() features, and were not selected.