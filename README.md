# GettingAndCleaningData_CourseProject
Course project for Coursera Getting and Cleaning Data class

## Project Overview
(this section is taken directly from course website https://class.coursera.org/getdata-014/human_grading/view/courses/973501/assessments/3/submissions)

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

You should create one R script called run_analysis.R that does the following.   
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive variable names.   
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

## Files in Repository
- **run_analysis.R**: This script will transform the raw data into the new tidy data set as described in the Project Overview.  See "Raw Data" & "Details..." sections for more information
- **course_project_new_tidy.txt**: the output data set from run_analysis.R
- **CodeBook.md**: describes the variables in course_project_new_tidy.txt

## Raw data
The raw data can be downloaded here  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

run_analysis.R needs the following files from thie data set:  
- activity_labels.txt  
- features.txt  
- train/subject_train.txt  
- train/X_train.txt  
- train/y_train.txt  
- test/subject_test.txt  
- test/X_test.txt  
- test/y_test.txt  

## Details on run_analysis.R execution

*You should create one R script called run_analysis.R that does the following.*

*1) Merges the training and the test sets to create one data set.*  
Subject and activity ids are first bound to the feature data.  This is done for both the Test and Train data.  The Test data is then appended to the end of the Train data

*2)Extracts only the measurements on the mean and standard deviation for each measurement.*  
All features with "-mean" or "-std", along with subject_id and activity_id are selected for a new interim data set

*3)Uses descriptive activity names to name the activities in the data set*  
The activity_id column is changed from an integer to a factor with labels from the activity_labels.txt data set

*4)Appropriately labels the data set with descriptive variable names.*   
All of the columns from the features data are given their respective titles from the features.txt data set

*5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.*  
The interim data set is aggregated by subject_id and activity_id and the mean is calculated for all remaining columns 