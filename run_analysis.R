#Course Project

#remove current objects in environment
rm(list=ls())


#updating file path and set work directory
wd <- "~/Desktop/Coursera/Getting and Cleaning Data/Course Project"
setwd(wd)

#read in feature names
feature <- read.table(file="./UCI HAR Dataset/features.txt", header=FALSE)

#training set
X_train <- read.table(file="./UCI HAR Dataset/train/X_train.txt", header=FALSE)
colnames(X_train) <- tolower(feature$V2)
y_train <- read.table(file="./UCI HAR Dataset/train/y_train.txt", header=FALSE)
subject_train <- read.table(file="./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
#added a label variable noting that the observation comes from the training set
training_set <- data.frame("Training Set",subject_train, y_train, X_train)
colnames(training_set)[1:3] <- c("Source", "SubjectID", "Activity Code")

#test set
X_test <- read.table(file="./UCI HAR Dataset/test/X_test.txt", header=FALSE)
colnames(X_test) <- tolower(feature$V2)
y_test <- read.table(file="./UCI HAR Dataset/test/y_test.txt", header=FALSE)
subject_test <- read.table(file="./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
#added a label variable noting that the observation comes from the test set
test_set <- data.frame("Test Set", subject_test, y_test, X_test)
colnames(test_set)[1:3] <- c("Source", "SubjectID", "Activity Code")

# 1. Merges the training and the test sets to create one data set.
# I will stack the datasets on top of each other.  The Source variable
# will allow us to identify whether the observation comes from the test or training set
stacked <- rbind(training_set, test_set)
colnames(stacked) <- c("Source", "SubjectID", "Activity Code", tolower(feature$V2))

# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement.

# I will use the feature vector to determine which feature names contained mean and std
feature$mean <- grepl(c("mean"), tolower(feature$V2))
feature$std <- grepl(c("std"), tolower(feature$V2))
feature$mean_std <- feature$mean+feature$std
mean_std_var <- as.character(tolower(feature[feature$mean_std==1,c("V2")]))

#subsetting
keep_var <- c("Source", "SubjectID", "Activity Code", mean_std_var)
stacked2 <- stacked[keep_var]

# 3. Uses descriptive activity names to name the activities in the data set
#read in activity encoding
activity <- read.table(file="./UCI HAR Dataset/activity_labels.txt", header=FALSE)
colnames(activity) <- c("Activity Code", "Activity Label")

#merge the labels with the stacked2 dataset
stacked3 <- merge(stacked2, activity, by="Activity Code", sort=FALSE)


# 4. Appropriately labels the data set with descriptive variable names.

# The names of the variables of the stacked 3 dataset already reflect
# names included in the features.txt file, whose explanations are contained in
# file features_info.txt file.
names(stacked3)


# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
average <- aggregate(stacked3[,4:89], by=list(SubjectID=stacked3$SubjectID, 
                                              ActivityCode=stacked3[,"Activity Code"], 
                                              ActivityLabel=stacked3[,"Activity Label"]), 
                     FUN=mean, na.action=na.omit)
average <- average[order(average$SubjectID, average$ActivityCode, 
                         average$ActivityLabel),]
write.table(average, file="average.txt", row.names=FALSE)
