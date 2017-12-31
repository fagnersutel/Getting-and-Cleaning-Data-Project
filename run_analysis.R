#download and unzip the dataset:
fileurl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "./data.zip",method="curl")
unzip("./data.zip")

#get activity labels and features:
actlabels=read.table("UCI HAR Dataset/activity_labels.txt")
actlabels[,2]=as.character(actlabels[,2])
features=read.table("UCI HAR Dataset/features.txt")
features[,2]=as.character(features[,2])

#features list 561 variables-some derived- measured during each of the training activity replication
#get only the mean and standard deviation features:
desiredfeatures=grep(".*mean.*|.*std.*",features[,2])
desiredfeaturesnames=features[desiredfeatures,2]
desiredfeaturesnames=gsub("-mean","Mean",desiredfeaturesnames)
desiredfeaturesnames=gsub("-std","Std",desiredfeaturesnames)
desiredfeaturesnames=gsub("[-()]","",desiredfeaturesnames)

#load datasets -filter out the columns with measurements on the mean and std variables desired 
#match each measurement with the particular activity from which it was derived-each row of training represents one of the six activities, and matches to the measurements of the variables on that activity
training=read.table("UCI HAR Dataset/train/X_train.txt")[desiredfeatures]
trainingacts=read.table("UCI HAR Dataset/train/Y_train.txt")
trainingsubjects=read.table("UCI HAR Dataset/train/subject_train.txt")
training=cbind(trainingsubjects,trainingacts,training)

testing=read.table("UCI HAR Dataset/test/X_test.txt")[desiredfeatures]
testingacts=read.table("UCI HAR Dataset/test/Y_test.txt")
testingsubjects=read.table("UCI HAR Dataset/test/subject_test.txt")
testing=cbind(testingsubjects,testingacts,testing)

#merge the dataset and add variable name labels
data=rbind(training,testing)
names(data)[3:ncol(data)]=desiredfeaturesnames
names(data)[1:2]=c("Subject","Activity")

#recode subject and activity as factor variables with descriptive levels 
data$Subject=factor(data$Subject)
data$Activity=factor(data$Activity,labels=tolower(actlabels[,2]))

#average of each variable for each activity and each subject
library(reshape2)
data_melt=melt(data,id=c("Subject","Activity"))
means_data=dcast(data_melt,Subject+Activity~variable,mean)


