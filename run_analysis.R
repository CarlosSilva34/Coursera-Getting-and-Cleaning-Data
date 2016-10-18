
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
joinData <- rbind(trainData, testData)
dim(joinData) # 10299*561
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) # 10299*1
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) # 10299*1


# 2 - Extracts only the measurements on the mean and standard

features <- read.table("./paData/features.txt")
dim(features)  # 561*2
meanStdValues <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdValues) # 66
joinData <- joinData[, meanStdValues]
dim(joinData) # 10299*66
# to remove "()"
names(joinData) <- gsub("\\(\\)", "", features[meanStdValues, 2]) 
# to capitalize M
names(joinData) <- gsub("mean", "Mean", names(joinData)) 
# to capitalize S
names(joinData) <- gsub("std", "Std", names(joinData)) 
# to remove "-" 
names(joinData) <- gsub("-", "", names(joinData)) 


# 3 - Uses descriptive activity names to name the activities in the data set 

activity <- read.table("./paData/activity_labels.txt")
#gsub:replace function 
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) 
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activLabel
names(joinLabel) <- "activity"


# 4 - Appropriately labels the data set with descriptive activity

names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData) # 10299*68
# write out the 1st dataset
write.table(cleanedData, "merged_data.txt") 


# 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# each variable for each activity and each subject.
subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
        for(j in 1:activityLen) {
                result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
                result[row, 2] <- activity[j, 2]
                bool1 <- i == cleanedData$subject
                bool2 <- activity[j, 2] == cleanedData$activity
                result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
                row <- row + 1
        }
}

head(result)
# write out the 2nd dataset
write.table(result, "data_means.txt")
        
#data <- read.table("./data_means.txt")
#data[1:12, 1:3]
        

}

