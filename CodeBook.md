
####The run_analysis.R script performs the following steps:

1 - Read training data set - Read X_train.txt, y_train.txt and subject_train.txt from the "./padata/train" folder and store them in trainData,trainLabel and trainSubject variables respectively.

2 - Read test data set - Read X_test.txt, y_test.txt and subject_test.txt from the "./padata/test" folder and store them in testData, testLabeland testsubject variables respectively.

3 - Merge test dataset to training dataset to generate a 10299x561 data frame, mergeData; merge testLabel to trainLabel to generate a 10299x1 data frame, mergeLabel; merge testSubject to trainSubject to generate a 10299x1 data frame, mergeSubject.

4 - Read the features.txt file from the "/padata" folder and store the data in a variable called features. We only extract the measurements on the mean and standard deviation. We get a subset of mergeData with the 66 corresponding columns.

5 - Clean the column names of the subset. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.

6 - Read the activity_labels.txt file from the "./padata"" folder and store the data in a variable called activity.

7 - Clean the activity names in the second column of activity. We first make all names to lower cases. If the name has an underscore between letters, we remove the underscore and capitalize the letter immediately after the underscore.

8 - Transform the values of mergeLabel according to the activity data frame.

9 - Combine the mergeSubject, mergeLabel and mergeData by column to get a new cleaned 10299x68 data frame, clData. Properly name the first two columns, "subject" and "activity". The "subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.

10 - Generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. So, after initializing the result data frame and performing the two for-loops, we get a 180x68 data frame.

11 - Write the result out to "tidyData.txt" file in current working directory.
