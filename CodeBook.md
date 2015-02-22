## Code book

### The data

Note: this information was taken from the ReadMe file delivered with the raw data.


**General information**

The data used in this script, the Human Activity Recognition Using Smartphones Data Set, represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This data is freely available at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and is also contained in the UCI HAR Dataset directory in this repository.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking\_upstairs, walking\_downstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50 Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. For the tidy data, these data sets are merged.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used.

**For each record it is provided**

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### The variables (features)

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeAcc-XYZ and timeGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAcc-XYZ and timeGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccJerk-XYZ and timeBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeodyAccMag, timeGravityAccMag, timeBodyAccJerkMag, timeBodyGyroMag, timeBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing freqBodyAcc-XYZ, freqBodyAccJerk-XYZ, freqBodyGyro-XYZ, freqBodyAccJerkMag, freqBodyGyroMag, freqBodyGyroJerkMag. (Note the 'freq' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'.XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* timeBodyAcc.XYZ
* timeGravityAcc.XYZ
* timeBodyAccJerk.XYZ
* timeBodyGyro.XYZ
* timeBodyGyroJerk.XYZ
* timBodyAccMag
* timeGravityAccMag
* timeBodyAccJerkMag
* timeBodyGyroMag
* timeBodyGyroJerkMag
* freqBodyAcc.XYZ
* freqBodyAccJerk.XYZ
* freqBodyGyro.XYZ
* freqBodyAccMag
* freqBodyAccJerkMag
* freqBodyGyroMag
* freqBodyGyroJerkMag

From these set of variables, several estimates were calculated (see the raw data ReadMe file). To create the tidy data set, only the mean value (.mean), the standard deviation(.std) and the weighted average of the frequency components to obtain a mean frequency (.meanFreq) were used.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
timeBodyAccMean
timeBodyAccJerkMean
timeBodyGyroMean
timeBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'. Note that the features are normalised and bounded within [-1,1]. Each feature vector is a row in the text file.

### Processing the data
The **run_analysis.R** script generates two tidy data frames, of which only the latter is written as output in **tidy.txt**. It uses the packages *plyr*, *dplyr* and *reshape*, which should be installed to run this script.

**Merging the data**

The script starts by reading the different feature measurements from the test and the train directory (contained in **X\_dir.txt**, where **dir** is either **test** or **train**), and merges this with the respective subject and activity ID's contained in **subject\_dir.txt** and **y\_dir.txt**, using the *cbind* function. The so-obtained test and training data set are merged using the *rbind* function.

**Using descriptive features and activity labels**

Using the different feature labels, listed in **features.txt**, we select those features that calculate either a mean or a standard deviation (in the former, we also include a mean frequency) - resulting in 79 features. This selection is done using the *filter* function. The resulting feature labels are cleaned up according to the following rules:

1. replace any label starting with 't' by a label starting with 'time': more descriptive

2. replace any label starting with 'f' by a label starting with 'freq': more descriptive

3. remove the '()': improve readability

4. replace all '-' by '.': important if selecting the columns by name

From the original data set, only those features are selected that correspond to the mean and standard deviation measurements, and the columns are given their appropriate names.

Using the **activity_labels.txt** file, the activity ID's are replaced by their proper name, using lowercase labels to improve readability.

**Tidy data sets**

The resulting data set, *Sel\_df*, is then ordered by subject and activity, so that a certain entry can easily been found. This ordering is done using the *arrange* function. *Sel\_df* is **not** written to an external file. It contains for every subject and activity, the features selected above, as measured in every measurement, in the wide format (so each column contains one measurement). It contains 10299 observations of 81 variables (subject, activity and 79 features)

This data table is transformed to the long format using the *melt* function, yielding the *Sel\_df\_melted* data table. For each combination of subject, activity and feature, the *ddply* function is used to generate a data table containing the mean value of the measurements. The results are contained in the data table *fin\_df*, and written to the file **tidy.txt**. This data table contains 14220 observations of 4 variables (subject, activity, feature and mean value).

### License

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

For more information about this dataset contact: activityrecognition@smartlab.ws