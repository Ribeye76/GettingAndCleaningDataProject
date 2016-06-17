
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
# Extract and arrange column names of mean and standard deviation into featuresMeanStd.names

featuresMeanStd <- grep(".*mean.*|.*std.*", features[,2])
featuresMeanStd.names <- features[featuresMeanStd,2]
featuresMeanStd.names <- gsub('-mean', 'Mean', featuresMeanStd.names)
featuresMeanStd.names <- gsub('-std', 'Std', featuresMeanStd.names)
featuresMeanStd.names <- gsub('[-()]', '', featuresMeanStd.names)

# Load the datasets of train and test, add subjets and activities information,
# filter data with featuresMeanStd, and join them in two datasets: train and test

train <- read.table("UCI HAR Dataset/train/X_train.txt")
train <- train[featuresMeanStd]
trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainactivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train <- cbind(trainsubjects, trainactivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")
test <- test[featuresMeanStd]
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testactivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test <- cbind(testsubjects, testactivities, test)

# join datasets train and test, and add labels
traintest <- rbind(train, test)
colnames(traintest) <- c("subject", "activity", featuresMeanStd.names)

# turn subjects into factors
# turn activities into factors and add labels
traintest$subject <- as.factor(traintest$subject)
traintest$activity <- factor(traintest$activity, levels = activitylabels[,1], labels = activitylabels[,2])

traintest.melt <- melt(traintest, id = c("subject", "activity"))
write.table(traintest.melt, "tidy.txt", row.names = FALSE, quote = FALSE)

traintest.mean <- dcast(traintest.melt, subject + activity ~ variable, mean)


