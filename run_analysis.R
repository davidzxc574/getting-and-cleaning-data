#1.Read all datasets after downloading and unzipping to a desired folder
setwd("E:/documents/IT tutorial/data science/getting and cleaning data/UCI HAR Dataset")
rm(list=ls())
subject_test<-read.csv("./test/subject_test.txt",header=FALSE)
test_set<-read.table("./test/X_test.txt",header=FALSE)
test_label<-read.table("./test/y_test.txt",header=FALSE)

subject_train<-read.table("./train/subject_train.txt",header=FALSE)
train_label<-read.table("./train/y_train.txt",header=FALSE)
train_set<-read.table("./train/X_train.txt",header=FALSE)

features = read.table("./features.txt",header=FALSE)
activities = read.table("./activity_labels.txt",header=FALSE)

#2.Give data descriptive column names
colnames(subject_test)<-"subject"
colnames(subject_train)<-"subject"
colnames(test_label)<-"activity_id"
colnames(train_label)<-"activity_id"
colnames(activities)<-c("id","activity")
colnames(features)<-c("id","feature")

#3.Extracts only the measurements on the mean and standard deviation for each measurement. 
featuresIndex<-grep(".-mean().|.-std().",features$feature)
featuresNeeded<-features[featuresIndex,2]

#4.Give features descriptive names. 
featuresNeeded=gsub("-mean","Mean",featuresNeeded)
featuresNeeded=gsub("-std","StandardDeviation",featuresNeeded)
featuresNeeded=gsub("[-()]","",featuresNeeded)
featuresNeeded=gsub("^t", "Time", featuresNeeded)
featuresNeeded=gsub("^f", "Frequency", featuresNeeded)
featuresNeeded=gsub("Acc", "Accelerometer", featuresNeeded)
featuresNeeded=gsub("Gyro", "Gyroscope", featuresNeeded)
featuresNeeded=gsub("Mag", "Magnitude", featuresNeeded)
featuresNeeded=gsub("BodyBody", "Body", featuresNeeded)

#5.Select features needed from train and test datasets 
train_set<-train_set[,featuresIndex]
test_set<-test_set[,featuresIndex]

colnames(train_set)<-featuresNeeded
colnames(test_set)<-featuresNeeded

#6.Combine train and test datasets
test_combined<-cbind(subject_test,test_label,test_set)
train_combined<-cbind(subject_train,train_label,train_set)

#7.Give activities descriptive names
combined<-rbind(test_combined,train_combined)
#dataall2<-merge(dataall,activities,by.x="activity_id",by.y="id",all=TRUE)
combined$activity=factor(combined$activity_id,levels=activities[,1],labels=activities[,2])
combined$activity_id<-NULL

#8.create a tidy data set with the average of each variable for each activity and each subject
#and write it to a txt file
library(plyr)
final<-aggregate(.~subject+activity,combined,mean)
write.table(final,file="test and train average.txt",row.names=FALSE)