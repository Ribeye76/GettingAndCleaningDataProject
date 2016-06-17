## Download and unzip the dataset if it does not already exist
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
archivo <- "datos.zip"
if (!file.exists("datos.zip")){
  download.file(url, archivo)
  }
if (!file.exists("UCI HAR Dataset")) { 
  unzip(archivo) 
  }

# Load activity labels and features
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels[,2] <- as.character(activitylabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])


