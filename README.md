## ReadMe file

### Overview of the files
* __README.md__: this ReadMe file, giving an overview of the available files
* __run_analysis.R__: an R script to tidy the given data, see below and in the code book
* __tidy.txt__: a text file containing a data table of tidy data, the output of the __run_analysis.R__ script
* __CodeBook.md__: a code book containing information concerning the tidy data and the transformations to obtain this data
* __UCI HAR Dataset__: a directory containing the raw data

### The data

The data used in this script, the Human Activity Recognition Using Smartphones Data Set, represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This data is freely available at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and is also contained in the UCI HAR Dataset directory in this repository.

The resulting tidy data table, contained in **tidy.txt**, can be viewed in R via the commands:

```
data <- read.table("./tidy.txt", header = TRUE) 
View(data)
```

### The purpose of the script

The data is processed through the **run_analysis.R** script, generated for the *Getting and Cleaning Data* course organised by Johns Hopkins University and Coursera. This script selects every feature (see **CodeBook.md**) in the original training and test data, and assigns the proper subject and activity for which that feature is measured. It generates a wide-format tidy data table containing those features that describe the mean or standard deviation of a certain measurement. This data table is used to generate a second tidy data table, in the long format, containing the averages of each of the selected features, as calculated per subject and activity combination. This last data table is written out in the file **tidy.txt**. The script assumes that the __UCI HAR Dataset__ directory is in the current working directory.

### The tidy data sets
The first data set, *Sel\_df*, contains 10299 observations of 81 variables (subject, activity and 79 features), stored in the wide format. See the code book for more information.

The second data set, *fin\_df*, contains 14220 observations of 4 variables (subject, activity, feature and mean value), stored in the long format. See the code book for more information.

### License and citation
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.