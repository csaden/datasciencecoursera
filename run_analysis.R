# activities to assign to the labels of the data set
activities <- c("WALKING", "WALKING_UPSTAIRS",
                "WALKING_DOWNSTAIRS", "SITTING",
                "STANDING", "LAYING")

# read in training data (x), labels (y), and ids
train_x <- read.table("./train/X_train.txt")
train_y <- read.table("./train/y_train.txt")
train_ids <- read.table("./train/subject_train.txt")

# create train data frame
train <- as.data.frame(cbind(train_x, train_y, train_ids))

# remove unneeded variables
rm(train_x)
rm(train_y)
rm(train_ids)

# add activity and id named variables to train df
colnames(train)[562] <- "activity"
colnames(train)[563] <- "id"

# set activity levels as factor
train$activity <- factor(train$activity, levels = c(1, 2, 3, 4, 5, 6),
                         labels = activities)
# set id as factor
train$id <- factor(train$id)

# read in test data (x), labels (y), and ids
test_x <- read.table("./test/X_test.txt")
test_y <- read.table("./test/y_test.txt")
test_ids <- read.table("./test/subject_test.txt")

# create test data frame
test <- as.data.frame(cbind(test_x, test_y, test_ids))

# remove unneeded variables
rm(test_x)
rm(test_y)
rm(test_ids)

# add activity and id named variables to test df
colnames(test)[562] <- "activity"
colnames(test)[563] <- "id"

# set activity levels as factor
test$activity <- factor(test$activity, levels = c(1, 2, 3, 4, 5, 6),
                         labels = activities)

# set id as factor
test$id <- factor(test$id)

# create one data frame from test and train dfs
allData <- as.data.frame(rbind(test, train))

# read in featureNames for colnames
featureNames <- read.table("./features.txt")
featureNames <- as.vector(featureNames[, 2])

# assign colnames
colnames(allData) <- c(featureNames, "activity", "id")

# subset the combined data frame to include only mean and sd measures

indices <- grep("mean\\(\\)|std\\(\\)", featureNames, ignore.case = T, value = T)
cols <- append(indices, c("id", "activity"))

mean_sd_data <- subset(allData, select = cols)

mean_sd_data$id <- factor(mean_sd_data$id,
                          levels = 1:30)

mean_sd_data <- mean_sd_data[with(mean_sd_data, order(id, activity)), ]

# plyr - works

library(dplyr)
groups <- group_by(mean_sd_data, id, activity)

# the names of the columns we want to summarize
# is indices

# the dots component of the call to summarise
dots <- sapply(indices, function(x) substitute(mean(x), list(x=as.name(x))))
tidyData <- do.call(summarise, c(list(.data = groups), dots))

# order the tidy data frame by id
tidyData$id <- factor(tidyData$id,
                          levels = 1:30)

# sort the tidy data set
tidyData <- tidyData[with(tidyData, order(id, activity)), ]
