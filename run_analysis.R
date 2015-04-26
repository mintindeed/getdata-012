workingDirectory <- getwd()
dirName <- "UCI HAR Dataset"
fileName <- "getdata-projectfiles-UCI HAR Dataset.zip"

# Download the data set, if needed
dataFileExists <- file.exists( file.path( workingDirectory, fileName ) )
if ( dataFileExists == FALSE ) {
    message( paste( fileName, "does not exist. Downloading now..." ) )
    dataUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file( dataUrl, destfile = file.path( workingDirectory, fileName ), method = "curl" )
}

# Unzip the data set, if needed
dataDirectoryExists <- file.exists( file.path( workingDirectory, dirName ) )
if ( dataDirectoryExists == FALSE ) {
    message( paste( dirName, "does not exist. Unzipping", fileName, "..." ) )
    unzip( file.path( workingDirectory, fileName ) )
}

dataDirectory <- file.path( workingDirectory, dirName );
testDataDirectory <- file.path( dataDirectory, "test" )
trainDataDirectory <- file.path( dataDirectory, "train" )

# In order to free up memory, clean up variables which are no longer necessary
rm( dataDirectoryExists, dataFileExists )

#
# 1) Merges the training and the test sets to create one data set.
#

subject_test <- scan( file.path( testDataDirectory, "subject_test.txt" ) )
x_test <- read.table( file.path( testDataDirectory, "X_test.txt" ), header=FALSE )
y_test <- scan( file.path( testDataDirectory, "y_test.txt" ) )

subject_train <- scan( file.path( trainDataDirectory, "subject_train.txt" ) )
x_train <- read.table( file.path( trainDataDirectory, "X_train.txt" ), header=FALSE )
y_train <- scan( file.path( trainDataDirectory, "y_train.txt" ) )

x_data <- rbind( x_test, x_train ) # this is our primary data set
y_data <- c( y_test, y_train ) # we'll add this to x_data later
subject_data <- c( subject_test, subject_train ) # we'll add this to x_data later

# In order to free up memory, clean up variables which are no longer necessary
rm( subject_test, subject_train, x_test, x_train, y_test, y_train )


# Skip 2) and 3) for now


#
# 4) Appropriately labels the data set with descriptive variable names.
#
features <- read.delim( file.path( dataDirectory, "features.txt" ), sep=" ", header=FALSE )
names(x_data) <- as.vector( features[,"V2"] ) # we'll tidy up the names in a bit


#
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
#
keep <- grepl( "(mean\\(\\)|std\\(\\))", as.vector( features[,"V2"] ) )
x_data <- x_data[keep]

# In order to free up memory, clean up variables which are no longer necessary
rm( keep, features )

# Tidy up the column names
names( x_data ) <- gsub( "-([a-z]{1})([a-z]+)\\(\\)(-)?", "\\U\\1\\L\\2", names( x_data ), perl=TRUE )


#
# 3) Uses descriptive activity names to name the activities in the data set
#
activity_labels <- read.delim( file.path( dataDirectory, "activity_labels.txt" ), sep=" ", header=FALSE )
x_data[,"activity"] <- factor( y_data, labels = as.vector( activity_labels[,"V2"] ) )

# In order to free up memory, clean up variables which are no longer necessary
rm( y_data, activity_labels )

# Add subject column
x_data[,"subject"] <- subject_data

# In order to free up memory, clean up variables which are no longer necessary
rm( subject_data )

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- aggregate( . ~subject + activity, x_data, mean )

# In order to free up memory, clean up variables which are no longer necessary
rm( x_data )

write.table( tidyData, file.path( workingDirectory, "output.txt" ), row.names=FALSE )
