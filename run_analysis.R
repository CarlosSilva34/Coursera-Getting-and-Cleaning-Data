# 1 - Merges the training and the test sets to create one data set.

setwd("C:/Users/Utilizador/Desktop/DataScience/GettingCleaningData/Week4/")

#Read the files
trainData <- read.table("./paData/train/X_train.txt")
dim(trainData) # 7352*561
head(trainData)
trainLabel <- read.table("./paData/train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("./paData/train/subject_train.txt")
testData <- read.table("./paData/test/X_test.txt")
dim(testData) # 2947*561
testLabel <- read.table("./paData/test/y_test.txt") 
table(testLabel) 
testSubject <- read.table("./paData/test/subject_test.txt")

#Merge the training and the test sets
mergeData <- rbind(trainData, testData)
dim(mergeData) # 10299*561
mergeLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) # 10299*1
mergeSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) # 10299*1


# 2 - Extracts only the measurements on the mean and standard

features <- read.table("./paData/features.txt")
dim(features)  # 561*2
mStdValues <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(mStdValues) # 66
mergeData <- mergeData[, mStdValues]
dim(mergeData) # 10299*66
# to remove "()"
names(mergeData) <- gsub("\\(\\)", "", features[mStdValues, 2]) 
# to capitalize M
names(mergeData) <- gsub("mean", "Mean", names(mergeData)) 
# to capitalize S
names(mergeData) <- gsub("std", "Std", names(mergeData)) 
# to remove "-" 
names(mergeData) <- gsub("-", "", names(mergeData)) 


# 3 - Uses descriptive activity names to name the activities in the data set 

activity <- read.table("./paData/activity_labels.txt")
#gsub:replace function 
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) 
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activLabel <- activity[mergeLabel[, 1], 2]
mergeLabel[, 1] <- activLabel
names(mergeLabel) <- "activity"


# 4 - Appropriately labels the data set with descriptive activity

names(mergeSubject) <- "subject"
clData <- cbind(mergeSubject, mergeLabel, mergeData)
dim(clData) # 10299*68
# write out the 1st dataset
write.table(clData, "merged_data.txt") 


# 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# each variable for each activity and each subject.
subLen <- length(table(mergeSubject)) # 30
actLen <- dim(activity)[1] # 6
colLen <- dim(clData)[2]
result <- matrix(NA, nrow=subLen*actLen, ncol=colLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(clData)
row <- 1
for(i in 1:subLen) {
        for(j in 1:actLen) {
                result[row, 1] <- sort(unique(mergeSubject)[, 1])[i]
                result[row, 2] <- activity[j, 2]
                bool1 <- i == clData$subject
                bool2 <- activity[j, 2] == clData$activity
                result[row, 3:colLen] <- colMeans(clData[bool1&bool2, 3:colLen])
                row <- row + 1
        }
}

head(result)
# write out the 2nd dataset
write.table(result, "tidyDAta.txt")
head(data_means)      
#data <- read.table("./tidyData.txt")
#data[1:12,]
        
