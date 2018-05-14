#' ---
#' title: "run_analysis.R"
#' date: "May 12th 2018"
#' ---
#
#
#
## What is this 
# A script includes a function to read test and training data sets and to clean them up.
# I am including the reading part in case someone wants to rerun it.
## Result:
#  * mean_std_humanactivity: mean and stdev of all observations signals for the training and test data sets
#  * meanbyactivy_subject:  mean (avg and stdev) of signals by activity and subject data set
#  * A csv file is generated for each of the data sets. See CodeBook.{md,html} for more information about the source of the data and the content.
#  
#
## How to use run_analysis.R
#
#  * Extract the zip file
#  * Set WORKINGDIR to the top directory where you extracted the file from
#  * Run: Rscript ./run_analysis.R
#  
#  
## WORKINGDIR
#  Change the location of the root dir (top directory) where the data sets are
#  and set current working directory to it (use setwd(WORKINGDIR)
#
# 
WORKINGDIR="/home/eh/Desktop/training-tutorials-classes/R-johnhopkins/hw/ds/dataset"
setwd(WORKINGDIR)

#
## read_data_sets
# A function to reall all data sets. We have made the data frames read global and they will be visible in the top env.
#
read_data_sets <- function()
{


	# Read activity codes where we have the activity codes and the name of each activity.
	#
	activitycodes<<-read.table("activity_labels.txt", sep=" ", header=FALSE)
	colnames(activitycodes)<<-c("code", "activity")
	
	#
	# Read the variable codes  and names. These are variable codes (V1..V561 that we will see in X_train.txt and X_test.txt) and the variable names
	#
	variables<<-read.table("features.txt", header=FALSE)
	colnames(variables)<<-c("variablecode", "variablename")
	
	#
	# Read feature info. Not really meaniful but we can search it with regex and regmatch
	# Be patient here. Be a scientist and explore :-)
	# variableinfo<<-read.table("features_info.txt", header=FALSE)

	#
	# Read training data set. We will assign names to variables later	
    # 
	training<<-read.table("train/X_train.txt", header=FALSE)

	#
	# Read training activity codes set. We will assign names to variables later	
    # 
	trainingactivity<<-read.table("train/y_train.txt", header=FALSE)
	colnames(trainingactivity)<<-c("activitycode")

	#
	# subjects used in the training data set
	#

	trainingsubjects<<-read.table("train/subject_train.txt", header=FALSE)
	colnames(trainingsubjects)<<-c("subject")


	test<<-read.table("test/X_test.txt", header=FALSE)
	testactivity<<-read.table("test/y_test.txt",header=FALSE)
	colnames(testactivity)<<-c("activitycode")

	# subjects used in the test data set
	testsubjects<<-read.table("test/subject_test.txt", header=FALSE)
	colnames(testsubjects)<<-c("subject")
}

#
## Uncomment to call read_data_sets to read the data sets
read_data_sets()	



#
## Cleaning the data sets
#

## Verify that the two datasets have the same variable names before merging 
#  Here we want to make sure two data sets have the same names V1 .. Vn
table((names(training) == names(test)))

# 
# if they match(TRUE), then lets merge by appending test to training
# training_test will contain both the training and test rows and columns.

## Merge the data sets rowise by calling rbind. 
# Make sure you call rbind with the same ordering of the data frames
# 1. Merges the training and the test sets to create one data set.

training_test <- rbind(training, test)

# Verify that we have all the rows using dim

dim(test)
dim(training)
dim(training_test)


#
## Make sure we have the same variable names for all data sets
# Verify that the variable names V1 .. Vn in the data set are the same order
# as the ones we read in variable codes catalog above
#
v2<-paste0("V", variables$variablecode)
v<-colnames(training_test)
table(v == v2)

#
## Assign Column names to training_test
# Now assign names to column from features. Important that we do this before we add activities and subjects
#

colnames(training_test) <- variables$variablename

#
## Now merge subjects, the order is really important
#

allsubjects <- rbind(trainingsubjects, testsubjects);

#
##  Merge activities  from training and test
#
allactivities <- rbind(trainingactivity, testactivity);

#
# verify subjects
dim(allsubjects)
dim(allactivities)


#
# Now we have almost our combined data sets.
#
training_test$subject <- allsubjects$subject 
training_test$activitycode <- allactivities$activitycode

#
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Extract columns with mean() and std() in them
# We will build two logical vectors that we will "AND" to extract the desired column
# We will use grepl instead of regex because this is cleaner in this case.
#
# First we have to exclude meanFreq because they will match -mean 
# 
meanfreq <- grepl("-meanFreq()", (names(training_test)))

#
# Verify that we have the correct subset to exclude
#

names(training_test[, meanfreq])


# 
# This logical vector will aslo include meanFreq and we will exclude it later
ismeanstdvar<- grepl("-mean()|-std()", (names(training_test)))

#
# Our dataset
humanactivity_meanstdobservations <- training_test[, (ismeanstdvar & !meanfreq)]

#
# Verify datasets
#
names(humanactivity_meanstdobservations)
dim(humanactivity_meanstdobservations)

#
## Add subjects and activity code
#
# Now we have almost our combined data sets. Note that we are readdign them here before we merge
#
humanactivity_meanstdobservations$subject <- allsubjects$subject 
humanactivity_meanstdobservations$activitycode <- allactivities$activitycode
#
#

#
## 3. Uses descriptive activity names to name the activities in the data set
# We will merge our dataset with the activity names

mean_std_humanactivity <- merge(x=humanactivity_meanstdobservations, y=activitycodes, by.x="activitycode", by.y="code")

# We still have activity.x and activity.y lets use it to make sure our merge is what we want
#
 xl<- ( mean_std_humanactivity$activity.x != mean_std_humanactivity$activity.y)

# Verify the length of the logical vector

length(xl)

#
## 4. Appropriately labels the data set with descriptive variable names.
#  Cleanup the variable names a bit by removing the () in the name
#
colnames(mean_std_humanactivity) <- sub("\\(\\)","", names(mean_std_humanactivity))

#
## 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
#
# Get variables for which we will compute the mean

#
##  alln will contain the names of all variables (before we remove our indices used by group by

alln <- names(mean_std_humanactivity)

### Remove the variables by which we will group
vars <- sapply(alln, function(x) {  ! (( x %in% "activity" ) | (x %in% "subject") | (x %in% "activitycode")) })

# We will use mean of all vars by the group we are creating.
# Equivalent to group by v1, v2 in SQL and  by v1, v2 in SAS
# I wish there was something to do: mean(all) by v1,v2 

groupby <- list(mean_std_humanactivity$activity, mean_std_humanactivity$subject)
meanbyactivy_subject <- aggregate(mean_std_humanactivity[, vars], groupby, mean)


###  Rename the group by Variables since they show as Group.1 Group.2
#  Use names to find their positions in the data frame columns

names(meanbyactivy_subject)[1] <-"activity"
names(meanbyactivy_subject)[2] <-"subject"

dim(meanbyactivy_subject)

#meanbyactivy_subject

#
## Write the two data sets to a csv file
#  * mean_std_humanactivity: contains the mean of observations and their standard deviations
#  * meanbyactivy_subject: contains the means of all variables and all observations from mean_std_humanactivity.

#write.csv(mean_std_humanactivity, "./mean_std_humanactivity.csv");
#write.csv(meanbyactivy_subject, "./meanbyactivy_subject.csv");
write.table(mean_std_humanactivity, "./mean_std_humanactivity.csv", row.name=FALSE );
write.table(meanbyactivy_subject, "./meanbyactivy_subject.csv", row.name=FALSE );



#
# Create markdown and html files 
#
#library('rmarkdown')
#rmarkdown::render("run_analysis.R", clean=FALSE)

