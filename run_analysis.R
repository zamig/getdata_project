## The project for the Getting and Cleaning Data course.

library(reshape2)


## ************ Part 1 ********************************************************
# Merging the training and the test sets to create one data set.

# ============ Loading the Features Data =====================================
feature_train <- read.table("./train/X_train.txt", stringsAsFactors=FALSE)
feature_test <- read.table("./test/X_test.txt", stringsAsFactors=FALSE)
feature_list <- rbind(vars_train, vars_test)

# ============ Loading the Features Names =====================================  
features_names <- read.table("./features.txt",stringsAsFactors=FALSE)[,2]

# ============ Loading the Subjects Data =====================================
subject_train <- read.table("./train/subject_train.txt", stringsAsFactors=FALSE)
subject_test <- read.table("./test/subject_test.txt", stringsAsFactors=FALSE)
subject_list <- rbind(subject_train, subject_test)

# ============ Loading the Activities Data ===================================
activity_train <- read.table("./train/y_train.txt", stringsAsFactors=FALSE)
activity_test <- read.table("./test/y_test.txt", stringsAsFactors=FALSE)
activity_list <- rbind(activity_train, activity_test)

## Merging the data to one data frame
dataSetFull <- cbind(subject_list, activity_list, vars_list)
names(dataSetFull) <- append(c("Subject", "Activity"), features_names)


## ************ Part 2 ********************************************************
# Extracting only the measurements on the mean and standard deviation for each measurement.

mean_std_features <- features_names[grepl("mean\\(|std", features_names)]
dataSet <- dataSetFull[, c("Subject", "Activity", mean_std_features)]


## ************ Part 3 ********************************************************
# Using descriptive activity names to name the activities in the data set.

# Loading the Activities Descriptions
activity_titles <- read.table("./activity_labels.txt")

# Replacing the numeric vector of activities with the names of the activities
dataSet$Activity <- activity_titles[dataSet$Activity, 2]


## ************ Part 4 ********************************************************
# Appropriately labeling the data set with descriptive variable names.

# Removing illegal chars - '(', ')', '-'.
names(dataSet) <- make.names(names(dataSet), unique = TRUE)

# Substitutues to be done with the fixed gsub option.
substitutes <- rbind(c("BodyBody", "Body"), c(".std", "Std"), c(".mean", "Mean"), 
                     c("Acc", "Accelerometer"), c("Gyro", "Gyroscope"), 
                     c("Mag", "Magnitude"), c(".", ""))

# Substitutes to be use with the perl option - finding "t" or "f" only at the starting 
# position of the name.
substitutesRegexp <- rbind(c("^t", "time"), c("^f", "freq"))


for (i in 1:nrow(substitutes))
  names(dataSet) <- gsub(substitutes[i, 1], substitutes[i, 2], names(dataSet), fixed = TRUE)


for (i in 1:nrow(substitutesRegexp))
  names(dataSet) <- sub(substitutesRegexp[i, 1], substitutesRegexp[i, 2], names(dataSet), perl = TRUE)


## ************ Part 5 ********************************************************
# Ceating a tidy data set with the average of each variable for each activity and each subject.
# Using melt and dcast from the reshape2 package.

avgDataSet <- dcast(melt(dataSet, id = c("Subject", "Activity")), Subject + Activity ~ variable, mean)

# Writing the data set to file
write.table(avgDataSet, file = "final_ds.txt", row.name=FALSE)