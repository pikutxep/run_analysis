# read files
test <- read.csv("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)
train <- read.csv("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)
names <- read.csv("UCI HAR Dataset/features.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)
activityNames <- read.csv("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)
testVals <- read.csv("UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)
trainVals <- read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)
testSubject <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)
trainSubjet <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)

# set column names
dataNames <- names[,2]
colnames(test)<- dataNames
colnames(train)<- dataNames

aNames <- activityNames[,2]
# add activity names for each row
train$activity <- aNames[trainVals[,1]]
test$activity <- aNames[testVals[,1]]
# add subject in each row
train$subject <- trainSubjet[,1]
test$subject <- testSubject[,1]

# merge data sets
all = rbind(test,train)

# filer the columns by name
all <- all[, !duplicated(colnames(all))]
allMeanStd <- select(all, matches("mean|std|activity|subject"))

# group by subject and activity
secondSet <- group_by(allMeanStd, subject, activity)

# calculate the mean of the grouped set
summary <- summarise_each(secondSet, list(mean))

# write summary data to file
write.table(summary, file="summary.txt", row.name=FALSE)