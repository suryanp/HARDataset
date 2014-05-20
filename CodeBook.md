## Code book for Creating a Tidy Data Set Using Human Activity Recognition Using Smartphones Data Set 

The project is based on data collected from the accelerometers from the Samsung Galaxy S smartphone. The input dataset (HAR data set) is divided into two parts: training data (containing 70% of subjects) and test data (containing 30% of subjects).  

The R script "run_analysis.R"  provided in the repo reads the data provided in the HAR data set and creates a tidy data set with average measurements and average variance of the measurements.

The R script performs the following actions:

* The subject, measurement and activity data which are provided in three separate files for both training and test data are combined.

* The column names provided in the input data are replaced with descriptive names

* The test and training data are merged into one data set.

* For the purpose of this analysis only following measurements are included: 1) body and gravity acceleration time and frequency signal, 2) angular velocity time and frequency signal, 3)body linear acceleration and angular velocity jerk signal, and 4) magnitude of these three-dimensional signal

* The original data set consisted of 561 variables providing mean, standard deviation, median absolute deviation, max, min, etc from the signals.  For the purpose of this project only mean and standard deviation values are extracted. Additionally, since the subsequent steps would take the mean and average variance for each subject and activity combination, all measurements with average values for signals in a signal window sample (variables starting with "angle()") are ignored. 

* In all, the tidy data set consist of 69 columns: subject column, activity label, activity description, 33 average values, and 33 average variance values.

* For all the activities, activity description is appended

* Finally average of mean and standard deviation variables is calculated and a tidy data set is produced.
