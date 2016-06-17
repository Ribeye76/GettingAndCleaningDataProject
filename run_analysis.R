## Download and unzip the dataset if it does not already exist
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

# Extract only the data on mean and standard deviation
featuresMeanStd <- grep(".*mean.*|.*std.*", features[,2])
featuresMeanStd.names <- features[featuresMeanStd,2]
featuresMeanStd.names = gsub('-mean', 'Mean', featuresMeanStd.names)
featuresMeanStd.names = gsub('-std', 'Std', featuresMeanStd.names)
featuresMeanStd.names <- gsub('[-()]', '', featuresMeanStd.names)
