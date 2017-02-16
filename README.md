# Getting-and-Cleaning-Data-Assignment
This file was created in order to describe how the script works.
The script ,run_analysis.R does :
1)Download the dataset if it does not already exist in the working directory.
2)Load the activity labes and features from the dataset.
3)Moreover,load both the train and test datasets, keeping only those columns which are required for the mean or standard deviation.
4)Maybe the most important part of code,Load the activity and subject data for each dataset, and merges those columns with the dataset.
5)After all, merge the two datasets.
6)Converts the activity and subject columns to factors.
7)At the end, create a second, independent tidy data set with the average of each variable for each activity and each subject.
