# Load dplyr package, which contains functions that will be used in this script
library(dplyr)

## -------------------------------------------------------------------------- ##
## Step 0: load and process the data set

# Download the data from the web and record the date/time
url <- paste0("https://d396qusza40orc.cloudfront.net/",
                "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
download.file(url, "SmartPhoneActivityData.zip", method="curl")
 downloadDate <- date()

# Unzip the file
unzip("SmartPhoneActivityData.zip")

# Read in test files
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read in training files
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read in keys that apply to all of the samples (training & test)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")


## -------------------------------------------------------------------------- ##
## Step 1: Merges the training and the test sets to create one data set

# Merge the training & test data as well as subject and activity indicators 
# into a single data file named all_data
x_all <- rbind(x_test, x_train)
y_all <- rbind(y_test, y_train)
subject_all <- rbind(subject_test, subject_train)
all_data <- cbind(subject_all, y_all, x_all)

# Rename column names to match the features description for variables
colnames(all_data) <- c("subject", "activity", as.matrix(features[,2]))

## -------------------------------------------------------------------------- ##
## Step 2: Extracts only the measurements on the mean and standard deviation 
## for each measurement

# Keep only variables (columns) that are means or standard deviations
keepVariables <- grep("(mean()|std())", colnames(all_data))
mean_std_data <- all_data[,c(1,2,keepVariables)]

# Order data set by subject number
mean_std_data <- arrange(mean_std_data, subject, activity)

## -------------------------------------------------------------------------- ##
## Step 3: Uses descriptive activity names to name the activities in the data set

# Swap the numerical labels in the data table with their corresponding activity 
# description based on the activity_labels file/table
for (i in 1:nrow(activity_labels)){
  mean_std_data$activity <- gsub(activity_labels[i,1], 
                            activity_labels[i,2], mean_std_data$activity)
}

# Convert activity labels to lower case 
mean_std_data$activity <- tolower(mean_std_data$activity)

## -------------------------------------------------------------------------- ##
## Step 4: Appropriately labels the data set with descriptive variable names 

# Make a vector of column names to work with
colNames <- colnames(mean_std_data)

# Replace t/f abbreviations with 'time' and 'freq'
colNames <- gsub("^t", "time_", colNames)
colNames <- gsub("^f", "freq_", colNames)

# Replace 'acc' abbreviation with 'acceleration'
colNames <- gsub("Acc", "Acceleration_", colNames)

# Replace 'mag' abbreviation with 'magnitude'
colNames <- gsub("Mag", "Magnitude_", colNames)

# Add underscores after 'Jerk', 'Gyro', 'Body', and 'Gravity'
colNames <- gsub("Jerk", "Jerk_", colNames)
colNames <- gsub("Gyro", "Gyro_", colNames)
colNames <- gsub("Body", "Body_", colNames)
colNames <- gsub("Gravity", "Gravity_", colNames)

# Remove dashes and add underscore before X, Y, and Z
colNames <- gsub("-", "", colNames)
colNames <- gsub("X", "_X", colNames)
colNames <- gsub("Y", "_Y", colNames)
colNames <- gsub("Z", "_Z", colNames)

# Substitute modified column names back into the mean_std_data data frame
colnames(mean_std_data) <- colNames


## -------------------------------------------------------------------------- ##
## Step 5: creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject

# Group the data by subject, then by activity and use 'sumarize_each()' to report
# the mean of the variable columns 
summary_data <- mean_std_data %>%
  group_by(subject, activity) %>%
  summarize_each(funs(mean))

# Save dataset to a text file
write.table(summary_data, file = "tidy_uciHAR.txt")
