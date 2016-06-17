# Call required libraries
library(plyr)

# Download and unzip the dataset if it does not already exist
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
archivo <- "datos.zip"
if (!file.exists("datos.zip")){
  download.file(url, archivo)
  }
if (!file.exists("UCI HAR Dataset")) { 
  unzip(archivo) 
  }

# Load the activity and feature info
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels[,2] <- as.character(activitylabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract data of mean and standard deviation into featuresMeanStd
featuresMeanStd <- grep(".*mean.*|.*std.*", features[,2])

# Extract and arrange column names of mean and standard deviation into featuresMeanStd.names
featuresMeanStd.names <- features[featuresMeanStd,2]
featuresMeanStd.names <- gsub('-mean', 'Mean', featuresMeanStd.names)
featuresMeanStd.names <- gsub('-std', 'Std', featuresMeanStd.names)
featuresMeanStd.names <- gsub('[-()]', '', featuresMeanStd.names)

# Load datasets train and test, filter data with featuresMeanStd
train <- read.table("UCI HAR Dataset/train/X_train.txt")
train <- train[featuresMeanStd]
test <- read.table("UCI HAR Dataset/test/X_test.txt")
test <- test[featuresMeanStd]

# Add subjets and activities information and join them in two datasets: train and test
trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainactivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train <- cbind(trainsubjects, trainactivities, train)
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testactivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test <- cbind(testsubjects, testactivities, test)

# Join datasets train and test, and add labels
traintest <- rbind(train, test)
colnames(traintest) <- c("subject", "activity", featuresMeanStd.names)

# Turn subjects into factors
traintest$subject <- as.factor(traintest$subject)

# Turn activities into factors and add labels
traintest$activity <- factor(traintest$activity, levels = activitylabels[,1], labels = activitylabels[,2])

# Melt dataset to arrange variables in rows
traintest.melt <- melt(traintest, id = c("subject", "activity"))

# Summarize table to obtain an independent tidy data set with the average for each variable for each activity and each subject.
tidy <- ddply(traintest.melt, c("subject", "activity", "variable"), summarise, mean = mean(value))
write.table(tidy, "tidy.txt", row.names = FALSE, quote = FALSE)
