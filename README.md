# Getting and Cleaning Data Course Assignment

| *Data Set Characteristics:*  | Multivariate, Time-Series | *Number of Instances:*  | 180                        |
| *Attribute Characteristics:* | N/A                       | *Number of Attributes:* | 68                         |
| *Area:*                      | Computer                  | *Associated Tasks:*     | Classification, Clustering |
| *Missing Values?*            | N/A                       | *Data From:*            | 2012-12-10                 |

## Goal

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This README explains how all of the scripts work and how they are connected.

Included is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called [codebook.md](codebook.md).

Create one R script called `run_analysis.R` that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data used represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Getting the data

The included R script `run_analysis.R` will download a copy of the data as needed. It will only download and unzip the data once, unless you move or rename the files or directories.

The data source URL is: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It is not necessary nor expected to download and/or unzip the data manually.

## Running the script

### From the command line

```bash
Rscript run_analysis.R
```

### From RStudio

```r
source('run_analysis.R')
```

## Analysing the data

* The included R script `run_analysis.R` will process the data.
* Results will be stored in an R variable named `tidyData`.
* Results will be output to a space-delimited file named `output.txt` in the working directory.
* See [codebook.md](codebook.md) for more information.

## Attribution

This project is based on the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
