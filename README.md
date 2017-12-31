# Getting-and-Cleaning-Data-Project

The files contained in this repository are the products of the Getting and Cleaning Data course project. 
The untidy inputs to the project are datasets found in: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip/
The output is a tidy data set called tidy_data.txt. 

The R script, run_analysis.R, generates tidy_data.txt from the input data by: 

<ul>
<li> Downloading and unzipping the file containing the untidy data
<li> Obtaining the identifiers for each experimental trial/record-the Activity and Subject for both trial and testing datasets
<li> Extracting the measurement variables that are means or standard deviations from the 561 feature variables for both trial and testing observations 
<li> Incorporating the activity and subject identifiers with the appropriate measurement values for both trial and testing observations
<li> Merging the trial and test observations to create one dataset
<li> Converting the Activity and Subject columns to factors with descriptive label names 
<li> Creating a new tidy dataset that contains the mean of each measurement variable for each Subject, Activity pair.  
</ul>
