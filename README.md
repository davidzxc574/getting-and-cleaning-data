### Introduction
This READEME file explains how the script, run_analysis.R, under the same repository completes the course 
project from getting and cleaning data.

### Prerequesite
The user should download the dataset via this link 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. This file should
be unzipped into the folder where R has set path to. In my case it is 
"E:/documents/IT tutorial/data science/getting and cleaning data/UCI HAR Dataset". The user can change 
this directory as he or she needs.

### Function of run_analysis.R
This script performs the following tasks
1. Import downloaded datasets into R    
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names. 
6. Based on steps from above, creates a second and independent tidy dataset,"final", with the 
average of each variable for each activity and each subject
7. Dataset "final" is written to create a file, "test and train average.txt", under R working directory