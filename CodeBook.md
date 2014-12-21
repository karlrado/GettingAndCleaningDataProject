# Code Book for Getting and Cleaning Data Course Project

## Data Sources and Description
A full description of the experiment and the data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data itself is found at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In this project, the meaning or values of any of the data is NOT changed.  In general, a subset of the data is extracted and a summary presented in the tidy data returned by the R script.  So, the above sources may be consulted for details about the data.

## Data Transformations Performed by the run_analysis.R Script
Please examine the R script for the finer details, but the major operations performed by the script are: 

1. Read the "test" and the "train" data sets.
2. Select only the "Features" that contain "mean" or "std" in the feature names in both data sets.
3. Combine the "test" and the "train" data sets.
  * NOTE: The assignment specifies combining these two data sets first, then selecting the columns.  However, due to the way the R script is written, the order implemented here is staill valid.
4. Form a new data frame from the Subject vector, the text form of the Activity vector, and the Features.
5. Form the tidy data frame using ddply() to perform a column-wise mean, grouped by Subject and Activity.
6. Write the tidy data to an output file.
7. Return the tidy data as the function return value.

In addition, some minor transforms are applied to the Feature names, which are the names for each column in the tidy data set.  These changes allow the user to use the column names by removing characters not appropriate for column names.  These changes are kept to a minimum to allow the user to coorelate the columns back to the original data set.

These transformations are:

* Remove () - These could be parsed as a function call
* Replace '-' with '_'  - The '-' could be parsed as an operator

## Description of Data Found in the Returned Tidy Data Set

For each column:

* "Subject" : A numeric vector specifying the Subject number, which is an ID of a person participating in the experment.
* "Activity" : A character vector containing these possible values:
  * WALKING
  * WALKING_UPSTAIRS
  * WALKING_DOWNSTAIRS
  * SITTING
  * STANDING
  * LAYING

The remaining columns are all numeric and represent the mean of each Feature for each Subject and Activity.  For example, in a row where the Subject is 20, the Activity is "RUNNING" and the value in the "tBodyAcc_mean_X" column is 0.75, the value of 0.75 is the mean of all readings of "tBodyAcc_mean_X" while subject 20 was RUNNING.

The Features selected for this analysis are (the names transformed as described above):

"tBodyAcc_mean_X"              
"tBodyAcc_mean_Y"               "tBodyAcc_mean_Z"               "tBodyAcc_std_X"               
"tBodyAcc_std_Y"                "tBodyAcc_std_Z"                "tGravityAcc_mean_X"           
"tGravityAcc_mean_Y"            "tGravityAcc_mean_Z"            "tGravityAcc_std_X"            
"tGravityAcc_std_Y"             "tGravityAcc_std_Z"             "tBodyAccJerk_mean_X"          
"tBodyAccJerk_mean_Y"           "tBodyAccJerk_mean_Z"           "tBodyAccJerk_std_X"           
"tBodyAccJerk_std_Y"            "tBodyAccJerk_std_Z"            "tBodyGyro_mean_X"             
"tBodyGyro_mean_Y"              "tBodyGyro_mean_Z"              "tBodyGyro_std_X"              
"tBodyGyro_std_Y"               "tBodyGyro_std_Z"               "tBodyGyroJerk_mean_X"         
"tBodyGyroJerk_mean_Y"          "tBodyGyroJerk_mean_Z"          "tBodyGyroJerk_std_X"          
"tBodyGyroJerk_std_Y"           "tBodyGyroJerk_std_Z"           "tBodyAccMag_mean"             
"tBodyAccMag_std"               "tGravityAccMag_mean"           "tGravityAccMag_std"           
"tBodyAccJerkMag_mean"          "tBodyAccJerkMag_std"           "tBodyGyroMag_mean"            
"tBodyGyroMag_std"              "tBodyGyroJerkMag_mean"         "tBodyGyroJerkMag_std"         
"fBodyAcc_mean_X"               "fBodyAcc_mean_Y"               "fBodyAcc_mean_Z"              
"fBodyAcc_std_X"                "fBodyAcc_std_Y"                "fBodyAcc_std_Z"               
"fBodyAcc_meanFreq_X"           "fBodyAcc_meanFreq_Y"           "fBodyAcc_meanFreq_Z"          
"fBodyAccJerk_mean_X"           "fBodyAccJerk_mean_Y"           "fBodyAccJerk_mean_Z"          
"fBodyAccJerk_std_X"            "fBodyAccJerk_std_Y"            "fBodyAccJerk_std_Z"           
"fBodyAccJerk_meanFreq_X"       "fBodyAccJerk_meanFreq_Y"       "fBodyAccJerk_meanFreq_Z"      
"fBodyGyro_mean_X"              "fBodyGyro_mean_Y"              "fBodyGyro_mean_Z"             
"fBodyGyro_std_X"               "fBodyGyro_std_Y"               "fBodyGyro_std_Z"              
"fBodyGyro_meanFreq_X"          "fBodyGyro_meanFreq_Y"          "fBodyGyro_meanFreq_Z"         
"fBodyAccMag_mean"              "fBodyAccMag_std"               "fBodyAccMag_meanFreq"         
"fBodyBodyAccJerkMag_mean"      "fBodyBodyAccJerkMag_std"       "fBodyBodyAccJerkMag_meanFreq" 
"fBodyBodyGyroMag_mean"         "fBodyBodyGyroMag_std"          "fBodyBodyGyroMag_meanFreq"    
"fBodyBodyGyroJerkMag_mean"     "fBodyBodyGyroJerkMag_std"      "fBodyBodyGyroJerkMag_meanFreq"
> 
> 
