## Download and unzip the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
archivo <- "datos.zip"
if (!file.exists("datos.zip")){
  download.file(url, archivo)
  }
if (!file.exists("UCI HAR Dataset")) { 
  unzip(archivo) 
  }

