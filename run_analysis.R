# Read in data from original text files
# Data files in folder data/original

# X_test.txt contains measures for test subjects
xtest <- read.table("data/original/test/X_test.txt", header = F)

# Y_test.txt contains activity codes for test subjects
ytest <- read.table("data/original/test/Y_test.txt", header = F)

# subject_test.txt contains subject numbers for test group
testsubjects <- read.table("data/original/test/subject_test.txt", header = F)

# X_train.txt contains measures for training subjects
xtrain <- read.table("data/original/train/X_train.txt", header = F)

# Y_train.txt contains activity codes for training subjects
ytrain <- read.table("data/original/train/Y_train.txt", header = F)

# subject_train.txt contains subject numbers for training group
trainsubjects <- read.table("data/original/train/subject_train.txt", header = F)

# Read measure names from file into vector
features <- scan("data/original/features.txt", what = c(numeric(), character()))

# Vector includes feature numbering (every other item),
# so remove using logical vector to get just feature names
columns <- features[c(FALSE,TRUE)]

# 4. Appropriately labels the data set with descriptive variable names.
# Use cleaned feature names to name columns in data frames
names(xtest) <- columns
names(xtrain) <- columns

# Add column with activity codes
xtest$activitycode <- ytest[,1]
xtrain$activitycode <- ytrain[,1]

# Add column with subjects
xtest$subject <- testsubjects[,1]
xtrain$subject <- trainsubjects[,1]

# Use rbind to combine test and training data
# 1. Merges the training and the test sets to create one data set.
combined <- rbind(xtest, xtrain)

# Create vector of strngs to match to get
# only columns with mean and std measures
tomatch <- c("mean\\(\\)","std\\(\\)")

# Use grepl to create logical vector of columns
# containing mean and std measures
matched <- grepl(paste(tomatch, collapse = "|"), columns)

# Expand logical vector to keep columns for
# activitycode and subject
keepcols <- c(matched,TRUE,TRUE)

# Extract only necessary columns:
# mean and std measures, activitycode, and subject
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
cleaned <- combined[, keepcols]

# 3. Uses descriptive activity names to name the activities in the data set
# Make activitycode a factor and assign descriptive names
cleaned$activitycode <- factor(cleaned$activitycode, 
                               levels = c(1,2,3,4,5,6), 
                               labels = c("Walking", "Walking upstairs",
                                          "Walking downstairs", "Sitting",
                                          "Standing", "Laying"))

# Make subject a factor
cleaned$subject <- as.factor(cleaned$subject)

# Load dplyr to make it easier to create second dataset
# with average of each variable by activity and subject
library(dplyr)

# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
averagebysubjectandactivity <- 
  cleaned %>% 
  group_by(subject, activitycode) %>% 
  summarise_each(funs(mean))

# Write data frames to files in data folder
write.table(cleaned, file = "data/cleaned.txt")
write.table(averagebysubjectandactivity, file = "data/averagebysubjectandactivity.txt")