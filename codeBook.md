## Data Processing & Summary
The data was processed using the script run_analysis.R. The processing steps are as follows:
* Step 0 - The data was downloaded from this web address: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and the test and training data (and relevant keys/identifiers) were read into R
* Step 1 - The test and training sets were merged into a single file
* Step 2 - Only the mean and standard deviation variables were retained 
* Step 3 - Descriptive names for the activities carried out by the subject volunteers were added
* Step 4 - The variable names were cleaned up to better describe the measurement they represented 
* Step 5 - A new tidy data set was created that averaged each variable for each activity and each subject

## Tidy Data Variables
The cleaned data set 'tidy_uciHAR.txt' contains 81 columns. The first column is a subject identifier for the volunteer from the study, the second column is the activity that was measured for that subject, and the last 79 columns are the means and standard deviations of measurements summarizing the activities for each subject. 

The activities for each subject are: walking, walking upstairs, walking downstairs, sitting, standing, or laying. 

The components of the 79 variables are as follows: 
* time: time domain measurement
* freq: frequency domain measurement following Fast Fourier Transform
* Body: body accerlation 
* Gravity: gravity acceleration
* Acceleration: signial from the accelerometer 
* Gyro: signal from the gyroscope (angular velocity)
* Jerk: result from deriving body linear acceleration and gyroscope (angular velocity)
* Magnitude: magnitiude was calculated using the Euclidean norm
* X/Y/Z: denotes 3-axial signals in the X, Y, and Z directions
* mean(): mean value
* std(): standard deviation 
* meanFreq(): weighted average of the frequency components to obtain a mean frequency

Note: all variables are normalized and bounded within [-1, 1]