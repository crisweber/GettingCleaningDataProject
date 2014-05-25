### UCI HAR Activities Averages Instructions
* To perform this analysis you first have to download the UCI HAR Dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and then unzip to your working directory.

* Start a new R session. 

* Make sure that you have reshape2 package installed
```
find.package("reshape2")
```
* If you see the message __there is no package called reshape2__ then install it using this command

```
install.package("reshape2")
```

* Set your working directory using `setwd` as follows (replacing YOUR_DIRECTORY with the directory where you downloaded and extracted the UCI HAR Dataset):
```
setwd(YOUR_DIRECTORY)
```
  
  
* Execute the script run_analysis.R using `source` as follows (replacing PATH_TO with the directory where you downloaded the run_analysis.R file):
```
source(PATH_TO/run_analysis.R)
```

* A new file called **activities_averages.csv** will be created in your working directory.


****
  
  
If your working directory does not contains the UCI HAR Dataset you will see this message:  
**UCI HAR Dataset directory in not available under current working directory.**
