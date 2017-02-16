#We need to use the following package.
library(reshape2)

filename <- "getdata_dataset.zip"

#First of all we download dataset and then unzip it:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
#Moreover we want to load activity labels and  features from the dataset.
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
#The next step is to extract only the measurements on the mean and standard deviation.
featuresRequired <- grep(".*mean.*|.*std.*", features[,2])
featuresRequired.names <- features[featuresRequired,2]
featuresRequired.names = gsub('-mean', 'Mean', featuresRequired.names)
featuresRequired.names = gsub('-std', 'Std', featuresRequired.names)
featuresRequired.names <- gsub('[-()]', '', featuresRequired.names)
#Now load the train and test datasets.
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresRequired]
trainActiv <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActiv, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresRequired]
testActiv <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActiv, test)
#After all we are ready merge the training and the test sets to create one data set.
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresRequired.names)
#Finally we create a second, independent tidy data set with the average of each variable for each activity and each subject.
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
