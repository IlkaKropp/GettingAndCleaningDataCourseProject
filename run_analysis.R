## This script collects data from UCI, merges the seperate files for one data set and cleans it to get a tidy data set.


## read uci Human Activity Recognition Using Smartphones Data Set
setwd("UCI HAR Dataset")
library(dplyr)
activity_labels <- read.table("activity_labels.txt") ## activityId and activityType
## set column names for activity labels for later use
names(activity_labels) = c("activity_id", "activity_name")
features <- read.table("features.txt")
## subset feature list to select only the means and standard deviation measurements
col_subset <- features$V2 %in% grep("mean\\(\\)|std\\(\\)", features$V2, value = TRUE)

## read train data
subject_train <- read.table("train/subject_train.txt") ## Volunteers generating test data
train_x <- read.table("train/X_train.txt") ## Volunteers observations of features
train_y <- read.table("train/Y_train.txt") ## Volunteers activity by activityId

## organize train data
train_data <- train_x
names(train_data) = features$V2
## subset train data -> only the means and standard deviation measurements
train_data_subset <- subset(train_data, select = col_subset)
## mutate train data -> new columns activity_id and volunteer_id
train_data_subset <- mutate(train_data_subset, activity_id = train_y$V1, volunteer_id = subject_train$V1 )


## read test data
subject_test <- read.table("test/subject_test.txt") ## Volunteers generating training data
test_x <- read.table("test/X_test.txt") ## Volunteers observations of features
test_y <- read.table("test/Y_test.txt") ## Volunteers activity by activityId

## organize test data
test_data <- test_x
names(test_data) = features$V2
## subset test data -> only the means and standard deviation measurements
test_data_subset <- subset(test_data, select = col_subset)
## mutate test data -> new columns activity_id and volunteer_id
test_data_subset <- mutate(test_data_subset, activity_id = test_y$V1, volunteer_id = subject_test$V1 )

## merge test and train data
merged_data <- rbind(train_data_subset, test_data_subset)

## Use descriptive activity names to name the activities in the data set
merged_data <- left_join(merged_data, activity_labels, by = "activity_id")

## Appropriately label the data set with descriptive variable names
names(merged_data) <- gsub("\\-", "\\_",names(merged_data))
names(merged_data) <- sub("mean\\(\\)", "Mean",names(merged_data))
names(merged_data) <- sub("std\\(\\)", "StD",names(merged_data))
names(merged_data) <- sub("BodyBody", "Body",names(merged_data))
names(merged_data) <- sub("^t", "time\\_",names(merged_data))
names(merged_data) <- sub("^f", "freq\\_",names(merged_data))

## arrange columns 
tidy_data <- select(merged_data, volunteer_id, activity_name, 1:66)

## creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data$activity_name <- as.factor(tidy_data$activity_name)
tidy_data$volunteer_id <- as.factor(tidy_data$volunteer_id)

tidy_avg_data <- aggregate(tidy_data, by=list(activity = tidy_data$activity_name, subject=tidy_data$volunteer_id), mean)
## remove columns "volunteer_id" and "activity_name"
tidy_avg_data <- select(tidy_avg_data, -volunteer_id, -activity_name)
write.table(tidy_avg_data, "tidy_data_set.txt", row.names = FALSE)
