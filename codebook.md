---
title: "Getting and Cleaning Data Course Project Codebook"
author: "Gabriel Koen"
date: "2015-04-25"
output:
  html_document:
    keep_md: yes
---

## Project Description

This project is based on data collected in the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

##Study design and data processing

###Collection of the raw data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

###Notes on the original (raw) data

The features selected come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

##Creating the tidy data file

###Guide to create the tidy data file

1. Run the script `run_analysis.R`.
  * The script will download a copy of the data as needed.
  * It will only download and unzip the data once, unless you move or rename the files or directories.
  * It is not necessary nor expected to download and/or unzip the data manually.

#### Running the script

##### From the command line

```bash
Rscript run_analysis.R
```

##### From RStudio

```r
source('run_analysis.R')
```

###Cleaning of the data

* Read `subject_test.txt` and `subject_test.txt` from the raw data set into numeric vectors and then combine them using `c()`.
* Read `y_test.txt` and `y_train.txt` from the raw data set into numeric vectors and then combine them using `c()`.
* Read `X_test.txt` and `X_train.txt` from the raw data set into data frames and then combine them using `rbind()`.
* Read `features.txt` (which contains the feature names) into a data frame using `read.delim()` with the parameters `sep=" "` and `header=FALSE`.
* Set the column names of the combined X-axis data by converting the appropriate features data frame column to a vector and applying it to the X-axis data frame using `names()`.
  * The column names are considered raw data at this point, as they contain special characters not desirable in a column name. The raw column names will be used to determine information about the data later, and then cleaned up to a readable/usable format.
* Convert the features data frame column containing the feature names to a vector named `keep` and use `grepl()` on the feature names to create a new vector.
  * This new vector will be used to subset the X-axis data frame.
* Extract the measurements on the mean and standard deviation for each measurement in the X-axis data by using the `keep` vector.
* Use `gsub()` to tidy up the column names of the X-axis data
* Read `activity_labels.txt` (which contains activity names and keys) into a data frame using `read.delim()` with the parameters  `sep=" "` and `header=FALSE`.
* Add a column named `activity` containing activity data (Y-axis data from the combined Y-axis data files) to the X-axis data frame.
  * Convert Y-axis data from a numeric key to a descriptive name using the activity labels data.
    * Convert the column of activity labels data containing descriptive names to a vector, then create a factor using the Y-axis data and the activity labels vector. Finally, add that factor to the X-axis data frame.
* Add a column named `subject` (containing the subject ID's from the combined subject files) to the X-axis data frame.
* The X-axis data frame now contains all combined test and training data for the X-axis with a subject ID and activity (Y-axis) for each observation, and a header name for each column. The next step is to determine the average of each variable for each activity and each subject.
* Use the `aggregate()` function with the formula `. ~subject + activity` to determine the average of each variable for each activity and each subject. This gives us our tidy data.
  * Assign the tidy data to a variable named `tidyData`
  * Use `write.table()` with the parameter `row.names=FALSE` to
write our tidy data to an output file named `output.txt` in the script's working directory.

##Description of the variables

For each record it is provided:

- An identifier of the subject who carried out the experiment.
- Its activity label.
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- The mean and standard deviation of time and frequency domain variables.

subject - Subject ID
activity - Subject's activity at the time of measurement
tBodyAccMeanX - Mean of the mean value of the Body Accelerometer's time domain signals on the X axis
tBodyAccMeanY - Mean of the mean value of the Body Accelerometer's time domain signals on the Y axis
tBodyAccMeanZ - Mean of the mean value of the Body Accelerometer's time domain signals on the Z axis
tBodyAccStdX - Mean of the standard deviation of the Body Accelerometer's time domain signals on the X axis
tBodyAccStdY - Mean of the standard deviation of the Body Accelerometer's time domain signals on the Y axis
tBodyAccStdZ - Mean of the standard deviation of the Body Accelerometer's time domain signals on the Z axis
tGravityAccMeanX - Mean of the mean value of the Gravity Accelerometer's time domain signals on the X axis
tGravityAccMeanY - Mean of the mean value of the Gravity Accelerometer's time domain signals on the Y axis
tGravityAccMeanZ - Mean of the mean value of the Gravity Accelerometer's time domain signals on the Z axis
tGravityAccStdX - Mean of the standard deviation of the Gravity Accelerometer's time domain signals on the X axis
tGravityAccStdY - Mean of the standard deviation of the Gravity Accelerometer's time domain signals on the Y axis
tGravityAccStdZ - Mean of the standard deviation of the Gravity Accelerometer's time domain signals on the Z axis
tBodyAccJerkMeanX - Mean of the mean value of the Body Accelerometer's jerk time domain signals on the X axis
tBodyAccJerkMeanY - Mean of the mean value of the Body Accelerometer's jerk time domain signals on the Y axis
tBodyAccJerkMeanZ - Mean of the mean value of the Body Accelerometer's jerk time domain signals on the Z axis
tBodyAccJerkStdX - Mean of the standard deviation of the Body Accelerometer's jerk time domain signals on the X axis
tBodyAccJerkStdY - Mean of the standard deviation of the Body Accelerometer's jerk time domain signals on the Y axis
tBodyAccJerkStdZ - Mean of the standard deviation of the Body Accelerometer's jerk time domain signals on the Z axis
tBodyGyroMeanX - Mean of the mean value of the Body Gyroscope's time domain signals on the X axis
tBodyGyroMeanY - Mean of the mean value of the Body Gyroscope's time domain signals on the Y axis
tBodyGyroMeanZ - Mean of the mean value of the Body Gyroscope's time domain signals on the Z axis
tBodyGyroStdX - Mean of the standard deviation of the Body Gyroscope's time domain signals on the X axis
tBodyGyroStdY - Mean of the standard deviation of the Body Gyroscope's time domain signals on the Y axis
tBodyGyroStdZ - Mean of the standard deviation of the Body Gyroscope's time domain signals on the Z axis
tBodyGyroJerkMeanX - Mean of the mean value of the Body Gyroscope's jerk time domain signals on the X axis
tBodyGyroJerkMeanY - Mean of the mean value of the Body Gyroscope's jerk time domain signals on the Y axis
tBodyGyroJerkMeanZ - Mean of the mean value of the Body Gyroscope's jerk time domain signals on the Z axis
tBodyGyroJerkStdX - Mean of the standard deviation of the Body Gyroscope's jerk time domain signals on the X axis
tBodyGyroJerkStdY - Mean of the standard deviation of the Body Gyroscope's jerk time domain signals on the Y axis
tBodyGyroJerkStdZ - Mean of the standard deviation of the Body Gyroscope's jerk time domain signals on the Z axis
tBodyAccMagMean - Mean of the mean value of the Body Accelerometer's magnitude time domain signals
tBodyAccMagStd - Mean of the standard deviation of the Body Accelerometer's magnitude time domain signals
tGravityAccMagMean - Mean of the mean value of the Gravity Accelerometer's magnitude time domain signals
tGravityAccMagStd - Mean of the standard deviation of the Gravity Accelerometer's magnitude time domain signals
tBodyAccJerkMagMean - Mean of the mean value of the Body Accelerometer's jerk magnitude time domain signals
tBodyAccJerkMagStd - Mean of the standard deviation of the Body Accelerometer's jerk magnitude time domain signals
tBodyGyroMagMean - Mean of the mean value of the Body Gyroscope's magnitude time domain signals
tBodyGyroMagStd - Mean of the standard deviation of the Body Gyroscope's magnitude time domain signals
tBodyGyroJerkMagMean - Mean of the mean value of the Body Gyroscope's jerk magnitude time domain signals
tBodyGyroJerkMagStd - Mean of the standard deviation of the Body Gyroscope's jerk magnitude time domain signals
fBodyAccMEanX - Mean of the mean value of the Body Accelerometer's frequency domain signals on the X axis
fBodyAccMEanY - Mean of the mean value of the Body Accelerometer's frequency domain signals on the Y axis
fBodyAccMEanZ - Mean of the mean value of the Body Accelerometer's frequency domain signals on the Z axis
fBodyAccStdX - Mean of the standard deviation of the Body Accelerometer's frequency domain signals on the X axis
fBodyAccStdY - Mean of the standard deviation of the Body Accelerometer's frequency domain signals on the Y axis
fBodyAccStdZ - Mean of the standard deviation of the Body Accelerometer's frequency domain signals on the Z axis
fBodyAccJerkMEanX - Mean of the mean value of the Body Accelerometer's jerk frequency domain signals on the X axis
fBodyAccJerkMEanY - Mean of the mean value of the Body Accelerometer's jerk frequency domain signals on the Y axis
fBodyAccJerkMEanZ - Mean of the mean value of the Body Accelerometer's jerk frequency domain signals on the Z axis
fBodyAccJerkStdX - Mean of the standard deviation of the Body Accelerometer's jerk frequency domain signals on the X axis
fBodyAccJerkStdY - Mean of the standard deviation of the Body Accelerometer's jerk frequency domain signals on the Y axis
fBodyAccJerkStdZ - Mean of the standard deviation of the Body Accelerometer's jerk frequency domain signals on the Z axis
fBodyGyroMEanX - Mean of the mean value of the Body Gyroscope's frequency domain signals on the X axis
fBodyGyroMEanY - Mean of the mean value of the Body Gyroscope's frequency domain signals on the Y axis
fBodyGyroMEanZ - Mean of the mean value of the Body Gyroscope's frequency domain signals on the Z axis
fBodyGyroStdX - Mean of the standard deviation of the Body Gyroscope's frequency domain signals on the X axis
fBodyGyroStdY - Mean of the standard deviation of the Body Gyroscope's frequency domain signals on the Y axis
fBodyGyroStdZ - Mean of the standard deviation of the Body Gyroscope's frequency domain signals on the Z axis
fBodyAccMagMEan - Mean of the mean value of the Body Accelerometer's magnitude frequency domain signals
fBodyAccMagStd - Mean of the standard deviation of the Body Accelerometer's magnitude frequency domain signals
fBodyBodyAccJerkMagMEan - Mean of the mean value of the BodyBody Accelerometer's jerk magnitude frequency domain signals. BodyBody appears to be a typo in the original data set. I've left it here for consistency.
fBodyBodyAccJerkMagStd - Mean of the standard deviation of the BodyBody Accelerometer's jerk magnitude frequency domain signals. BodyBody appears to be a typo in the original data set. I've left it here for consistency.
fBodyBodyGyroMagMEan - Mean of the mean value of the BodyBody Gyroscope's magnitude frequency domain signals. BodyBody appears to be a typo in the original data set. I've left it here for consistency.
fBodyBodyGyroMagStd - Mean of the standard deviation of the BodyBody Gyroscope's magnitude frequency domain signals. BodyBody appears to be a typo in the original data set. I've left it here for consistency.
fBodyBodyGyroJerkMagMEan - Mean of the mean value of the BodyBody Gyroscope's jerk magnitude frequency domain signals. BodyBody appears to be a typo in the original data set. I've left it here for consistency.
fBodyBodyGyroJerkMagStd - Mean of the standard deviation of the BodyBody Gyroscope's jerk magnitude frequency domain signals. BodyBody appears to be a typo in the original data set. I've left it here for consistency.

##Sources

This project uses data from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
