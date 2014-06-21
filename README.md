datasciencecoursera
===================

Course Data Science Specialization Work


Getting and Cleaning Data
=========================

The run_analysis.R was created to process data collected from Samsung phones.
The code in the file is commented to explain how the data was combined and cleaned.

The first goal was to produce one combinded data set of from participants in the training and test sets.

The code maps labels for "WALKING", "WALKING_UPSTAIRS", etc. to the activities that are numbered 1-6.
The code combines the ids of participants to the test data and matches the labels to the test and training data.
The code combines the test and training data into one large data frame called allData.


The second goal was to produce a tidy data set of the average of select variables grouped by activity and individual.

The data frame, allData, is filtered to extract features that contain "mean()" and "std()" in the variable names.
(mean and standard deviation measurements)
A new data frame, tidyData, is created with the 66 features that match mean() and std() using a regex.
tidyData contains the average of the mean() and std() variables for each activity and each subject.
