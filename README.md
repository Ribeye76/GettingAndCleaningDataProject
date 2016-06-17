# GettingAndCleaningDataProject
Getting and Cleaning Data Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, run_analysis.R, does the following:

1. Call required libraries
2. Download and unzip the dataset if it does not already exist
2. Load the activity and feature info
3. Extract data of mean and standard deviation into featuresMeanStd
4. Extract and arrange column names of mean and standard deviation into featuresMeanStd.names
5. Load datasets train and test, filter data with featuresMeanStd
6. Add subjets and activities information and join them in two datasets: train and test
7. Join datasets train and test, and add labels
8. Turn subjects into factors
9. Turn activities into factors and add labels
10. Melt dataset to arrange variables in rows
11. Summarize table to obtain an independent tidy data set with the average for each variable for each activity and each subject.

The end result is shown in the file tidy.txt.
