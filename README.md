GettingAndCleaningDataProject
=============================

This is the github repository containing the work for the Class Project in the Getting and Cleaning Data course.

# Contents

1. run_analysis.R script file to load and process the data and create a tidy data set.
2. CodeBook.md markdown file containing the data dictionary and the transformations applied to the data by the R script.

# How to Run the Script

The script requires the "plyr" library.

1. Set R working directory to a folder that contains:
  1. The run_analysis.R script
  2. The test data unzipped into a folder (in the R working directory) called UCI HAR Dataset.  This should be the folder created after unzipping the zip file.
2. Run the R script
```
tidy <- run_analysis()
```

The zip file containing the data can be obtained from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
