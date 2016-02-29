### Getting and Cleaning Data, Course Project

## Overview

This assignment was meant to demonstrate our ability to collect, work with, and clean a data set that could be used for later analysis. Data coleected from the accelerometers of the Samsung Galaxy S smartphone was used, collected from the following web address: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and based on the following project description: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Project Specifics
The required steps of the project were to create a script called run_analysis.R that: 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Data files & Executing the R script
The raw data can be found in the folder 'UCI HAR Dataset' and the tidy data set is titled 'tidy_uciHAR.txt'. The entire project can be executed simply by running the 'run_analysis.R' script. A description of the variables in the tidy data set can be found in codeBook.md. 

The script downloads the original data set as a zip file and then extracts the zip file contents. The training and test set data are then read into R, merged, tidied, and a new tidy set summarizing the variables for each activity and subject is created as a text file output. 'run_analysis.R' relies on R functions for downloading and reading files, grep() and gsub() for identifying and replacing substrings, as well as functions from Hadley Wickham's  'dpylr' package to summarize data.
