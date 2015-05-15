##################################################################
##
##  This script reads in a number of raw data files, combines
##  a number of them, "tidies them up", and aggregates the data 
##  into a new data set that is written out to a file
##
##  this script should be accompanied by a README file and code
##  book that give more details
##
##################################################################

##
## check to see if the right files exist
##
stopifnot(file.exists("activity_labels.txt"),
          file.exists("features.txt"),
          file.exists("train/subject_train.txt"),
          file.exists("train/X_train.txt"),
          file.exists("train/y_train.txt"),
          file.exists("test/subject_test.txt"),
          file.exists("test/X_test.txt"),
          file.exists("test/y_test.txt")
          )

##
## read in the files
##
activity_labels   <- read.table("activity_labels.txt", col.names=c("activity_id","desc"), stringsAsFactors=F)
features          <- read.table("features.txt", col.names=c("feature_id","desc"), stringsAsFactors=F)
subject_train     <- read.table("train/subject_train.txt", col.names="subject_id")
X_train           <- read.table("train/X_train.txt",colClasses="numeric")
y_train           <- read.table("train/y_train.txt", col.names="activity_id")
subject_test      <- read.table("test/subject_test.txt", col.names="subject_id")
X_test            <- read.table("test/X_test.txt",colClasses="numeric")
y_test            <- read.table("test/y_test.txt", col.names="activity_id")

##
## merge files
## first merge the activities and subjects to the features 
## second merge the test and train data
##
train_data <- cbind(subject_train, y_train, X_train)
test_data <- cbind(subject_test, y_test, X_test)
total_data <- rbind(train_data, test_data)

##
## select just the mean and sd data
##
mean_std_features <- grepl("-mean",features$desc) | grepl("-std",features$desc)
subset_data <- total_data[, c(T,T,mean_std_features)]
  
##
## change the activity ids in subset_data into factors with the activity descriptions
##
subset_data$activity_id <- factor(subset_data$activity_id, labels=activity_labels$desc)

##
## give the feature data better column names, based on the features data set
##
names(subset_data)[3:81] <- features$desc[mean_std_features]

##
## create new tidy data set and print it to a file
##
new_tidy <- aggregate(subset_data[,3:81], 
                      by=list(subject_id=subset_data$subject_id,activity_id=subset_data$activity_id), 
                      mean
                     )
write.table(new_tidy, "course_project_new_tidy.txt", sep=" ", row.names=F)
