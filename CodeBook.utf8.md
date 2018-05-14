

```r
#
##   Monitoring human activity using a Samsung phone
#  See the companion run_analysis.* R script, md and html files

# Requirement: Renders only inside Rstudio if you have rmarkdown and dependencies installed

## See data summaries bellow.
##
# The following is the information about the data. Our data reduction can be found at the bottom of this document and in run_analysis.* files.
#

## Data sources
### Original data set used: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
### Additional information about the data set: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
#
## Citation and references:
# Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.


##  Data summaries 
#
# The reduced data sets are in the following csv files. Reductions was accomplished via run_analysis.R
#
#
#  
#### Content of mean_std_humanactivity

names(mean_std_humanactivity)
```

```
##  [1] "activitycode"              "tBodyAcc-mean-X"          
##  [3] "tBodyAcc-mean-Y"           "tBodyAcc-mean-Z"          
##  [5] "tBodyAcc-std-X"            "tBodyAcc-std-Y"           
##  [7] "tBodyAcc-std-Z"            "tGravityAcc-mean-X"       
##  [9] "tGravityAcc-mean-Y"        "tGravityAcc-mean-Z"       
## [11] "tGravityAcc-std-X"         "tGravityAcc-std-Y"        
## [13] "tGravityAcc-std-Z"         "tBodyAccJerk-mean-X"      
## [15] "tBodyAccJerk-mean-Y"       "tBodyAccJerk-mean-Z"      
## [17] "tBodyAccJerk-std-X"        "tBodyAccJerk-std-Y"       
## [19] "tBodyAccJerk-std-Z"        "tBodyGyro-mean-X"         
## [21] "tBodyGyro-mean-Y"          "tBodyGyro-mean-Z"         
## [23] "tBodyGyro-std-X"           "tBodyGyro-std-Y"          
## [25] "tBodyGyro-std-Z"           "tBodyGyroJerk-mean-X"     
## [27] "tBodyGyroJerk-mean-Y"      "tBodyGyroJerk-mean-Z"     
## [29] "tBodyGyroJerk-std-X"       "tBodyGyroJerk-std-Y"      
## [31] "tBodyGyroJerk-std-Z"       "tBodyAccMag-mean"         
## [33] "tBodyAccMag-std"           "tGravityAccMag-mean"      
## [35] "tGravityAccMag-std"        "tBodyAccJerkMag-mean"     
## [37] "tBodyAccJerkMag-std"       "tBodyGyroMag-mean"        
## [39] "tBodyGyroMag-std"          "tBodyGyroJerkMag-mean"    
## [41] "tBodyGyroJerkMag-std"      "fBodyAcc-mean-X"          
## [43] "fBodyAcc-mean-Y"           "fBodyAcc-mean-Z"          
## [45] "fBodyAcc-std-X"            "fBodyAcc-std-Y"           
## [47] "fBodyAcc-std-Z"            "fBodyAccJerk-mean-X"      
## [49] "fBodyAccJerk-mean-Y"       "fBodyAccJerk-mean-Z"      
## [51] "fBodyAccJerk-std-X"        "fBodyAccJerk-std-Y"       
## [53] "fBodyAccJerk-std-Z"        "fBodyGyro-mean-X"         
## [55] "fBodyGyro-mean-Y"          "fBodyGyro-mean-Z"         
## [57] "fBodyGyro-std-X"           "fBodyGyro-std-Y"          
## [59] "fBodyGyro-std-Z"           "fBodyAccMag-mean"         
## [61] "fBodyAccMag-std"           "fBodyBodyAccJerkMag-mean" 
## [63] "fBodyBodyAccJerkMag-std"   "fBodyBodyGyroMag-mean"    
## [65] "fBodyBodyGyroMag-std"      "fBodyBodyGyroJerkMag-mean"
## [67] "fBodyBodyGyroJerkMag-std"  "subject"                  
## [69] "activity"
```

```r
### content of meanbyactivy_subject.csv

names(meanbyactivy_subject)
```

```
##  [1] "activity"                  "subject"                  
##  [3] "tBodyAcc-mean-X"           "tBodyAcc-mean-Y"          
##  [5] "tBodyAcc-mean-Z"           "tBodyAcc-std-X"           
##  [7] "tBodyAcc-std-Y"            "tBodyAcc-std-Z"           
##  [9] "tGravityAcc-mean-X"        "tGravityAcc-mean-Y"       
## [11] "tGravityAcc-mean-Z"        "tGravityAcc-std-X"        
## [13] "tGravityAcc-std-Y"         "tGravityAcc-std-Z"        
## [15] "tBodyAccJerk-mean-X"       "tBodyAccJerk-mean-Y"      
## [17] "tBodyAccJerk-mean-Z"       "tBodyAccJerk-std-X"       
## [19] "tBodyAccJerk-std-Y"        "tBodyAccJerk-std-Z"       
## [21] "tBodyGyro-mean-X"          "tBodyGyro-mean-Y"         
## [23] "tBodyGyro-mean-Z"          "tBodyGyro-std-X"          
## [25] "tBodyGyro-std-Y"           "tBodyGyro-std-Z"          
## [27] "tBodyGyroJerk-mean-X"      "tBodyGyroJerk-mean-Y"     
## [29] "tBodyGyroJerk-mean-Z"      "tBodyGyroJerk-std-X"      
## [31] "tBodyGyroJerk-std-Y"       "tBodyGyroJerk-std-Z"      
## [33] "tBodyAccMag-mean"          "tBodyAccMag-std"          
## [35] "tGravityAccMag-mean"       "tGravityAccMag-std"       
## [37] "tBodyAccJerkMag-mean"      "tBodyAccJerkMag-std"      
## [39] "tBodyGyroMag-mean"         "tBodyGyroMag-std"         
## [41] "tBodyGyroJerkMag-mean"     "tBodyGyroJerkMag-std"     
## [43] "fBodyAcc-mean-X"           "fBodyAcc-mean-Y"          
## [45] "fBodyAcc-mean-Z"           "fBodyAcc-std-X"           
## [47] "fBodyAcc-std-Y"            "fBodyAcc-std-Z"           
## [49] "fBodyAccJerk-mean-X"       "fBodyAccJerk-mean-Y"      
## [51] "fBodyAccJerk-mean-Z"       "fBodyAccJerk-std-X"       
## [53] "fBodyAccJerk-std-Y"        "fBodyAccJerk-std-Z"       
## [55] "fBodyGyro-mean-X"          "fBodyGyro-mean-Y"         
## [57] "fBodyGyro-mean-Z"          "fBodyGyro-std-X"          
## [59] "fBodyGyro-std-Y"           "fBodyGyro-std-Z"          
## [61] "fBodyAccMag-mean"          "fBodyAccMag-std"          
## [63] "fBodyBodyAccJerkMag-mean"  "fBodyBodyAccJerkMag-std"  
## [65] "fBodyBodyGyroMag-mean"     "fBodyBodyGyroMag-std"     
## [67] "fBodyBodyGyroJerkMag-mean" "fBodyBodyGyroJerkMag-std"
```

```r
#
# We preserved the same variables names as in the raw data except that () in the names have been removed.
#
# For more information see:
#   * run_analysis.R
#   * run_analysis.utf8.md
#   * run_analysis.html

#
# Generate the markdown from this file and from R studio. Do not simply call them from here 
# 

#library(rmarkdown)
#rmarkdown::render("run_analysis.R", clean=FALSE)


## Feature Selection 
# =================
# 
# The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
# 
# Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
# 
# Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
# 
# These signals were used to estimate variables of the feature vector for each pattern:  
# '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
# 
# tBodyAcc-XYZ
# tGravityAcc-XYZ
# tBodyAccJerk-XYZ
# tBodyGyro-XYZ
# tBodyGyroJerk-XYZ
# tBodyAccMag
# tGravityAccMag
# tBodyAccJerkMag
# tBodyGyroMag
# tBodyGyroJerkMag
# fBodyAcc-XYZ
# fBodyAccJerk-XYZ
# fBodyGyro-XYZ
# fBodyAccMag
# fBodyAccJerkMag
# fBodyGyroMag
# fBodyGyroJerkMag
# 
# The set of variables that were estimated from these signals are: 
# 
# mean(): Mean value
# std(): Standard deviation
# mad(): Median absolute deviation 
# max(): Largest value in array
# min(): Smallest value in array
# sma(): Signal magnitude area
# energy(): Energy measure. Sum of the squares divided by the number of values. 
# iqr(): Interquartile range 
# entropy(): Signal entropy
# arCoeff(): Autorregresion coefficients with Burg order equal to 4
# correlation(): correlation coefficient between two signals
# maxInds(): index of the frequency component with largest magnitude
# meanFreq(): Weighted average of the frequency components to obtain a mean frequency
# skewness(): skewness of the frequency domain signal 
# kurtosis(): kurtosis of the frequency domain signal 
# bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
# angle(): Angle between to vectors.
# 
# Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
# 
# gravityMean
# tBodyAccMean
# tBodyAccJerkMean
# tBodyGyroMean
# tBodyGyroJerkMean
# 
# The complete list of variables of each feature vector is available in 'features.txt'
#
```


---
title: "CodeBook.R"
author: "eh"
date: "Mon May 14 09:31:20 2018"
---
