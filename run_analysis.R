if(!file.exists("./UCI HAR Dataset")) {
    stop("UCI HAR Dataset directory should be available under current working directory.")
}

load.X <- function(dataFile, features, selected.features.ids, numrows) {
    nFeatures <- nrow(features)
    
    # Will work only with means and standard deviations
    selected.colClasses <- rep("numeric", length(selected.features.ids))
    
    selected.widths <- rep(-16, nFeatures)
    selected.widths[selected.features.ids] <- 16
    
    X <- read.fwf(dataFile, sep="", widths=selected.widths, n=numrows, 
                  nrows=numrows, colClasses=selected.colClasses, 
                  col.names=features[selected.features.ids,2], stringsAsFactors=FALSE, 
                  buffersize=1000, comment.char="")

    X
}

# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 
features <- read.table("./UCI HAR Dataset/features.txt", 
                       sep=" ", 
                       col.names=c("column", "name"),
                       as.is=T)

selected.features.ids <- grep("^.+-(mean|std)\\(\\)-.$", features$name)
newNames <- gsub("-", ".", features$name, fixed=T)
newNames <- gsub("()", "", newNames, fixed=T)
newNames <- gsub("([A-Z])", ".\\L\\1", newNames, perl=T)
newNames <- gsub("..", ".", newNames, fixed=T)
features$name <- newNames

# 1. Merges the training and the test sets to create one data set.
X.test <- load.X("./UCI HAR Dataset//test//X_test.txt", features, selected.features.ids, 3000)
y.test <- read.table("./UCI HAR Dataset//test//y_test.txt", col.names="activity.id")
s.test <- read.table("./UCI HAR Dataset//test//subject_test.txt", col.names="subject.id")
test <- cbind(s.test, y.test, X.test)

X.train <- load.X("./UCI HAR Dataset//train/X_train.txt", features, selected.features.ids, 7400)
y.train <- read.table("./UCI HAR Dataset//train//y_train.txt", col.names="activity.id")
s.train <- read.table("./UCI HAR Dataset//train//subject_train.txt", col.names="subject.id")
train <- cbind(s.train, y.train, X.train)

dataset <- rbind(train, test)

# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
activities.table <- read.table("./UCI HAR Dataset/activity_labels.txt", sep=" ", 
                               col.names=c("activity.id", "activity.name"))
activities <- merge(dataset, activities.table)

# 5. Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject. 
library(reshape2)
activities$subject.id <- as.factor(activities$subject.id)
tidy.activities <- melt(activities, id=c("subject.id", "activity.name"), 
                        measure.vars=newNames[selected.features.ids])

averages <- dcast(tidy.activities, subject.id + activity.name ~ variable, mean)

write.csv(averages, "activities_averages.csv", row.names=FALSE, quote=FALSE)
