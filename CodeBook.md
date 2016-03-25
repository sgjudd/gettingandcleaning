# Getting and Cleaning Data Course Project CodeBook
## Stephen Judd - March 2016

## Project Description
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
  + Summary:
   tBodyAcc-mean()-X tBodyAcc-mean()-Y  tBodyAcc-mean()-Z  tBodyAcc-std()-X  tBodyAcc-std()-Y   tBodyAcc-std()-Z  tGravityAcc-mean()-X
 Min.   :-1.0000   Min.   :-1.00000   Min.   :-1.00000   Min.   :-1.0000   Min.   :-1.00000   Min.   :-1.0000   Min.   :-1.0000     
 1st Qu.: 0.2626   1st Qu.:-0.02490   1st Qu.:-0.12102   1st Qu.:-0.9924   1st Qu.:-0.97699   1st Qu.:-0.9791   1st Qu.: 0.8117     
 Median : 0.2772   Median :-0.01716   Median :-0.10860   Median :-0.9430   Median :-0.83503   Median :-0.8508   Median : 0.9218     
 Mean   : 0.2743   Mean   :-0.01774   Mean   :-0.10892   Mean   :-0.6078   Mean   :-0.51019   Mean   :-0.6131   Mean   : 0.6692     
 3rd Qu.: 0.2884   3rd Qu.:-0.01062   3rd Qu.:-0.09759   3rd Qu.:-0.2503   3rd Qu.:-0.05734   3rd Qu.:-0.2787   3rd Qu.: 0.9547     
 Max.   : 1.0000   Max.   : 1.00000   Max.   : 1.00000   Max.   : 1.0000   Max.   : 1.00000   Max.   : 1.0000   Max.   : 1.0000     
                                                                                                                                    
 tGravityAcc-mean()-Y tGravityAcc-mean()-Z tGravityAcc-std()-X tGravityAcc-std()-Y tGravityAcc-std()-Z tBodyAccJerk-mean()-X
 Min.   :-1.000000    Min.   :-1.00000     Min.   :-1.0000     Min.   :-1.0000     Min.   :-1.0000     Min.   :-1.00000     
 1st Qu.:-0.242943    1st Qu.:-0.11671     1st Qu.:-0.9949     1st Qu.:-0.9913     1st Qu.:-0.9866     1st Qu.: 0.06298     
 Median :-0.143551    Median : 0.03680     Median :-0.9819     Median :-0.9759     Median :-0.9665     Median : 0.07597     
 Mean   : 0.004039    Mean   : 0.09215     Mean   :-0.9652     Mean   :-0.9544     Mean   :-0.9389     Mean   : 0.07894     
 3rd Qu.: 0.118905    3rd Qu.: 0.21621     3rd Qu.:-0.9615     3rd Qu.:-0.9464     3rd Qu.:-0.9296     3rd Qu.: 0.09131     
 Max.   : 1.000000    Max.   : 1.00000     Max.   : 1.0000     Max.   : 1.0000     Max.   : 1.0000     Max.   : 1.00000     
                                                                                                                            
 tBodyAccJerk-mean()-Y tBodyAccJerk-mean()-Z tBodyAccJerk-std()-X tBodyAccJerk-std()-Y tBodyAccJerk-std()-Z tBodyGyro-mean()-X
 Min.   :-1.000000     Min.   :-1.000000     Min.   :-1.0000      Min.   :-1.0000      Min.   :-1.0000      Min.   :-1.00000  
 1st Qu.:-0.018555     1st Qu.:-0.031552     1st Qu.:-0.9913      1st Qu.:-0.9850      1st Qu.:-0.9892      1st Qu.:-0.04579  
 Median : 0.010753     Median :-0.001159     Median :-0.9513      Median :-0.9250      Median :-0.9543      Median :-0.02776  
 Mean   : 0.007948     Mean   :-0.004675     Mean   :-0.6398      Mean   :-0.6080      Mean   :-0.7628      Mean   :-0.03098  
 3rd Qu.: 0.033538     3rd Qu.: 0.024578     3rd Qu.:-0.2912      3rd Qu.:-0.2218      3rd Qu.:-0.5485      3rd Qu.:-0.01058  
 Max.   : 1.000000     Max.   : 1.000000     Max.   : 1.0000      Max.   : 1.0000      Max.   : 1.0000      Max.   : 1.00000  
                                                                                                                              
 tBodyGyro-mean()-Y tBodyGyro-mean()-Z tBodyGyro-std()-X tBodyGyro-std()-Y tBodyGyro-std()-Z tBodyGyroJerk-mean()-X tBodyGyroJerk-mean()-Y
 Min.   :-1.00000   Min.   :-1.00000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.00000       Min.   :-1.00000      
 1st Qu.:-0.10399   1st Qu.: 0.06485   1st Qu.:-0.9872   1st Qu.:-0.9819   1st Qu.:-0.9850   1st Qu.:-0.11723       1st Qu.:-0.05868      
 Median :-0.07477   Median : 0.08626   Median :-0.9016   Median :-0.9106   Median :-0.8819   Median :-0.09824       Median :-0.04056      
 Mean   :-0.07472   Mean   : 0.08836   Mean   :-0.7212   Mean   :-0.6827   Mean   :-0.6537   Mean   :-0.09671       Mean   :-0.04232      
 3rd Qu.:-0.05110   3rd Qu.: 0.11044   3rd Qu.:-0.4822   3rd Qu.:-0.4461   3rd Qu.:-0.3379   3rd Qu.:-0.07930       3rd Qu.:-0.02521      
 Max.   : 1.00000   Max.   : 1.00000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.00000       Max.   : 1.00000      
                                                                                                                                          
 tBodyGyroJerk-mean()-Z tBodyGyroJerk-std()-X tBodyGyroJerk-std()-Y tBodyGyroJerk-std()-Z tBodyAccMag-mean() tBodyAccMag-std()
 Min.   :-1.00000       Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000    Min.   :-1.0000  
 1st Qu.:-0.07936       1st Qu.:-0.9907       1st Qu.:-0.9922       1st Qu.:-0.9926       1st Qu.:-0.9819    1st Qu.:-0.9822  
 Median :-0.05455       Median :-0.9348       Median :-0.9548       Median :-0.9503       Median :-0.8746    Median :-0.8437  
 Mean   :-0.05483       Mean   :-0.7313       Mean   :-0.7861       Mean   :-0.7399       Mean   :-0.5482    Mean   :-0.5912  
 3rd Qu.:-0.03168       3rd Qu.:-0.4865       3rd Qu.:-0.6268       3rd Qu.:-0.5097       3rd Qu.:-0.1201    3rd Qu.:-0.2423  
 Max.   : 1.00000       Max.   : 1.0000       Max.   : 1.0000       Max.   : 1.0000       Max.   : 1.0000    Max.   : 1.0000  
                                                                                                                              
 tGravityAccMag-mean() tGravityAccMag-std() tBodyAccJerkMag-mean() tBodyAccJerkMag-std() tBodyGyroMag-mean() tBodyGyroMag-std()
 Min.   :-1.0000       Min.   :-1.0000      Min.   :-1.0000        Min.   :-1.0000       Min.   :-1.0000     Min.   :-1.0000   
 1st Qu.:-0.9819       1st Qu.:-0.9822      1st Qu.:-0.9896        1st Qu.:-0.9907       1st Qu.:-0.9781     1st Qu.:-0.9775   
 Median :-0.8746       Median :-0.8437      Median :-0.9481        Median :-0.9288       Median :-0.8223     Median :-0.8259   
 Mean   :-0.5482       Mean   :-0.5912      Mean   :-0.6494        Mean   :-0.6278       Mean   :-0.6052     Mean   :-0.6625   
 3rd Qu.:-0.1201       3rd Qu.:-0.2423      3rd Qu.:-0.2956        3rd Qu.:-0.2733       3rd Qu.:-0.2454     3rd Qu.:-0.3940   
 Max.   : 1.0000       Max.   : 1.0000      Max.   : 1.0000        Max.   : 1.0000       Max.   : 1.0000     Max.   : 1.0000   
                                                                                                                               
 tBodyGyroJerkMag-mean() tBodyGyroJerkMag-std() fBodyAcc-mean()-X fBodyAcc-mean()-Y fBodyAcc-mean()-Z fBodyAcc-std()-X  fBodyAcc-std()-Y  
 Min.   :-1.0000         Min.   :-1.0000        Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.00000  
 1st Qu.:-0.9923         1st Qu.:-0.9922        1st Qu.:-0.9913   1st Qu.:-0.9792   1st Qu.:-0.9832   1st Qu.:-0.9929   1st Qu.:-0.97689  
 Median :-0.9559         Median :-0.9403        Median :-0.9456   Median :-0.8643   Median :-0.8954   Median :-0.9416   Median :-0.83261  
 Mean   :-0.7621         Mean   :-0.7780        Mean   :-0.6228   Mean   :-0.5375   Mean   :-0.6650   Mean   :-0.6034   Mean   :-0.52842  
 3rd Qu.:-0.5499         3rd Qu.:-0.6093        3rd Qu.:-0.2646   3rd Qu.:-0.1032   3rd Qu.:-0.3662   3rd Qu.:-0.2493   3rd Qu.:-0.09216  
 Max.   : 1.0000         Max.   : 1.0000        Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.00000  
                                                                                                                                          
 fBodyAcc-std()-Z  fBodyAccJerk-mean()-X fBodyAccJerk-mean()-Y fBodyAccJerk-mean()-Z fBodyAccJerk-std()-X fBodyAccJerk-std()-Y
 Min.   :-1.0000   Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000       Min.   :-1.0000      Min.   :-1.0000     
 1st Qu.:-0.9780   1st Qu.:-0.9912       1st Qu.:-0.9848       1st Qu.:-0.9873       1st Qu.:-0.9920      1st Qu.:-0.9865     
 Median :-0.8398   Median :-0.9516       Median :-0.9257       Median :-0.9475       Median :-0.9562      Median :-0.9280     
 Mean   :-0.6179   Mean   :-0.6567       Mean   :-0.6290       Mean   :-0.7436       Mean   :-0.6550      Mean   :-0.6122     
 3rd Qu.:-0.3023   3rd Qu.:-0.3270       3rd Qu.:-0.2638       3rd Qu.:-0.5133       3rd Qu.:-0.3203      3rd Qu.:-0.2361     
 Max.   : 1.0000   Max.   : 1.0000       Max.   : 1.0000       Max.   : 1.0000       Max.   : 1.0000      Max.   : 1.0000     
                                                                                                                              
 fBodyAccJerk-std()-Z fBodyGyro-mean()-X fBodyGyro-mean()-Y fBodyGyro-mean()-Z fBodyGyro-std()-X fBodyGyro-std()-Y fBodyGyro-std()-Z
 Min.   :-1.0000      Min.   :-1.0000    Min.   :-1.0000    Min.   :-1.0000    Min.   :-1.0000   Min.   :-1.0000   Min.   :-1.0000  
 1st Qu.:-0.9895      1st Qu.:-0.9853    1st Qu.:-0.9847    1st Qu.:-0.9851    1st Qu.:-0.9881   1st Qu.:-0.9808   1st Qu.:-0.9862  
 Median :-0.9590      Median :-0.8917    Median :-0.9197    Median :-0.8877    Median :-0.9053   Median :-0.9061   Median :-0.8915  
 Mean   :-0.7809      Mean   :-0.6721    Mean   :-0.7062    Mean   :-0.6442    Mean   :-0.7386   Mean   :-0.6742   Mean   :-0.6904  
 3rd Qu.:-0.5903      3rd Qu.:-0.3837    3rd Qu.:-0.4735    3rd Qu.:-0.3225    3rd Qu.:-0.5225   3rd Qu.:-0.4385   3rd Qu.:-0.4168  
 Max.   : 1.0000      Max.   : 1.0000    Max.   : 1.0000    Max.   : 1.0000    Max.   : 1.0000   Max.   : 1.0000   Max.   : 1.0000  
                                                                                                                                    
 fBodyAccMag-mean() fBodyAccMag-std() fBodyBodyAccJerkMag-mean() fBodyBodyAccJerkMag-std() fBodyBodyGyroMag-mean() fBodyBodyGyroMag-std()
 Min.   :-1.0000    Min.   :-1.0000   Min.   :-1.0000            Min.   :-1.0000           Min.   :-1.0000         Min.   :-1.0000       
 1st Qu.:-0.9847    1st Qu.:-0.9829   1st Qu.:-0.9898            1st Qu.:-0.9907           1st Qu.:-0.9825         1st Qu.:-0.9781       
 Median :-0.8755    Median :-0.8547   Median :-0.9290            Median :-0.9255           Median :-0.8756         Median :-0.8275       
 Mean   :-0.5860    Mean   :-0.6595   Mean   :-0.6208            Mean   :-0.6401           Mean   :-0.6974         Mean   :-0.7000       
 3rd Qu.:-0.2173    3rd Qu.:-0.3823   3rd Qu.:-0.2600            3rd Qu.:-0.3082           3rd Qu.:-0.4514         3rd Qu.:-0.4713       
 Max.   : 1.0000    Max.   : 1.0000   Max.   : 1.0000            Max.   : 1.0000           Max.   : 1.0000         Max.   : 1.0000       
                                                                                                                                         
 fBodyBodyGyroJerkMag-mean() fBodyBodyGyroJerkMag-std()             activitycode     subject    
 Min.   :-1.0000             Min.   :-1.0000            Walking           :1722   25     : 409  
 1st Qu.:-0.9921             1st Qu.:-0.9926            Walking upstairs  :1544   21     : 408  
 Median :-0.9453             Median :-0.9382            Walking downstairs:1406   26     : 392  
 Mean   :-0.7798             Mean   :-0.7922            Sitting           :1777   30     : 383  
 3rd Qu.:-0.6122             3rd Qu.:-0.6437            Standing          :1906   28     : 382  
 Max.   : 1.0000             Max.   : 1.0000            Laying            :1944   24     : 381  
                                                                                  (Other):7944 
                                                                                  
* averagebysubjectandactivity
 + Dimensions: 180 x 68
 + Summary:
 subject                activitycode tBodyAcc-mean()-X tBodyAcc-mean()-Y   tBodyAcc-mean()-Z  tBodyAcc-std()-X  tBodyAcc-std()-Y  
 1      :  6   Walking           :30    Min.   :0.2216    Min.   :-0.040514   Min.   :-0.15251   Min.   :-0.9961   Min.   :-0.99024  
 2      :  6   Walking upstairs  :30    1st Qu.:0.2712    1st Qu.:-0.020022   1st Qu.:-0.11207   1st Qu.:-0.9799   1st Qu.:-0.94205  
 3      :  6   Walking downstairs:30    Median :0.2770    Median :-0.017262   Median :-0.10819   Median :-0.7526   Median :-0.50897  
 4      :  6   Sitting           :30    Mean   :0.2743    Mean   :-0.017876   Mean   :-0.10916   Mean   :-0.5577   Mean   :-0.46046  
 5      :  6   Standing          :30    3rd Qu.:0.2800    3rd Qu.:-0.014936   3rd Qu.:-0.10443   3rd Qu.:-0.1984   3rd Qu.:-0.03077  
 6      :  6   Laying            :30    Max.   :0.3015    Max.   :-0.001308   Max.   :-0.07538   Max.   : 0.6269   Max.   : 0.61694  
 (Other):144                                                                                                                         
 tBodyAcc-std()-Z  tGravityAcc-mean()-X tGravityAcc-mean()-Y tGravityAcc-mean()-Z tGravityAcc-std()-X tGravityAcc-std()-Y
 Min.   :-0.9877   Min.   :-0.6800      Min.   :-0.47989     Min.   :-0.49509     Min.   :-0.9968     Min.   :-0.9942    
 1st Qu.:-0.9498   1st Qu.: 0.8376      1st Qu.:-0.23319     1st Qu.:-0.11726     1st Qu.:-0.9825     1st Qu.:-0.9711    
 Median :-0.6518   Median : 0.9208      Median :-0.12782     Median : 0.02384     Median :-0.9695     Median :-0.9590    
 Mean   :-0.5756   Mean   : 0.6975      Mean   :-0.01621     Mean   : 0.07413     Mean   :-0.9638     Mean   :-0.9524    
 3rd Qu.:-0.2306   3rd Qu.: 0.9425      3rd Qu.: 0.08773     3rd Qu.: 0.14946     3rd Qu.:-0.9509     3rd Qu.:-0.9370    
 Max.   : 0.6090   Max.   : 0.9745      Max.   : 0.95659     Max.   : 0.95787     Max.   :-0.8296     Max.   :-0.6436    
                                                                                                                         
 tGravityAcc-std()-Z tBodyAccJerk-mean()-X tBodyAccJerk-mean()-Y tBodyAccJerk-mean()-Z tBodyAccJerk-std()-X tBodyAccJerk-std()-Y
 Min.   :-0.9910     Min.   :0.04269       Min.   :-0.0386872    Min.   :-0.067458     Min.   :-0.9946      Min.   :-0.9895     
 1st Qu.:-0.9605     1st Qu.:0.07396       1st Qu.: 0.0004664    1st Qu.:-0.010601     1st Qu.:-0.9832      1st Qu.:-0.9724     
 Median :-0.9450     Median :0.07640       Median : 0.0094698    Median :-0.003861     Median :-0.8104      Median :-0.7756     
 Mean   :-0.9364     Mean   :0.07947       Mean   : 0.0075652    Mean   :-0.004953     Mean   :-0.5949      Mean   :-0.5654     
 3rd Qu.:-0.9180     3rd Qu.:0.08330       3rd Qu.: 0.0134008    3rd Qu.: 0.001958     3rd Qu.:-0.2233      3rd Qu.:-0.1483     
 Max.   :-0.6102     Max.   :0.13019       Max.   : 0.0568186    Max.   : 0.038053     Max.   : 0.5443      Max.   : 0.3553     
                                                                                                                                
 tBodyAccJerk-std()-Z tBodyGyro-mean()-X tBodyGyro-mean()-Y tBodyGyro-mean()-Z tBodyGyro-std()-X tBodyGyro-std()-Y tBodyGyro-std()-Z
 Min.   :-0.99329     Min.   :-0.20578   Min.   :-0.20421   Min.   :-0.07245   Min.   :-0.9943   Min.   :-0.9942   Min.   :-0.9855  
 1st Qu.:-0.98266     1st Qu.:-0.04712   1st Qu.:-0.08955   1st Qu.: 0.07475   1st Qu.:-0.9735   1st Qu.:-0.9629   1st Qu.:-0.9609  
 Median :-0.88366     Median :-0.02871   Median :-0.07318   Median : 0.08512   Median :-0.7890   Median :-0.8017   Median :-0.8010  
 Mean   :-0.73596     Mean   :-0.03244   Mean   :-0.07426   Mean   : 0.08744   Mean   :-0.6916   Mean   :-0.6533   Mean   :-0.6164  
 3rd Qu.:-0.51212     3rd Qu.:-0.01676   3rd Qu.:-0.06113   3rd Qu.: 0.10177   3rd Qu.:-0.4414   3rd Qu.:-0.4196   3rd Qu.:-0.3106  
 Max.   : 0.03102     Max.   : 0.19270   Max.   : 0.02747   Max.   : 0.17910   Max.   : 0.2677   Max.   : 0.4765   Max.   : 0.5649  
                                                                                                                                    
 tBodyGyroJerk-mean()-X tBodyGyroJerk-mean()-Y tBodyGyroJerk-mean()-Z tBodyGyroJerk-std()-X tBodyGyroJerk-std()-Y tBodyGyroJerk-std()-Z
 Min.   :-0.15721       Min.   :-0.07681       Min.   :-0.092500      Min.   :-0.9965       Min.   :-0.9971       Min.   :-0.9954      
 1st Qu.:-0.10322       1st Qu.:-0.04552       1st Qu.:-0.061725      1st Qu.:-0.9800       1st Qu.:-0.9832       1st Qu.:-0.9848      
 Median :-0.09868       Median :-0.04112       Median :-0.053430      Median :-0.8396       Median :-0.8942       Median :-0.8610      
 Mean   :-0.09606       Mean   :-0.04269       Mean   :-0.054802      Mean   :-0.7036       Mean   :-0.7636       Mean   :-0.7096      
 3rd Qu.:-0.09110       3rd Qu.:-0.03842       3rd Qu.:-0.048985      3rd Qu.:-0.4629       3rd Qu.:-0.5861       3rd Qu.:-0.4741      
 Max.   :-0.02209       Max.   :-0.01320       Max.   :-0.006941      Max.   : 0.1791       Max.   : 0.2959       Max.   : 0.1932      
                                                                                                                                       
 tBodyAccMag-mean() tBodyAccMag-std() tGravityAccMag-mean() tGravityAccMag-std() tBodyAccJerkMag-mean() tBodyAccJerkMag-std()
 Min.   :-0.9865    Min.   :-0.9865   Min.   :-0.9865       Min.   :-0.9865      Min.   :-0.9928        Min.   :-0.9946      
 1st Qu.:-0.9573    1st Qu.:-0.9430   1st Qu.:-0.9573       1st Qu.:-0.9430      1st Qu.:-0.9807        1st Qu.:-0.9765      
 Median :-0.4829    Median :-0.6074   Median :-0.4829       Median :-0.6074      Median :-0.8168        Median :-0.8014      
 Mean   :-0.4973    Mean   :-0.5439   Mean   :-0.4973       Mean   :-0.5439      Mean   :-0.6079        Mean   :-0.5842      
 3rd Qu.:-0.0919    3rd Qu.:-0.2090   3rd Qu.:-0.0919       3rd Qu.:-0.2090      3rd Qu.:-0.2456        3rd Qu.:-0.2173      
 Max.   : 0.6446    Max.   : 0.4284   Max.   : 0.6446       Max.   : 0.4284      Max.   : 0.4345        Max.   : 0.4506      
                                                                                                                             
 tBodyGyroMag-mean() tBodyGyroMag-std() tBodyGyroJerkMag-mean() tBodyGyroJerkMag-std() fBodyAcc-mean()-X fBodyAcc-mean()-Y 
 Min.   :-0.9807     Min.   :-0.9814    Min.   :-0.99732        Min.   :-0.9977        Min.   :-0.9952   Min.   :-0.98903  
 1st Qu.:-0.9461     1st Qu.:-0.9476    1st Qu.:-0.98515        1st Qu.:-0.9805        1st Qu.:-0.9787   1st Qu.:-0.95361  
 Median :-0.6551     Median :-0.7420    Median :-0.86479        Median :-0.8809        Median :-0.7691   Median :-0.59498  
 Mean   :-0.5652     Mean   :-0.6304    Mean   :-0.73637        Mean   :-0.7550        Mean   :-0.5758   Mean   :-0.48873  
 3rd Qu.:-0.2159     3rd Qu.:-0.3602    3rd Qu.:-0.51186        3rd Qu.:-0.5767        3rd Qu.:-0.2174   3rd Qu.:-0.06341  
 Max.   : 0.4180     Max.   : 0.3000    Max.   : 0.08758        Max.   : 0.2502        Max.   : 0.5370   Max.   : 0.52419  
                                                                                                                           
 fBodyAcc-mean()-Z fBodyAcc-std()-X  fBodyAcc-std()-Y   fBodyAcc-std()-Z  fBodyAccJerk-mean()-X fBodyAccJerk-mean()-Y fBodyAccJerk-mean()-Z
 Min.   :-0.9895   Min.   :-0.9966   Min.   :-0.99068   Min.   :-0.9872   Min.   :-0.9946       Min.   :-0.9894       Min.   :-0.9920      
 1st Qu.:-0.9619   1st Qu.:-0.9820   1st Qu.:-0.94042   1st Qu.:-0.9459   1st Qu.:-0.9828       1st Qu.:-0.9725       1st Qu.:-0.9796      
 Median :-0.7236   Median :-0.7470   Median :-0.51338   Median :-0.6441   Median :-0.8126       Median :-0.7817       Median :-0.8707      
 Mean   :-0.6297   Mean   :-0.5522   Mean   :-0.48148   Mean   :-0.5824   Mean   :-0.6139       Mean   :-0.5882       Mean   :-0.7144      
 3rd Qu.:-0.3183   3rd Qu.:-0.1966   3rd Qu.:-0.07913   3rd Qu.:-0.2655   3rd Qu.:-0.2820       3rd Qu.:-0.1963       3rd Qu.:-0.4697      
 Max.   : 0.2807   Max.   : 0.6585   Max.   : 0.56019   Max.   : 0.6871   Max.   : 0.4743       Max.   : 0.2767       Max.   : 0.1578      
                                                                                                                                           
 fBodyAccJerk-std()-X fBodyAccJerk-std()-Y fBodyAccJerk-std()-Z fBodyGyro-mean()-X fBodyGyro-mean()-Y fBodyGyro-mean()-Z fBodyGyro-std()-X
 Min.   :-0.9951      Min.   :-0.9905      Min.   :-0.993108    Min.   :-0.9931    Min.   :-0.9940    Min.   :-0.9860    Min.   :-0.9947  
 1st Qu.:-0.9847      1st Qu.:-0.9737      1st Qu.:-0.983747    1st Qu.:-0.9697    1st Qu.:-0.9700    1st Qu.:-0.9624    1st Qu.:-0.9750  
 Median :-0.8254      Median :-0.7852      Median :-0.895121    Median :-0.7300    Median :-0.8141    Median :-0.7909    Median :-0.8086  
 Mean   :-0.6121      Mean   :-0.5707      Mean   :-0.756489    Mean   :-0.6367    Mean   :-0.6767    Mean   :-0.6044    Mean   :-0.7110  
 3rd Qu.:-0.2475      3rd Qu.:-0.1685      3rd Qu.:-0.543787    3rd Qu.:-0.3387    3rd Qu.:-0.4458    3rd Qu.:-0.2635    3rd Qu.:-0.4813  
 Max.   : 0.4768      Max.   : 0.3498      Max.   :-0.006236    Max.   : 0.4750    Max.   : 0.3288    Max.   : 0.4924    Max.   : 0.1966  
                                                                                                                                          
 fBodyGyro-std()-Y fBodyGyro-std()-Z fBodyAccMag-mean() fBodyAccMag-std() fBodyBodyAccJerkMag-mean() fBodyBodyAccJerkMag-std()
 Min.   :-0.9944   Min.   :-0.9867   Min.   :-0.9868    Min.   :-0.9876   Min.   :-0.9940            Min.   :-0.9944          
 1st Qu.:-0.9602   1st Qu.:-0.9643   1st Qu.:-0.9560    1st Qu.:-0.9452   1st Qu.:-0.9770            1st Qu.:-0.9752          
 Median :-0.7964   Median :-0.8224   Median :-0.6703    Median :-0.6513   Median :-0.7940            Median :-0.8126          
 Mean   :-0.6454   Mean   :-0.6577   Mean   :-0.5365    Mean   :-0.6210   Mean   :-0.5756            Mean   :-0.5992          
 3rd Qu.:-0.4154   3rd Qu.:-0.3916   3rd Qu.:-0.1622    3rd Qu.:-0.3654   3rd Qu.:-0.1872            3rd Qu.:-0.2668          
 Max.   : 0.6462   Max.   : 0.5225   Max.   : 0.5866    Max.   : 0.1787   Max.   : 0.5384            Max.   : 0.3163          
                                                                                                                              
 fBodyBodyGyroMag-mean() fBodyBodyGyroMag-std() fBodyBodyGyroJerkMag-mean() fBodyBodyGyroJerkMag-std()
 Min.   :-0.9865         Min.   :-0.9815        Min.   :-0.9976             Min.   :-0.9976           
 1st Qu.:-0.9616         1st Qu.:-0.9488        1st Qu.:-0.9813             1st Qu.:-0.9802           
 Median :-0.7657         Median :-0.7727        Median :-0.8779             Median :-0.8941           
 Mean   :-0.6671         Mean   :-0.6723        Mean   :-0.7564             Mean   :-0.7715           
 3rd Qu.:-0.4087         3rd Qu.:-0.4277        3rd Qu.:-0.5831             3rd Qu.:-0.6081           
 Max.   : 0.2040         Max.   : 0.2367        Max.   : 0.1466             Max.   : 0.2878  
 
 ## Variables
* Measures
  + The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
  + Units of measurement: Acc (acceleration) variables = g; Gyro (angular velocity vector measured by the gyroscope) = radians/second
tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tBodyAcc-std()-X          
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tGravityAcc-mean()-X
tGravityAcc-mean()-Y    
tGravityAcc-mean()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z        
tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyAccJerk-std()-X       
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyGyro-mean()-X
tBodyGyro-mean()-Y     
tBodyGyro-mean()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z     
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyGyroJerk-std()-X    
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyAccMag-mean()
tBodyAccMag-std
tGravityAccMag-mean()
tGravityAccMag-std()
tBodyAccJerkMag-mean()
tBodyAccJerkMag-std()    
tBodyGyroMag-mean()
tBodyGyroMag-std()
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()    
fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-std()-X           
fBodyAcc-std()-Y
fBodyAcc-std()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y     
fBodyAccJerk-mean()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-std()-X          
fBodyGyro-std()-Y
fBodyGyro-std()-Z
fBodyAccMag-mean()
fBodyAccMag-std()          
fBodyBodyAccJerkMag-mean()
fBodyBodyAccJerkMag-std()
fBodyBodyGyroMag-mean()
fBodyBodyGyroMag-std()     
fBodyBodyGyroJerkMag-mean()
fBodyBodyGyroJerkMag-std()
* Factors
  + activitycode *("Walking", "Walking upstairs", "Walking downstairs", "Sitting", "Standing", "Laying")*
  + subject *(subject identifier)*