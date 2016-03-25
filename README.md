# Assignment: Getting and Cleaning Data Course Project
## Stephen Judd
*Project for the Coursera Course, Getting and Cleaning Data*

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set. *(data/cleaned.txt)*
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. *(data/averagebysubjectandactivity.txt)*

## Collection of original data
The original raw data was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on March 13, 2016 and extracted to the folder data/original/. 

See data/original/README.txt for details of the raw dataset - Human Activity Recognition Using Smartphones Dataset - Version 1.0 [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Creating the tidy data file
Creating the tidy data set is a multi-step process. The original data files contain separately, for test and training subjects, variable measures, subject identifier, variable names, and activity codes.

These steps are coded in the file *run_analysis.R*

1. Download and extract raw data to data/original
2. Read in data from original text files
  + X_test.txt contains measures for test subjects
  + Y_test.txt contains activity codes for test subjects
  + subject_test.txt contains subject numbers for test group
  + X_train.txt contains measures for training subjects
  + Y_train.txt contains activity codes for training subjects
  + subject_train.txt contains subject numbers for training group
3. Read measure names from file (features.txt) into vector
  + Vector includes feature numbering (every other item), so remove using logical vector to get just feature names
4. Use cleaned feature names to name columns in data frames
5. Add column with activity codes to both test and train data frames
6. Add column with subjects to both test and train data frames
7. Merge the training and the test sets to create one data set using rbind
8. Extract only columns with mean and std measures, subjects, and activity codes
  + Create vector of strngs to match to get only columns with mean and std measures
  + Use grepl to create logical vector of columns containing mean and std measures
  + Expand logical vector to keep columns for activitycode and subject
  + Extract only necessary columns:
9. Make activitycode a factor and assign descriptive names *("Walking", "Walking upstairs", "Walking downstairs", "Sitting", "Standing", "Laying")*
10. Make subject a factor
11. Load dplyr to make it easier to create second dataset with average of each variable by activity and subject
library(dplyr)
12. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
  + Group by subject and activity code 
  + Summarize data set using means
13. Write data frames to files in data folder *("data/cleaned.txt", "data/averagebysubjectandactivity.txt")*

## Data files
*  cleaned
  + Dimensions: 10299 x 68
                                                               
* averagebysubjectandactivity
 + Dimensions: 180 x 68

