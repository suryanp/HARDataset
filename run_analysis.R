## If the data is not downloaded then please uncomment the following three lines
## url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## download.file(url, "HARDataSet")
## unzip("HARDataSet")

## Load packages needed for the code
library(gdata)
library(data.table)

## Load features data which contains columnn names for measured observations
ft <- read.table("UCI HAR Dataset/features.txt")

## Assign measurement labels to a vector
Xt.colnames <- as.vector(ft$V2)

## Assign human readable labels
Xt.colnames <- gsub("tBodyAcc", "BodyAccelerationTime", Xt.colnames)
Xt.colnames <- gsub("tGravityAcc", "GravityAccelerationTime", Xt.colnames)
Xt.colnames <- gsub("tBodyGyro", "BodyAngularVelocityTime", Xt.colnames)
Xt.colnames <- gsub("fBodyAcc", "BodyAccelerationFreq",  Xt.colnames)
Xt.colnames <- gsub("fBodyGyro", "BodyAngularVelocityFreq", Xt.colnames)
Xt.colnames <- gsub("fBodyBodyAcc", "BodyAccelerationFreq",  Xt.colnames)
Xt.colnames <- gsub("fBodyBodyGyro", "BodyAngularVelocityFreq", Xt.colnames)
Xt.colnames <- gsub("Mag", "Magnitude", Xt.colnames)

###############################################################################
## Load training set
Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")

## Assign column names to test set
colnames(Xtrain) <- Xt.colnames

## Load training subject data
subtrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

## Assign column names to subject data
colnames(subtrain) <- "Subject"

## Load training activity data
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")

## Assign column name to activity data
colnames(ytrain) <- "ActivityLabel"

## Merge training subject, measurements and activity data 
train <- cbind(subtrain, Xtrain, ytrain)

##############################################################################
## REPEAT THE ABOVE PROCESS FOR TEST DATA SET

Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")

## Assign column names to test set
colnames(Xtest) <- Xt.colnames

## Load training subject data
subtest <- read.table("UCI HAR Dataset/test/subject_test.txt")

## Assign column names to subject data
colnames(subtest) <- "Subject"

## Load training activity data
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")

## Assign column name to activity data
colnames(ytest) <- "ActivityLabel"

## Merge test subject, measurements and activity data 
test <- cbind(subtest, Xtest, ytest)

###############################################################################
## combine test and training set

comb <- rbind(test, train)

##############################################################################
## Extract only mean and stantard deviation column but drop mean frequency 
## and BodyBody frequncy domain signals 
col1 <- matchcols(comb, with = "mean()", without = "meanFreq()", method="or")

col2 <- matchcols(comb, with = "std()", without =  "meanFreq()", method="or")

col3 <- c("Subject", col1, col2, "ActivityLabel")

combselcolumn <- comb[, col3]

###############################################################################
## Append Activity detail
actlabel <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(actlabel) <- c("ActivityLabel", "ActivityDetail")


selcolumnfinal <- merge(data.table(combselcolumn), data.table(actlabel), by="ActivityLabel", 
                           allow.cartesian=TRUE)


##############################################################################
## Create the tidy data set, replace column names and export the data  to a csv file
tidydatatable <- selcolumnfinal[, lapply(.SD,mean), by=list(Subject, ActivityLabel, 
                                                       ActivityDetail)]

tidy.colnames <- colnames(tidydatatable)
tidy.colnames <- gsub("-mean[(])", "Mean", tidy.colnames)
tidy.colnames <- gsub("-std[(])", "MeanVariance", tidy.colnames)

tidydata <- data.frame(tidydatatable)
colnames(tidydata) <- tidy.colnames


write.csv(tidydata, file = "HumanActivityRecognitionTidyData.csv", row.names = FALSE)
