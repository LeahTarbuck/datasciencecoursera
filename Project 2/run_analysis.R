# Prerequisite - Esnure you have set your working directory properly beforehand.
#                Ensure you have downloaded the data.table package.

# set variables up front
full_filename = "./dataset/Dataset.zip"
dir = "./dataset"
filename = "Dataset.zip"
unzipped_filename = "./dataset/UCI HAR Dataset"

# Create the zipped dataset if it does not exist.
# donwload the file using mode wb (binary) to avoid error: "error 1 in extracting from zip file".
# when trying to unzip the file.
if(!file.exists(full_filename)){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, full_filename, mode="wb")
}

# Unzip data file to /dataset directory
if(!file.exists(unzipped_filename)){
    unzip(zipfile=full_filename,exdir=dir)
}

# Read tables into variables
# Read the testing tables:
x_test = read.table("./dataset/UCI HAR Dataset/test/X_test.txt")
y_test = read.table("./dataset/UCI HAR Dataset/test/y_test.txt")
subject_test = read.table("./dataset/UCI HAR Dataset/test/subject_test.txt")

# Read the trainings tables:
x_train = read.table("./dataset/UCI HAR Dataset/train/X_train.txt")
y_train = read.table("./dataset/UCI HAR Dataset/train/y_train.txt")
subject_train = read.table("./dataset/UCI HAR Dataset/train/subject_train.txt")

# Read the feature table:
features = read.table("./dataset/UCI HAR Dataset/features.txt")

# Read activity table:
activity_labels = read.table("./dataset/UCI HAR Dataset/activity_labels.txt")

# Rename columns to be more meaningful
# Use the list of features for the x_train and x_test datasets
colnames(x_train) = features[,2] 
colnames(x_test) = features[,2] 
colnames(y_train) = "activity_id"
colnames(y_test) = "activity_id"
colnames(subject_train) = "subject_id"
colnames(subject_test) = "subject_id"
# Concat names together and apply to the activities_labels table
colnames(activity_labels) = c('activity_id','activity_type')

# Use id's labelled above to merge training and test datasets into one
merge_train = cbind(x_train, subject_train, y_train)
merge_test = cbind(x_test, subject_test, y_test)
# Merge rows together to get the full dataset
merge_all = rbind(merge_train, merge_test)

# create a vector to filter standard deviation, mean and id columns
filter_mean_std = (grepl("mean",colnames(merge_all)) 
                    | grepl("std",colnames(merge_all)) 
                    | grepl("activity_id",colnames(merge_all)) 
                    | grepl("subject_id",colnames(merge_all)))

# Use filter vector on full dataset
filtered_data = merge_all[, filter_mean_std == TRUE]
# View(filtered_data)

# Apply activity labels to filtered data to create a data set ordered by activity type.
activity_data = merge(filtered_data, activity_labels,
                              by='activity_id',
                              all.x=TRUE)

# import the data.table package to comput SD and mean on columns and group by subject_id and activity.
library(data.table)
data = data.table(activity_data)
TidyData = data[, lapply(.SD, mean), by=c("subject_id", "activity_type")]

# Write this tidy dataset to a text file
write.table(TidyData, "TidyData.txt", row.name=FALSE)
