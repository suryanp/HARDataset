run_analysis.R
==========

This repo contains a R script "run_analysis.R" which processes Human Activity Recognition Data Set.  This data was collected from the accelerometers from the Samsung Galaxy S smartphone.

The code can be saved and run from the working directory. The code assumes that the HAR data set is downloaded and extracted onto the working directory.  In case the data is not downloaded, the first three lines can be uncommented in the code to download and extract the data. The code also assumes that the extracted directory names are not altered.

The code reads the data provided in the HAR data set and creates a tidy data set with average measurements and average variance of the measurements.  

Once the code is run a tidy data set called "HumanActivityRecognitionTidyData.txt" is created in the working directory.  Please open the text file in R or a spreadsheet tool for the ease of reading.



