### UCI HAR Activities Averages CodeBook
This codebook describes all variables available on UCI HAR Activities Averages dataset.  
  
Each observation corresponds to an unique key composed by pair of a volunteer (anonymous) 
and an activity name performed by the volunteer.
* **subject.id** : numeric identifier designated to each of the 30 volunteers, ranging from 1 to 30.
* **activity.name** : one of 
    * LAYING
    * SITTING
    * STANDING
    * WALKING
    * WALKING_DOWNSTAIRS
    * WALKING_UPSTAIRS
  
Every other variable name is presented using the following schema definition:
```
<prefix>.<measurement>.<summary>.<axis>
```

Where: 

#### Prefix
* **t** : Measurements prefixed with 't' describes time captured at a constant rate of 50Hz with noise removed. Magnitude were calculated using the Euclidean norm. 
* **f** : Measures prefixed with 'f' are equivalent to their 't' counterpart but with a Fast Fourier Transform applied to convert time into frequency.

#### Measurement
* **body.acc** : Body acceleration, provided by an accelerometer
* **gravity.acc** : Gravity acceleration, provided by an accelerometer
* **body.gyro** : Body orientation, provided by a gyroscope
* **body.acc.jerk** : signal obtained from acceleration and angular velocity derived by time
* **body.gyro.jerk** : 

#### Summary
* **mean** : Mean calculated over all observations presented in the original UCI HAR Activities dataset for each combination of volunteer and activity.
* **std** : Standard deviation calculated over all observation presented in the original UCI HAR Activities dataset for each combination of volunteer and activity.

#### Axis
* **x**, **y**, **z** : Variables were measured by an accelerometer and a gyroscope. Both devices are 3-axial, so every measurement has three components (x, y and z). 
  
  
All variable names below came from the aforementioned schema and are present in this dataset: 
* t.body.acc.mean.x
* t.body.acc.mean.y
* t.body.acc.mean.z
* t.body.acc.std.x
* t.body.acc.std.y
* t.body.acc.std.z
* t.gravity.acc.mean.x
* t.gravity.acc.mean.y
* t.gravity.acc.mean.z
* t.gravity.acc.std.x
* t.gravity.acc.std.y
* t.gravity.acc.std.z
* t.body.acc.jerk.mean.x
* t.body.acc.jerk.mean.y
* t.body.acc.jerk.mean.z
* t.body.acc.jerk.std.x
* t.body.acc.jerk.std.y
* t.body.acc.jerk.std.z
* t.body.gyro.mean.x
* t.body.gyro.mean.y
* t.body.gyro.mean.z
* t.body.gyro.std.x
* t.body.gyro.std.y
* t.body.gyro.std.z
* t.body.gyro.jerk.mean.x
* t.body.gyro.jerk.mean.y
* t.body.gyro.jerk.mean.z
* t.body.gyro.jerk.std.x
* t.body.gyro.jerk.std.y
* t.body.gyro.jerk.std.z
* f.body.acc.mean.x
* f.body.acc.mean.y
* f.body.acc.mean.z
* f.body.acc.std.x
* f.body.acc.std.y
* f.body.acc.std.z
* f.body.acc.jerk.mean.x
* f.body.acc.jerk.mean.y
* f.body.acc.jerk.mean.z
* f.body.acc.jerk.std.x
* f.body.acc.jerk.std.y
* f.body.acc.jerk.std.z
* f.body.gyro.mean.x
* f.body.gyro.mean.y
* f.body.gyro.mean.z
* f.body.gyro.std.x
* f.body.gyro.std.y
* f.body.gyro.std.z

### Study Design
UCI HAR Activities Averages dataset derives from the original UCI HAR Activities available for download from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. It contains a summary (mean) for every mean and standard deviation measurement available in the original dataset. 

Measurements were selected from the file **UCI HAR Activities/features.txt** through a regexp filter that accepts only names containing _-mean()_ or _-std()_. 

Files from train and test splits containing the subjects identification (subject_train.txt and subject_test.txt), measures (X_train.txt and X_test.txt) and activity performed (y_train.txt and y_test.txt) were combined into a single data frame using the following schema:

subject           | activity    | measures
----------------- | ----------- | -----------
subject_train.txt | y_train.txt | X_train.txt
subject_test.txt  | y_test.txt  | X_test.txt

All train files are under **UCI HAR Dataset/train/** directory, and test files are under **UCI HAR Dataset/test/** directory.

Activity id was then replaced by activity label got from file **UCI HAR Dataset/activity_labels.txt**

Observations were grouped by subject and activity, with every measurement summarized by its average (mean).

The resulting dataset is then saved in the working directory in CSV (text) format, named as **activities_averages.csv**