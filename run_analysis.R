run_analysis <- function() {
    
    ## Required packages
    ##
    require("plyr")
    
    ## Set up some convenient folder names that reflect the data layout in the 
    ## zip file.
    ## 
    topFolder   <- "UCI HAR Dataset"
    testFolder  <- "test"
    trainFolder <- "train"
    
    ## Load the feature indices and descriptions.  These are actually the column
    ## numbers and the text descriptions of the variables (columns).
    ## 
    filename <- paste(topFolder, "features.txt", sep="\\")
    features <- read.table(filename, stringsAsFactors = FALSE)

    ## Load the activity codes and descriptions.  This is a small table that 
    ## maps an activity code (1-6) to a text description, e.g., "WALKING".  The 
    ## "Y" data files contain the more compact numeric code.
    ## 
    filename <- paste(topFolder, "activity_labels.txt", sep="\\")
    activity.labels <- read.table(filename, stringsAsFactors = FALSE)

    ## Load the subject (person ID number) for each observation from the "test"
    ## data.
    ## 
    filename <- paste(topFolder, testFolder, "subject_test.txt", sep="\\")
    test.subject <- read.table(filename, stringsAsFactors = FALSE)

    ## Load the variables for each observation from the "test" data.
    ##
    filename <- paste(topFolder, testFolder, "X_test.txt", sep="\\")
    test.var <- read.table(filename, stringsAsFactors = FALSE)

    ## Load the activity code for each observation from the "test" data.
    ## 
    filename <- paste(topFolder, testFolder, "Y_test.txt", sep="\\")
    test.activity <- read.table(filename, stringsAsFactors = FALSE)

    ## Check data consistency.  We should have the same number of rows in each
    ## of the three sets of data because each row is an observation.
    ##
    if (nrow(test.subject) != nrow(test.var) |
            nrow(test.subject) != nrow(test.activity)) {
        stop("\"Test\" data inconsistent.")
    }
    
    ## Load the subject (person ID number) for each observation from the "train"
    ## data.
    ## 
    filename <- paste(topFolder, trainFolder, "subject_train.txt", sep="\\")
    train.subject <- read.table(filename, stringsAsFactors = FALSE)
    
    ## Load the variables for each observation from the "train" data.
    ##
    filename <- paste(topFolder, trainFolder, "X_train.txt", sep="\\")
    train.var <- read.table(filename, stringsAsFactors = FALSE)
    
    ## Load the activity code for each observation from the "train" data.
    ## 
    filename <- paste(topFolder, trainFolder, "Y_train.txt", sep="\\")
    train.activity <- read.table(filename, stringsAsFactors = FALSE)
    
    ## Check data consistency.  We should have the same number of rows in each
    ## of the three sets of data because each row is an observation.
    ##
    if (nrow(test.subject) != nrow(test.var) |
            nrow(test.subject) != nrow(test.activity)) {
        stop("\"Train\" data inconsistent.")
    }
    
    ## Extract the features (variables) we are interested in.  We are using a
    ## simple search to include only the features (variables) that have "mean"
    ## or "std" in their names.  This search can be modified to extract
    ## variables based on other criteria without needing changes in the rest of
    ## the code.
    ## 
    ind <- grep("mean|std", features[,2])
    feature.indices <- features[ind,1]
    feature.names <- features[ind,2]
    
    ## Clean up the feature names, mainly to make them usable column names:
    ## 1) Remove ()
    ## 2) Change - to _
    ## No other mapping or correcting of received typos is done in order to
    ## maintain the best possible mapping to the original data.
    ##
    feature.names <- gsub("\\(\\)", "", feature.names)
    feature.names <- gsub("-", "_", feature.names)
    
    ## Keep only the features (variables) we are interested in.  Note that the
    ## assignment suggests merging the datasets first.  Due to the way they are
    ## merged here with rbind(), it is OK to extract the columns first. This is
    ## slightly more efficient, since extracting the columns first means merging
    ## less data.
    ## 
    test.var <- test.var[,feature.indices]
    train.var <- train.var[,feature.indices]
    
    ## Merge the datasets
    ##
    merge.subject <- rbind(test.subject, train.subject)
    merge.var <- rbind(test.var, train.var)
    merge.activity <- rbind(test.activity, train.activity)
    
    ## Build text version of activity column.  This will give us "WALKING"
    ## instead of 1, for example.
    ## 
    activities <- activity.labels[unlist(merge.activity),2]
    
    ## Create new data frame by combining columns.  The result is that for each
    ## row or observation, we will have a Subject (numeric), Activity (text),
    ## and the measured variables.
    ## 
    data <- cbind(merge.subject, activities, merge.var)
    
    ## Build column names and apply to data frame
    ##
    names(data) <- c("Subject", "Activity", feature.names)
    
    ## Create the tidy data set consisting of the mean of each of the
    ## variables columns.
    ##
    tidy <- ddply(data, .(Subject, Activity), colwise(mean))
    
    ## Write the tidy data set out to a text file.
    ##
    write.table(tidy, "tidy.txt", row.names=FALSE)
    
    ## Return the tidy data set as a function result.
    ##
    tidy 
}

