run_analysis <- function(){
  ## This function reads the separate data files from the UCI HAR Dataset, 
  ## and returns a tidy table containing the averages of each variable
  ## containing the mean or standard deviation of a measurement
  
  ## More information concerning this program can be found in the README.md;
  ## an overview of the transformations and variables is given in the Codebook.md
  
  ## This function uses the following packages
  library(plyr)
  library(dplyr)
  library(reshape2)
  
  ## First read in the test set data, and use cbind to combine to one data frame containing
  ## the subject (column 1), the activity (column 2) and the measurements (columns 3-563)
  XTest <- read.table("UCI HAR Dataset/test/X_test.txt")
  YTest <- read.table("UCI HAR Dataset/test/y_test.txt")
  SubjTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
  Test_df <- cbind(SubjTest, YTest, XTest)
  
  ## Repeat this for the training data set
  XTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
  YTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
  SubjTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
  Train_df <- cbind(SubjTrain, YTrain, XTrain)
  
  ## Combine the test and training data set to one data frame using rbind
  All_df <- rbind(Test_df, Train_df)
  
  ## Read the features labels, and make sure the names are character variables
  ## instead of factors
  features <- read.table("UCI HAR Dataset/features.txt", colClasses = c('numeric','character'))
  
  ## Use the dplyr filter function to select those feature labels and associated indices
  ## containing either mean or std
  features_sel <- filter(features, grepl('mean', V2) | grepl('std', V2))
  
  ## Clean up the feature labels:
  ## (i) replace any label starting with 't' by a label starting with 'time'
  ## (ii) replace any label starting with 'f' by a label starting with 'freq'
  ## (iii) remove the '()'
  ## (iv) replace all '-' by '.', important if selecting the columns by name
  features_sel$V2 <- sub('^t', 'time', features_sel$V2)
  features_sel$V2 <- sub('^f', 'freq', features_sel$V2)
  features_sel$V2 <- sub('\\(\\)', '', features_sel$V2)
  features_sel$V2 <- gsub('-', '.', features_sel$V2)
  
  ## Extract the feature indices corresponding to these features, which will be used to
  ## subset the original dataframe. Add 2 to account for the extra columns (subject and activity)
  col_ind <- features_sel$V1+2
  
  ## Subset the original data frame, only keeping the subject, activity and correct 
  ## features, i.e. those describing a mean or standard deviation
  Sel_df <- All_df[ , c(1,2,col_ind)]
  
  ## Read in the activity labels, and make sure the names are character variables
  ## instead of factors
  activities <- read.table("UCI HAR Dataset/activity_labels.txt", colClasses = c('numeric','character'))
  
  ## Replace the activity id's in the dataframe by the descriptive activity labels
  ## Make sure that these labels are lowercase to improve readability
  for( i in 1:nrow(Sel_df) ){
    Sel_df[i,2] <- tolower(activities[as.numeric(Sel_df[i,2]),2])
  }
  
  ## Give descriptive names to the columns, using the given feature labels
  names(Sel_df)[1] <- "subject"
  names(Sel_df)[2] <- "activity"
  for(i in seq_along(col_ind)){
    names(Sel_df)[i+2] <- features_sel[i,2]
  }
  
  ## Order the data set by subject and activity, to be able to quickly retrieve an entry
  Sel_df <- arrange(Sel_df, subject, activity)
  
  ## Reshape the dataframe for further transformation, keeping the subjects and activities,
  ## and considering the other columns (3:ncol) as variables (long form)
  Sel_df_melted <- melt(Sel_df, id = c(1,2), measure.vars = c(3:ncol(Sel_df)))
  
  ## Rename the feature column
  names(Sel_df_melted)[3] <- "feature"
  
  ## Calculate the mean of each of the subject x activity x feature, using the ddply
  ## summarise function
  fin_df <- ddply(Sel_df_melted, .(subject, activity, feature), summarise, mean=mean(value))
  
  ## Write the final long table in a text file
  write.table(fin_df, file = "./tidy.txt", row.name=FALSE)
}