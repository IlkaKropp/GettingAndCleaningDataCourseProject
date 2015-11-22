# Code Book
The R script run_analysis.R and the data folder "UCI HAR Dataset" should located in the same directory.

## Source Data
Data can be loaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#### Attribute Information:

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment. 

#### Data

Following files were loaded

-  'features.txt': List of all features
-  'activity_labels.txt': Links the class labels with activity names
-  'subject_train.txt': Volunteers in training data set
-  'train/X_train.txt': Training set
-  'train/Y_train.txt': Training labels
-  'subject_test.txt': Volunteers in test data set
-  'test/X_test.txt': Test set
-  'test/Y_test.txt': Test labels

#### Dependencies

The script run_analysis.R depends on the libraries dplyr.

#### Steps to tidy up the data set

1. The training and the test sets were merged to create one data set. 
  File column names for train data (X_train.txt) are located in Y_train.txt, volunteers id is located in subject_train.txt. 
  File column names for train data (X_test.txt) are located in Y_test.txt, volunteers id is located in subject_test.txt.
2. Only the measurements on the mean and standard deviation for each measurement were extracted, these measurments are identified by phrase "mean()" and "std()". 
3. From activity_labels.txt descriptive activity names were used to name the activities in the data set.
4. The data set were labeled with descriptive variable names. 
  Original variable names were modified in the follonwing way:
  -  Replaced - with _ 
  -  Replaced mean with Mean
  -  Replaced std with Std
  -  Removed parenthesis ()
  -  Replaced BodyBody with Body

